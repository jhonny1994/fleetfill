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

export type EmailDispatchResult = {
  provider: string
  providerMessageId: string
  subjectPreview: string
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
      return supportSubject ?? 'تم استلام طلب الدعم'
    case 'support_request_forwarded':
      return supportSubject == null ? 'طلب دعم جديد' : `طلب دعم جديد - ${supportSubject}`
    case 'booking_confirmed':
      return bookingReference == null
        ? 'تم تأكيد الحجز'
        : `تم تأكيد الحجز - ${bookingReference}`
    case 'payment_proof_received':
      return bookingReference == null
        ? 'تم استلام إثبات الدفع'
        : `تم استلام إثبات الدفع - ${bookingReference}`
    case 'payment_rejected':
      return bookingReference == null
        ? 'تم رفض إثبات الدفع'
        : `تم رفض إثبات الدفع - ${bookingReference}`
    case 'payment_secured':
      return bookingReference == null
        ? 'تم تأمين الدفع'
        : `تم تأمين الدفع - ${bookingReference}`
    case 'delivered_pending_review':
      return bookingReference == null
        ? 'تم التسليم وبانتظار المراجعة'
        : `تم التسليم وبانتظار المراجعة - ${bookingReference}`
    case 'dispute_opened':
      return bookingReference == null
        ? 'تم فتح نزاع'
        : `تم فتح نزاع - ${bookingReference}`
    case 'dispute_resolved':
      return bookingReference == null
        ? 'تم حل النزاع'
        : `تم حل النزاع - ${bookingReference}`
    case 'payout_released':
      return bookingReference == null
        ? 'تم صرف مستحق الناقل'
        : `تم صرف مستحق الناقل - ${bookingReference}`
    case 'generated_document_available':
      return bookingReference == null
        ? 'المستند جاهز'
        : `المستند جاهز - ${bookingReference}`
    default:
      return templateKey.replaceAll('_', ' ')
  }
}

export function computeRetryDelaySeconds(attemptCount: number) {
  const safeAttemptCount = Math.max(1, attemptCount)
  return Math.min(300 * safeAttemptCount, 3600)
}

function sanitizePayloadValue(value: JsonValue): JsonValue {
  if (Array.isArray(value)) {
    return value.map(sanitizePayloadValue)
  }

  if (value != null && typeof value === 'object') {
    const entries = Object.entries(value)
      .filter(([key, candidate]) => {
        const lowerKey = key.toLowerCase()
        return !lowerKey.includes('token') && !lowerKey.includes('secret') &&
          !lowerKey.includes('password') && candidate !== null
      })
      .map(([key, candidate]) => [key, sanitizePayloadValue(candidate)])
    return Object.fromEntries(entries)
  }

  return value
}

function escapeHtml(value: string) {
  return value
    .replaceAll('&', '&amp;')
    .replaceAll('<', '&lt;')
    .replaceAll('>', '&gt;')
    .replaceAll('"', '&quot;')
    .replaceAll("'", '&#39;')
}

function payloadText(
  payload: Record<string, JsonValue>,
  key: string,
) {
  const value = payload[key]
  return typeof value === 'string' && value.trim().length > 0 ? value.trim() : null
}

function payloadNumber(
  payload: Record<string, JsonValue>,
  key: string,
) {
  const value = payload[key]
  return typeof value === 'number' ? value : null
}

function arabicDocumentType(documentType: string | null) {
  switch (documentType) {
    case 'booking_invoice':
      return 'فاتورة الحجز'
    case 'payment_receipt':
      return 'إيصال الدفع'
    case 'payout_receipt':
      return 'إيصال التحويل'
    default:
      return 'المستند'
  }
}

function arabicResolution(resolution: string | null) {
  switch (resolution) {
    case 'completed':
      return 'تم اعتماد الحجز كمكتمل'
    case 'refunded':
      return 'تم اعتماد رد المبلغ'
    default:
      return 'تمت معالجة النزاع'
  }
}

function formatAmount(amount: number | null) {
  if (amount == null) {
    return null
  }
  return `${amount.toFixed(2)} دج`
}

