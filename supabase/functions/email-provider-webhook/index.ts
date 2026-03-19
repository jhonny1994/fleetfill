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

Deno.serve(async (req) => {
  if (req.method !== 'POST') {
    return jsonResponse({ error: 'Method not allowed' }, 405)
  }

  try {
    const signature = req.headers.get('x-transactional-email-signature')
    const expectedSignature = requiredEnv('TRANSACTIONAL_EMAIL_PROVIDER_WEBHOOK_SECRET')
    if (signature == null || !timingSafeEqual(signature, expectedSignature)) {
      return jsonResponse({ error: 'Invalid webhook signature' }, 401)
    }

    const payload = await req.json() as {
      provider_message_id?: string
      status?: string
      error_code?: string | null
      error_message?: string | null
    }

    if (!payload.provider_message_id || !payload.status) {
      return jsonResponse({ error: 'provider_message_id and status are required' }, 400)
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
    const { data, error } = await serviceClient.rpc('record_email_provider_event', {
      p_provider_message_id: payload.provider_message_id,
      p_status: payload.status,
      p_error_code: payload.error_code ?? null,
      p_error_message: payload.error_message ?? null,
    })

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
