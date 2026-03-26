import { createServiceClient, jsonResponse, requiredEnv } from '../_shared/email-runtime.ts'

function timingSafeEqual(left: string, right: string) {
  const leftBytes = new TextEncoder().encode(left)
  const rightBytes = new TextEncoder().encode(right)

  if (leftBytes.length !== rightBytes.length) {
    return false
  }

  let mismatch = 0
  for (let index = 0; index < leftBytes.length; index += 1) {
    mismatch |= leftBytes[index] ^ rightBytes[index]
  }

  return mismatch === 0
}

Deno.serve(async (req: Request) => {
  if (req.method !== 'POST') {
    return jsonResponse({ error: 'Method not allowed' }, 405)
  }

  try {
    const provider = Deno.env.get('TRANSACTIONAL_EMAIL_PROVIDER')?.trim().toLowerCase() || ''
    const expectedSignature = requiredEnv('TRANSACTIONAL_EMAIL_PROVIDER_WEBHOOK_SECRET')
    const signature = req.headers.get('x-transactional-email-signature') ??
      req.headers.get('x-brevo-signature') ??
      req.headers.get('x-brevo-event-signature')
    if (signature == null || !timingSafeEqual(signature, expectedSignature)) {
      return jsonResponse({ error: 'Invalid webhook signature' }, 401)
    }

    const rawPayload = await req.json() as {
      provider_message_id?: string
      status?: string
      error_code?: string | null
      error_message?: string | null
      event?: string
      ['message-id']?: string
      reason?: string | null
    }

    const payload = normalizeProviderWebhookPayload(provider, rawPayload)

    if (!payload.provider_message_id || !payload.status) {
      return jsonResponse({
        error: 'provider_message_id and status are required',
      }, 400)
    }

    const allowedStatuses = new Set([
      'sent',
      'delivered',
      'opened',
      'clicked',
      'soft_failed',
      'hard_failed',
      'bounced',
      'suppressed',
    ])

    if (!allowedStatuses.has(payload.status)) {
      return jsonResponse({ error: 'Unsupported provider status' }, 400)
    }

    const serviceClient = createServiceClient()
    const { data, error } = await serviceClient.rpc(
      'record_email_provider_event',
      {
        p_provider_message_id: payload.provider_message_id,
        p_status: payload.status,
        p_error_code: payload.error_code ?? null,
        p_error_message: payload.error_message ?? null,
      },
    )

    if (error != null) {
      console.error('record_email_provider_event failed', error)
      return jsonResponse({ error: 'Failed to record provider event' }, 500)
    }

    return jsonResponse({ delivery_log: data })
  } catch (error) {
    console.error('email-provider-webhook failed', error)
    return jsonResponse({ error: 'Internal server error' }, 500)
  }
})

function normalizeGenericPayload(payload: {
  provider_message_id?: string
  status?: string
  error_code?: string | null
  error_message?: string | null
}) {
  return payload
}

const providerWebhookNormalizers: Record<string, (payload: {
  event?: string
  ['message-id']?: string
  reason?: string | null
}) => {
  provider_message_id?: string
  status?: string
  error_code?: string | null
  error_message?: string | null
}> = {
  brevo: (payload) => {
    const normalizedEvent = payload.event?.trim()
    const statusByEvent: Record<string, string> = {
      request: 'sent',
      sent: 'sent',
      delivered: 'delivered',
      opened: 'opened',
      uniqueOpened: 'opened',
      click: 'clicked',
      hardBounce: 'hard_failed',
      softBounce: 'soft_failed',
      blocked: 'suppressed',
      invalid: 'bounced',
      deferred: 'soft_failed',
      spam: 'suppressed',
      unsubscribed: 'suppressed',
    }

    return {
      provider_message_id: payload['message-id'],
      status: normalizedEvent == null ? undefined : statusByEvent[normalizedEvent],
      error_code: normalizedEvent ?? null,
      error_message: payload.reason ?? null,
    }
  },
}

function normalizeProviderWebhookPayload(
  provider: string,
  payload: {
    provider_message_id?: string
    status?: string
    error_code?: string | null
    error_message?: string | null
    event?: string
    ['message-id']?: string
    reason?: string | null
  },
) {
  const normalizer = providerWebhookNormalizers[provider]
  if (normalizer == null) {
    return normalizeGenericPayload(payload)
  }
  return normalizer(payload)
}
