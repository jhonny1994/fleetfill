import { createClient } from 'https://esm.sh/@supabase/supabase-js@2.57.4'

export { createClient }

export type JsonValue =
  | string
  | number
  | boolean
  | null
  | JsonValue[]
  | { [key: string]: JsonValue }

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
  template_language_code?: string | null
  payload_snapshot: Record<string, JsonValue> | null
}

export type EmailTemplateRecord = {
  template_key: string
  language_code: string
  subject_template: string
  html_template: string
  text_template: string
  sample_payload: Record<string, JsonValue>
  description: string | null
  is_enabled: boolean
}

export type RenderedEmailContent = {
  payload: Record<string, JsonValue>
  subjectPreview: string
  textContent: string
  htmlContent: string
  templateLanguageCode: string
}

export type EmailDispatchResult = {
  provider: string
  providerMessageId: string
  subjectPreview: string
  templateLanguageCode: string
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
  if (normalized != null && normalized.length > 0) {
    return normalized
  }
  return 'ar'
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
  if (normalized === 'render_failed' || normalized.includes('template')) {
    return 'render_failed'
  }
  if (normalized.includes('bounce') || normalized.includes('invalid')) {
    return 'bounced'
  }
  if (normalized.includes('suppress') || normalized.includes('block') || normalized.includes('spam')) {
    return 'suppressed'
  }
  if (normalized.includes('hard')) {
    return 'hard_failed'
  }

  return 'soft_failed'
}

