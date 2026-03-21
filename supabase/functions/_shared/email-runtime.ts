import { createClient } from 'https://esm.sh/@supabase/supabase-js@2.57.4'

export { createClient }

export type JsonValue = string | number | boolean | null | JsonValue[] | {
  [key: string]: JsonValue
}

export type OutboxJob = {
  id: string
  event_key: string
  dedupe_key: string
  profile_id: string | null
  booking_id: string | null
  template_key: string
  locale: string
  recipient_email: string
  priority: string
  status: string
  attempt_count: number
  max_attempts: number
  available_at: string
  locked_at: string | null
  locked_by: string | null
  payload_snapshot: Record<string, JsonValue> | null
}

export function jsonResponse(body: Record<string, unknown>, status = 200) {
  return new Response(JSON.stringify(body), {
    status,
    headers: { 'content-type': 'application/json' },
  })
}

export function requiredEnv(name: string) {
  const value = Deno.env.get(name)?.trim()
  if (!value) {
    throw new Error(`Missing required environment variable: ${name}`)
  }
  return value
}

export function normalizeSupportedLocale(locale: string | null | undefined) {
  const normalized = locale?.trim().toLowerCase()
  if (normalized === 'ar' || normalized === 'fr' || normalized === 'en') {
    return normalized
  }
  return 'en'
}

export function createServiceClient() {
  return createClient(
    requiredEnv('SUPABASE_URL'),
    requiredEnv('SUPABASE_SERVICE_ROLE_KEY'),
  )
}

export function isTruthyEnv(name: string) {
  const value = Deno.env.get(name)?.trim().toLowerCase()
  return value === 'true' || value === '1' || value === 'yes'
}

export function inferDeliveryStatus(errorCode: string | null) {
  if (errorCode == null) {
    return 'soft_failed'
  }

  const normalized = errorCode.toLowerCase()
  if (normalized.includes('bounce') || normalized.includes('invalid')) {
    return 'bounced'
  }
  if (normalized.includes('suppress')) {
    return 'suppressed'
  }
  if (normalized.includes('hard')) {
    return 'hard_failed'
  }

  return 'soft_failed'
}

export function buildSubjectPreview(
  templateKey: string,
  payload: Record<string, JsonValue> | null,
) {
  const bookingReference = typeof payload?.booking_reference === 'string'
    ? payload.booking_reference
    : null
  const supportSubject = typeof payload?.subject === 'string' ? payload.subject : null

  switch (templateKey) {
    case 'support_acknowledgement':
      return supportSubject ?? 'Support acknowledgement'
    case 'support_request_forwarded':
      return supportSubject == null ? 'Support request' : `Support request - ${supportSubject}`
    case 'booking_confirmed':
      return bookingReference == null
        ? 'Booking confirmed'
        : `Booking confirmed - ${bookingReference}`
    case 'payment_proof_received':
      return bookingReference == null
        ? 'Payment proof received'
        : `Payment proof received - ${bookingReference}`
    case 'payment_rejected':
      return bookingReference == null
        ? 'Payment rejected'
        : `Payment rejected - ${bookingReference}`
    case 'payment_secured':
      return bookingReference == null
        ? 'Payment secured'
        : `Payment secured - ${bookingReference}`
    case 'delivered_pending_review':
      return bookingReference == null
        ? 'Delivery pending review'
        : `Delivery pending review - ${bookingReference}`
    case 'dispute_opened':
      return bookingReference == null
        ? 'Dispute opened'
        : `Dispute opened - ${bookingReference}`
    case 'dispute_resolved':
      return bookingReference == null
        ? 'Dispute resolved'
        : `Dispute resolved - ${bookingReference}`
    case 'payout_released':
      return bookingReference == null
        ? 'Payout released'
        : `Payout released - ${bookingReference}`
    case 'generated_document_available':
      return bookingReference == null
        ? 'Generated document available'
        : `Generated document available - ${bookingReference}`
    default:
      return templateKey.replaceAll('_', ' ')
  }
}

export function computeRetryDelaySeconds(attemptCount: number) {
  const safeAttemptCount = Math.max(1, attemptCount)
  return Math.min(300 * safeAttemptCount, 3600)
}

export async function dispatchEmail(job: OutboxJob) {
  const provider = requiredEnv('TRANSACTIONAL_EMAIL_PROVIDER')
  const sender = requiredEnv('TRANSACTIONAL_EMAIL_FROM_EMAIL')
  const senderName = Deno.env.get('TRANSACTIONAL_EMAIL_FROM_NAME')?.trim() ||
    'FleetFill'

  const shouldMockSend = isTruthyEnv('TRANSACTIONAL_EMAIL_MOCK_MODE')
  const payload = job.payload_snapshot ?? {}
  const subjectPreview = buildSubjectPreview(job.template_key, payload)

  if (shouldMockSend) {
    return {
      provider,
      providerMessageId: `mock-${job.id}`,
      subjectPreview,
    }
  }

  const apiKey = requiredEnv('TRANSACTIONAL_EMAIL_PROVIDER_API_KEY')
  const response = await fetch(
    requiredEnv('TRANSACTIONAL_EMAIL_PROVIDER_ENDPOINT'),
    {
      method: 'POST',
      headers: {
        Authorization: `Bearer ${apiKey}`,
        'content-type': 'application/json',
      },
      body: JSON.stringify({
        provider,
        from: {
          email: sender,
          name: senderName,
        },
        to: [job.recipient_email],
        template_key: job.template_key,
        locale: normalizeSupportedLocale(job.locale),
        subject_preview: subjectPreview,
        payload,
        dedupe_key: job.dedupe_key,
      }),
    },
  )

  const responseText = await response.text()
  let responseBody: Record<string, JsonValue> = {}
  try {
    responseBody = responseText ? JSON.parse(responseText) as Record<string, JsonValue> : {}
  } catch (_) {
    responseBody = {}
  }

  if (!response.ok) {
    const errorCode = typeof responseBody.error_code === 'string'
      ? responseBody.error_code
      : `http_${response.status}`
    const errorMessage = typeof responseBody.error_message === 'string'
      ? responseBody.error_message
      : responseText || `Email provider request failed with ${response.status}`
    throw new Error(`${errorCode}:${errorMessage}`)
  }

  const providerMessageId = typeof responseBody.provider_message_id === 'string'
    ? responseBody.provider_message_id
    : `provider-${job.id}`

  return {
    provider,
    providerMessageId,
    subjectPreview,
  }
}