function buildArabicEmailContent(job: OutboxJob, subjectPreview: string) {
  const payload = sanitizePayloadValue(job.payload_snapshot ?? {}) as Record<string, JsonValue>
  const bookingReference = payloadText(payload, 'booking_reference')
  const subject = payloadText(payload, 'subject')
  const message = payloadText(payload, 'message')
  const rejectionReason = payloadText(payload, 'rejection_reason')
  const documentType = arabicDocumentType(payloadText(payload, 'document_type'))
  const resolution = arabicResolution(payloadText(payload, 'resolution'))
  const payoutAmount = formatAmount(payloadNumber(payload, 'payout_amount_dzd'))
  const refundAmount = formatAmount(payloadNumber(payload, 'refund_amount_dzd'))

  let intro = 'لديك تحديث جديد من FleetFill.'
  let action = 'يرجى مراجعة تطبيق FleetFill للاطلاع على التفاصيل واتخاذ الإجراء اللازم عند الحاجة.'
  const details: Array<[string, string]> = []

  if (bookingReference != null) {
    details.push(['مرجع الحجز', bookingReference])
  }

  switch (job.template_key) {
    case 'support_acknowledgement':
      intro = 'تم استلام طلب الدعم الخاص بك بنجاح وسيقوم فريق FleetFill بالرد عليك في أقرب وقت ممكن.'
      action = 'احتفظ بهذه الرسالة كمرجع، وسنوافيك بالتحديثات عند الحاجة.'
      if (subject != null) {
        details.push(['موضوع الرسالة', subject])
      }
      break
    case 'support_request_forwarded':
      intro = 'تم إرسال طلب دعم جديد إلى صندوق الدعم المعتمد في FleetFill.'
      action = 'يرجى متابعة الطلب والرد عليه حسب أولوية الحالة.'
      if (subject != null) {
        details.push(['موضوع الرسالة', subject])
      }
      if (message != null) {
        details.push(['نص الرسالة', message])
      }
      if (payloadText(payload, 'sender_email') != null) {
        details.push(['بريد المرسل', payloadText(payload, 'sender_email')!])
      }
      break
    case 'booking_confirmed':
      intro = 'تم تأكيد الحجز بنجاح بعد استكمال خطواته الأساسية.'
      break
    case 'payment_proof_received':
      intro = 'تم استلام إثبات الدفع الخاص بك وهو الآن بانتظار المراجعة الإدارية.'
      action = 'لا حاجة إلى إعادة الإرسال حاليا ما لم يطلب منك ذلك داخل التطبيق.'
      break
    case 'payment_rejected':
      intro = 'تمت مراجعة إثبات الدفع، ولا يمكن قبوله بصيغته الحالية.'
      action = 'يرجى مراجعة سبب الرفض وإعادة إرسال إثبات صحيح من داخل التطبيق قبل انتهاء المهلة.'
      if (rejectionReason != null) {
        details.push(['سبب الرفض', rejectionReason])
      }
      break
    case 'payment_secured':
      intro = 'تم تأمين الدفع بنجاح وأصبح الحجز في المرحلة التشغيلية التالية.'
      action = 'يمكنك متابعة تقدم الحجز من داخل التطبيق.'
      break
    case 'delivered_pending_review':
      intro = 'تم تعليم الشحنة على أنها مُسلّمة وهي الآن ضمن فترة المراجعة.'
      action = 'إذا كان كل شيء سليما يمكنك تأكيد التسليم، وإذا وجدت مشكلة يمكنك فتح نزاع خلال نافذة المراجعة.'
      break
    case 'dispute_opened':
      intro = 'تم فتح نزاع مرتبط بهذا الحجز وهو الآن قيد المراجعة.'
      action = 'يرجى متابعة آخر المستجدات داخل التطبيق وتجهيز أي معلومات إضافية إذا لزم الأمر.'
      break
    case 'dispute_resolved':
      intro = `تم حل النزاع. ${resolution}.`
      action = 'راجع حالة الحجز والدفع داخل التطبيق للاطلاع على النتيجة النهائية.'
      if (refundAmount != null) {
        details.push(['قيمة المبلغ المعاد', refundAmount])
      }
      break
    case 'payout_released':
      intro = 'تم صرف مستحق الناقل لهذا الحجز.'
      action = 'راجع تفاصيل التحويل وسجل الدفعات داخل التطبيق.'
      if (payoutAmount != null) {
        details.push(['قيمة التحويل', payoutAmount])
      }
      break
    case 'generated_document_available':
      intro = `أصبح ${documentType} جاهزا للعرض أو التنزيل بشكل آمن.`
      action = 'افتح التطبيق للوصول إلى المستند من المسار الآمن المخصص له.'
      details.push(['نوع المستند', documentType])
      break
    default:
      break
  }

  const textLines = [
    subjectPreview,
    '',
    intro,
    '',
    action,
  ]
  if (details.isNotEmpty) {
    textLines.push('', 'التفاصيل:')
    for (const [label, value] of details) {
      textLines.push(`- ${label}: ${value}`)
    }
  }
  textLines.push('', 'مع تحيات فريق FleetFill')
  const textContent = textLines.join('\n')

  const htmlDetails = details.isEmpty
    ? ''
    : `<div style="margin-top:24px;"><h2 style="margin:0 0 12px;font-size:16px;">التفاصيل</h2><table style="width:100%;border-collapse:collapse;">${
      details.map(([label, value]) =>
        `<tr><td style="padding:8px 0;color:#666;vertical-align:top;width:34%;">${escapeHtml(label)}</td><td style="padding:8px 0;color:#111;">${escapeHtml(value)}</td></tr>`
      ).join('')
    }</table></div>`

  const htmlContent =
    `<!doctype html><html lang="ar" dir="rtl"><body style="margin:0;padding:24px;background:#f6f6f6;color:#111;font-family:Tahoma, Arial, sans-serif;"><div style="max-width:640px;margin:0 auto;background:#ffffff;border-radius:16px;padding:28px;"><div style="font-size:13px;color:#777;margin-bottom:12px;">FleetFill</div><h1 style="margin:0 0 16px;font-size:24px;line-height:1.5;">${
      escapeHtml(subjectPreview)
    }</h1><p style="margin:0 0 12px;line-height:1.9;">${escapeHtml(intro)}</p><p style="margin:0;line-height:1.9;">${escapeHtml(action)}</p>${htmlDetails}<p style="margin:28px 0 0;color:#666;line-height:1.8;">مع تحيات فريق FleetFill</p></div></body></html>`

  return {
    payload,
    textContent,
    htmlContent,
    locale: 'ar',
  }
}