export function computeRetryDelaySeconds(attemptCount: number) {
  const safeAttemptCount = Math.max(1, attemptCount)
  return Math.min(300 * (2 ** (safeAttemptCount - 1)), 3600)
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

function payloadText(payload: Record<string, JsonValue>, key: string) {
  const value = payload[key]
  return typeof value === 'string' && value.trim().length > 0 ? value.trim() : null
}

function payloadNumber(payload: Record<string, JsonValue>, key: string) {
  const value = payload[key]
  return typeof value === 'number' ? value : null
}

function localizedDocumentType(
  documentType: string | null,
  locale: string,
) {
  switch (documentType) {
    case 'payment_receipt':
      switch (locale) {
        case 'fr':
          return 'recu de paiement'
        case 'en':
          return 'payment receipt'
        default:
          return 'إيصال الدفع'
      }
    case 'payout_receipt':
      switch (locale) {
        case 'fr':
          return 'recu de versement'
        case 'en':
          return 'payout receipt'
        default:
          return 'إيصال التحويل'
      }
    default:
      switch (locale) {
        case 'fr':
          return 'document'
        case 'en':
          return 'document'
        default:
          return 'المستند'
      }
  }
}

function localizedResolution(
  resolution: string | null,
  locale: string,
) {
  switch (resolution) {
    case 'completed':
      switch (locale) {
        case 'fr':
          return 'La reservation a ete validee comme terminee.'
        case 'en':
          return 'The booking was resolved as completed.'
        default:
          return 'تم اعتماد الحجز كمكتمل'
      }
    case 'refunded':
      switch (locale) {
        case 'fr':
          return 'Le remboursement a ete approuve.'
        case 'en':
          return 'The refund was approved.'
        default:
          return 'تم اعتماد رد المبلغ'
      }
    default:
      switch (locale) {
        case 'fr':
          return 'Le litige a ete traite.'
        case 'en':
          return 'The dispute was processed.'
        default:
          return 'تمت معالجة النزاع'
      }
  }
}

function formatAmount(amount: number | null) {
  if (amount == null) {
    return null
  }
  return `${amount.toFixed(2)} DZD`
}

function normalizeRequestedLanguageCode(job: OutboxJob) {
  const explicitLanguage = job.template_language_code?.trim().toLowerCase()
  if (explicitLanguage != null && explicitLanguage.length > 0) {
    return explicitLanguage
  }
  return normalizeSupportedLocale(job.locale)
}

function buildMergedPayload(
  jobPayload: Record<string, JsonValue> | null,
  samplePayload: Record<string, JsonValue>,
) {
  return {
    ...sanitizePayloadValue(samplePayload) as Record<string, JsonValue>,
    ...sanitizePayloadValue(jobPayload ?? {}) as Record<string, JsonValue>,
  }
}

function buildTemplatePlaceholders(
  job: OutboxJob,
  payload: Record<string, JsonValue>,
  templateLanguageCode: string,
) {
  const placeholders: Record<string, string> = {}

  for (const [key, value] of Object.entries(payload)) {
    if (typeof value === 'string' && value.trim().length > 0) {
      placeholders[key] = value.trim()
    } else if (typeof value === 'number' || typeof value === 'boolean') {
      placeholders[key] = String(value)
    }
  }

  const bookingReference = payloadText(payload, 'booking_reference')
  const subject = payloadText(payload, 'subject')
  const message = payloadText(payload, 'message')
  const senderEmail = payloadText(payload, 'sender_email')
  const rejectionReason = payloadText(payload, 'rejection_reason')
  const documentRoute = payloadText(payload, 'document_route')

  if (bookingReference != null) {
    placeholders.booking_reference = bookingReference
  }
  if (subject != null) {
    placeholders.subject = subject
  }
  if (message != null) {
    placeholders.message = message
  }
  if (senderEmail != null) {
    placeholders.sender_email = senderEmail
  }
  if (rejectionReason != null) {
    placeholders.rejection_reason = rejectionReason
  }
  if (documentRoute != null) {
    placeholders.document_route = documentRoute
  }

  placeholders.template_key = job.template_key
  placeholders.event_key = job.event_key
  placeholders.recipient_email = job.recipient_email
  placeholders.requested_locale = normalizeSupportedLocale(job.locale)
  placeholders.template_language_code = templateLanguageCode
  placeholders.reason_summary = payloadText(payload, 'reason') ??
    (templateLanguageCode === 'fr'
      ? 'non precise'
      : templateLanguageCode === 'en'
      ? 'not specified'
      : 'غير محدد')
  placeholders.resolution_summary = localizedResolution(
    payloadText(payload, 'resolution'),
    templateLanguageCode,
  )
  placeholders.document_type_label = localizedDocumentType(
    payloadText(payload, 'document_type'),
    templateLanguageCode,
  )
  placeholders.payout_amount_label = formatAmount(
    payloadNumber(payload, 'payout_amount_dzd'),
  ) ?? (templateLanguageCode === 'fr'
    ? 'non disponible'
    : templateLanguageCode === 'en'
    ? 'not available'
    : 'غير متوفر')
  placeholders.refund_amount_label = formatAmount(
    payloadNumber(payload, 'refund_amount_dzd'),
  ) ?? (templateLanguageCode === 'fr'
    ? 'sans objet'
    : templateLanguageCode === 'en'
    ? 'not applicable'
    : 'غير مطبق')

  return placeholders
}

const templatePlaceholderPattern = /{{\s*([a-zA-Z0-9_]+)\s*}}/g

function collectMissingTemplatePlaceholders(
  template: EmailTemplateRecord,
  placeholders: Record<string, string>,
) {
  const missing = new Set<string>()
  for (const candidate of [
    template.subject_template,
    template.html_template,
    template.text_template,
  ]) {
    for (const match of candidate.matchAll(templatePlaceholderPattern)) {
      const key = match[1]
      if (!(key in placeholders)) {
        missing.add(key)
      }
    }
  }
  return [...missing].sort()
}

function renderTemplateString(
  template: string,
  placeholders: Record<string, string>,
  escapeForHtml: boolean,
) {
  return template.replaceAll(templatePlaceholderPattern, (_match, key: string) => {
    const value = placeholders[key]
    return escapeForHtml ? escapeHtml(value) : value
  })
}

export async function loadEmailTemplate(
  templateKey: string,
  languageCode: string,
  serviceClient = createServiceClient(),
) {
  const selectClause =
    'template_key,language_code,subject_template,html_template,text_template,sample_payload,description,is_enabled'

  const tryLoad = async (candidateLanguageCode: string) => {
    const { data, error } = await serviceClient
      .from('email_templates')
      .select(selectClause)
      .eq('template_key', templateKey)
      .eq('language_code', candidateLanguageCode)
      .eq('is_enabled', true)
      .maybeSingle()

    if (error != null) {
      throw new Error(`render_failed:${error.message}`)
    }

    if (data == null) {
      return null
    }

    return {
      template_key: data.template_key as string,
      language_code: data.language_code as string,
      subject_template: data.subject_template as string,
      html_template: data.html_template as string,
      text_template: data.text_template as string,
      sample_payload: ((data.sample_payload as Record<string, JsonValue> | null) ?? {}),
      description: (data.description as string | null) ?? null,
      is_enabled: data.is_enabled as boolean,
    } satisfies EmailTemplateRecord
  }

  const preferredTemplate = await tryLoad(languageCode)
  if (preferredTemplate != null) {
    return preferredTemplate
  }

  if (languageCode !== 'ar') {
    const fallbackTemplate = await tryLoad('ar')
    if (fallbackTemplate != null) {
      return fallbackTemplate
    }
  }

  throw new Error(
    `render_failed:Enabled email template not found for ${templateKey} (${languageCode})`,
  )
}

export async function resolveAndRenderEmailContent(
  job: OutboxJob,
  serviceClient = createServiceClient(),
): Promise<RenderedEmailContent> {
  const templateLanguageCode = normalizeRequestedLanguageCode(job)
  const template = await loadEmailTemplate(
    job.template_key,
    templateLanguageCode,
    serviceClient,
  )
  const payload = buildMergedPayload(job.payload_snapshot, template.sample_payload)
  const placeholders = buildTemplatePlaceholders(job, payload, template.language_code)
  const missingPlaceholders = collectMissingTemplatePlaceholders(
    template,
    placeholders,
  )

  if (missingPlaceholders.length > 0) {
    throw new Error(
      `render_failed:Missing placeholders for ${job.template_key}: ${missingPlaceholders.join(', ')}`,
    )
  }

  return {
    payload,
    subjectPreview: renderTemplateString(
      template.subject_template,
      placeholders,
      false,
    ),
    htmlContent: renderTemplateString(
      template.html_template,
      placeholders,
      true,
    ),
    textContent: renderTemplateString(
      template.text_template,
      placeholders,
      false,
    ),
    templateLanguageCode: template.language_code,
  }
}

type ProviderApiAdapter = {
  authHeaderName: string
  providerMessageIdField: string
  buildRequestBody: (
    job: OutboxJob,
    sender: string,
    senderName: string,
    rendered: RenderedEmailContent,
  ) => Record<string, JsonValue>
}

function buildProviderApiRequestBody(
  job: OutboxJob,
  sender: string,
  senderName: string,
  rendered: RenderedEmailContent,
) {
  return {
    sender: {
      email: sender,
      name: senderName,
    },
    to: [{ email: job.recipient_email }],
    subject: rendered.subjectPreview,
    textContent: rendered.textContent,
    htmlContent: rendered.htmlContent,
    tags: [
      job.template_key,
      `locale:${rendered.templateLanguageCode}`,
      `event:${job.event_key}`,
    ],
    headers: {
      'X-Provider-Custom': [
        `provider_message_key:${job.id}`,
        `dedupe_key:${job.dedupe_key}`,
        `template_key:${job.template_key}`,
      ].join('|'),
    },
    params: {
      locale: rendered.templateLanguageCode,
      template_key: job.template_key,
      dedupe_key: job.dedupe_key,
      payload: rendered.payload,
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
  rendered: RenderedEmailContent,
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
    body: JSON.stringify(
      adapter.buildRequestBody(job, sender, senderName, rendered),
    ),
  })

  const responseText = await response.text()
  let responseBody: Record<string, JsonValue> = {}
  try {
    responseBody = responseText
      ? JSON.parse(responseText) as Record<string, JsonValue>
      : {}
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
    subjectPreview: rendered.subjectPreview,
    templateLanguageCode: rendered.templateLanguageCode,
  }
}

async function dispatchGenericEmail(
  job: OutboxJob,
  provider: string,
  rendered: RenderedEmailContent,
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
      locale: rendered.templateLanguageCode,
      subject: rendered.subjectPreview,
      text_content: rendered.textContent,
      html_content: rendered.htmlContent,
      payload: rendered.payload,
      dedupe_key: job.dedupe_key,
    }),
  })

  const responseText = await response.text()
  let responseBody: Record<string, JsonValue> = {}
  try {
    responseBody = responseText
      ? JSON.parse(responseText) as Record<string, JsonValue>
      : {}
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
    subjectPreview: rendered.subjectPreview,
    templateLanguageCode: rendered.templateLanguageCode,
  }
}

export async function dispatchEmail(
  job: OutboxJob,
  serviceClient = createServiceClient(),
) {
  const provider = requiredEnv('TRANSACTIONAL_EMAIL_PROVIDER').trim().toLowerCase()
  const sender = requiredEnv('TRANSACTIONAL_EMAIL_FROM_EMAIL')
  const senderName = Deno.env.get('TRANSACTIONAL_EMAIL_FROM_NAME')?.trim() ||
    'FleetFill'
  const rendered = await resolveAndRenderEmailContent(job, serviceClient)

  if (isTruthyEnv('TRANSACTIONAL_EMAIL_MOCK_MODE')) {
    return {
      provider,
      providerMessageId: `mock-${job.id}`,
      subjectPreview: rendered.subjectPreview,
      templateLanguageCode: rendered.templateLanguageCode,
    }
  }

  if (provider in providerApiAdapters) {
    return dispatchProviderApiEmail(
      job,
      provider,
      rendered,
      sender,
      senderName,
    )
  }

  return dispatchGenericEmail(job, provider, rendered, sender, senderName)
}