type ProviderApiAdapter = {
  authHeaderName: string
  providerMessageIdField: string
  buildRequestBody: (
    job: OutboxJob,
    sender: string,
    senderName: string,
    subjectPreview: string,
  ) => Record<string, JsonValue>
}

function buildProviderApiRequestBody(
  job: OutboxJob,
  sender: string,
  senderName: string,
  subjectPreview: string,
) {
  const { payload, textContent, htmlContent, locale } = buildArabicEmailContent(job, subjectPreview)

  return {
    sender: {
      email: sender,
      name: senderName,
    },
    to: [{ email: job.recipient_email }],
    subject: subjectPreview,
    textContent,
    htmlContent,
    tags: [job.template_key, `locale:${locale}`],
    headers: {
      'X-Provider-Custom': [
        `provider_message_key:${job.id}`,
        `dedupe_key:${job.dedupe_key}`,
        `template_key:${job.template_key}`,
      ].join('|'),
    },
    params: {
      locale,
      template_key: job.template_key,
      dedupe_key: job.dedupe_key,
      payload,
    },
  }
}

const providerApiAdapters: Record<string, ProviderApiAdapter> = {
  brevo: {
    authHeaderName: 'api-key',
    providerMessageIdField: 'messageId',
    buildRequestBody: buildProviderApiRequestBody,
  },
}

async function dispatchProviderApiEmail(
  job: OutboxJob,
  provider: string,
  subjectPreview: string,
  sender: string,
  senderName: string,
): Promise<EmailDispatchResult> {
  const adapter = providerApiAdapters[provider]
  if (adapter == null) {
    throw new Error(`unsupported_provider:Unsupported transactional email provider: ${provider}`)
  }

  const apiKey = requiredEnv('TRANSACTIONAL_EMAIL_PROVIDER_API_KEY')
  const endpoint = requiredEnv('TRANSACTIONAL_EMAIL_PROVIDER_ENDPOINT')
  const response = await fetch(endpoint, {
    method: 'POST',
    headers: {
      [adapter.authHeaderName]: apiKey,
      'content-type': 'application/json',
      accept: 'application/json',
    },
    body: JSON.stringify(adapter.buildRequestBody(job, sender, senderName, subjectPreview)),
  })

  const responseText = await response.text()
  let responseBody: Record<string, JsonValue> = {}
  try {
    responseBody = responseText ? JSON.parse(responseText) as Record<string, JsonValue> : {}
  } catch (_) {
    responseBody = {}
  }

  if (!response.ok) {
    const errorCode = typeof responseBody.code === 'string'
      ? responseBody.code
      : `http_${response.status}`
    const errorMessage = typeof responseBody.message === 'string'
      ? responseBody.message
      : responseText || `Email provider request failed with ${response.status}`
    throw new Error(`${errorCode}:${errorMessage}`)
  }

  const providerMessageIdValue = responseBody[adapter.providerMessageIdField]
  const providerMessageId = typeof providerMessageIdValue === 'string'
    ? providerMessageIdValue
    : `${provider}-${job.id}`

  return {
    provider,
    providerMessageId,
    subjectPreview,
  }
}

async function dispatchGenericEmail(
  job: OutboxJob,
  provider: string,
  subjectPreview: string,
  sender: string,
  senderName: string,
): Promise<EmailDispatchResult> {
  const apiKey = requiredEnv('TRANSACTIONAL_EMAIL_PROVIDER_API_KEY')
  const response = await fetch(requiredEnv('TRANSACTIONAL_EMAIL_PROVIDER_ENDPOINT'), {
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
      payload: job.payload_snapshot ?? {},
      dedupe_key: job.dedupe_key,
    }),
  })

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

export async function dispatchEmail(job: OutboxJob) {
  const provider = requiredEnv('TRANSACTIONAL_EMAIL_PROVIDER').trim().toLowerCase()
  const sender = requiredEnv('TRANSACTIONAL_EMAIL_FROM_EMAIL')
  const senderName = Deno.env.get('TRANSACTIONAL_EMAIL_FROM_NAME')?.trim() ||
    'FleetFill'

  const shouldMockSend = isTruthyEnv('TRANSACTIONAL_EMAIL_MOCK_MODE')
  const subjectPreview = buildSubjectPreview(job.template_key, job.payload_snapshot ?? {})

  if (shouldMockSend) {
    return {
      provider,
      providerMessageId: `mock-${job.id}`,
      subjectPreview,
    }
  }

  if (provider in providerApiAdapters) {
    return dispatchProviderApiEmail(job, provider, subjectPreview, sender, senderName)
  }

  return dispatchGenericEmail(job, provider, subjectPreview, sender, senderName)
}
