import {
  createServiceClient,
  isTruthyEnv,
  jsonResponse,
  requiredEnv,
} from '../_shared/email-runtime.ts'
import {
  getFirebaseMessagingAccessToken,
  getFirebaseServiceAccount,
} from '../_shared/firebase-auth.ts'

type PushOutboxJob = {
  id: string
  notification_id: string
  profile_id: string
  event_key: string
  title: string
  body: string
  payload_snapshot: Record<string, unknown> | null
  attempt_count: number
}

const defaultBatchSize = 10
const defaultRetryDelaySeconds = 300
const restrictedAndroidPackageName = 'com.carbodex.fleetfill'

class PushSendError extends Error {
  code: string
  retryable: boolean
  shouldDeleteToken: boolean
  retryDelaySeconds: number | null

  constructor({
    code,
    message,
    retryable = false,
    shouldDeleteToken = false,
    retryDelaySeconds = null,
  }: {
    code: string
    message: string
    retryable?: boolean
    shouldDeleteToken?: boolean
    retryDelaySeconds?: number | null
  }) {
    super(message)
    this.name = 'PushSendError'
    this.code = code
    this.retryable = retryable
    this.shouldDeleteToken = shouldDeleteToken
    this.retryDelaySeconds = retryDelaySeconds
  }
}

function stringifyPayload(payload: Record<string, unknown> | null) {
  const result: Record<string, string> = {}
  if (payload == null) {
    return result
  }

  for (const [key, value] of Object.entries(payload)) {
    if (value == null) {
      continue
    }
    result[key] = typeof value === 'string' ? value : JSON.stringify(value)
  }

  return result
}

function parseRetryAfterSeconds(retryAfterHeader: string | null) {
  if (retryAfterHeader == null || retryAfterHeader.trim().length === 0) {
    return null
  }

  const numericValue = Number.parseInt(retryAfterHeader, 10)
  if (!Number.isNaN(numericValue) && numericValue > 0) {
    return numericValue
  }

  const retryAtMs = Date.parse(retryAfterHeader)
  if (Number.isNaN(retryAtMs)) {
    return null
  }

  return Math.max(0, Math.ceil((retryAtMs - Date.now()) / 1000))
}

function readFcmErrorCode(responseBody: Record<string, unknown>) {
  const error = responseBody.error
  if (error == null || typeof error !== 'object') {
    return null
  }

  if (typeof (error as Record<string, unknown>).status === 'string') {
    return (error as Record<string, unknown>).status as string
  }

  const details = Array.isArray((error as Record<string, unknown>).details)
    ? (error as Record<string, unknown>).details as Array<Record<string, unknown>>
    : []
  for (const detail of details) {
    if (typeof detail.errorCode === 'string') {
      return detail.errorCode
    }
  }

  return null
}

function readFcmErrorMessage(responseBody: Record<string, unknown>, fallback: string) {
  const error = responseBody.error
  if (error != null && typeof error === 'object' && typeof (error as Record<string, unknown>).message === 'string') {
    return (error as Record<string, unknown>).message as string
  }

  return fallback
}

function classifyFcmV1Error(
  responseBody: Record<string, unknown>,
  retryAfterHeader: string | null,
) {
  const code = readFcmErrorCode(responseBody) ?? 'UNKNOWN_PUSH_ERROR'
  const message = readFcmErrorMessage(responseBody, code)
  const retryAfterSeconds = parseRetryAfterSeconds(retryAfterHeader)
  const normalizedCode = code.toUpperCase()
  const normalizedMessage = message.toLowerCase()

  if (normalizedCode === 'UNREGISTERED') {
    return new PushSendError({
      code,
      message,
      shouldDeleteToken: true,
    })
  }

  if (normalizedCode === 'INVALID_ARGUMENT' && normalizedMessage.includes('registration token')) {
    return new PushSendError({
      code,
      message,
      shouldDeleteToken: true,
    })
  }

  if (
    normalizedCode === 'QUOTA_EXCEEDED' ||
    normalizedCode === 'UNAVAILABLE' ||
    normalizedCode === 'INTERNAL'
  ) {
    return new PushSendError({
      code,
      message,
      retryable: true,
      retryDelaySeconds: retryAfterSeconds ?? Math.max(60, defaultRetryDelaySeconds),
    })
  }

  return new PushSendError({ code, message })
}

async function sendFcmV1Push(
  token: string,
  job: PushOutboxJob,
) {
  const serviceAccount = getFirebaseServiceAccount()
  const accessToken = await getFirebaseMessagingAccessToken()
  const response = await fetch(
    `https://fcm.googleapis.com/v1/projects/${serviceAccount.project_id}/messages:send`,
    {
    method: 'POST',
    headers: {
      Authorization: `Bearer ${accessToken}`,
      'content-type': 'application/json',
    },
    body: JSON.stringify({
      message: {
        token,
        notification: {
          title: job.title,
          body: job.body,
        },
        data: stringifyPayload(job.payload_snapshot),
        android: {
          priority: 'HIGH',
          restricted_package_name: restrictedAndroidPackageName,
          notification: {
            click_action: 'FLUTTER_NOTIFICATION_CLICK',
          },
        },
        apns: {
          headers: {
            'apns-priority': '10',
          },
        },
      },
    }),
  },
  )

  const responseText = await response.text()
  let responseBody: Record<string, unknown> = {}
  try {
    responseBody = responseText ? JSON.parse(responseText) as Record<string, unknown> : {}
  } catch (_) {
    responseBody = {}
  }

  if (!response.ok) {
    throw classifyFcmV1Error(responseBody, response.headers.get('retry-after'))
  }

  const name = typeof responseBody.name === 'string' ? responseBody.name : null
  if (name == null || name.trim().length === 0) {
    throw new PushSendError({
      code: 'INVALID_FCM_RESPONSE',
      message: responseText || 'FCM v1 response did not contain a message name',
    })
  }

  return name
}

Deno.serve(async (req: Request) => {
  if (req.method !== 'POST') {
    return jsonResponse({ error: 'Method not allowed' }, 405)
  }

  try {
    const authorization = req.headers.get('Authorization')
    const expectedAuthorization = `Bearer ${requiredEnv('SUPABASE_SERVICE_ROLE_KEY')}`
    if (authorization !== expectedAuthorization) {
      return jsonResponse({ error: 'Unauthorized' }, 401)
    }

    if (!isTruthyEnv('PUSH_NOTIFICATIONS_ENABLED')) {
      return jsonResponse({ status: 'disabled' })
    }

    const provider = Deno.env.get('PUSH_NOTIFICATIONS_PROVIDER')?.trim().toLowerCase() ?? ''
    if (provider !== 'fcm_v1') {
      return jsonResponse({ error: 'Unsupported push provider' }, 500)
    }

    const body = await req.json().catch(() => ({})) as { batch_size?: number }
    const batchSize = Math.max(1, Math.min(body.batch_size ?? defaultBatchSize, 25))
    const workerId = `edge:${crypto.randomUUID()}`
    const serviceClient = createServiceClient()

    const { data: jobs, error: claimError } = await serviceClient.rpc(
      'claim_push_outbox_jobs',
      { p_worker_id: workerId, p_batch_size: batchSize },
    )
    if (claimError != null) {
      console.error('claim_push_outbox_jobs failed', claimError)
      return jsonResponse({ error: 'Failed to claim push jobs' }, 500)
    }

    const claimedJobs = (jobs ?? []) as PushOutboxJob[]
    const results: Array<Record<string, unknown>> = []

    for (const job of claimedJobs) {
      const { data: devices, error: devicesError } = await serviceClient
        .from('user_devices')
        .select('push_token')
        .eq('profile_id', job.profile_id)

      if (devicesError != null) {
        console.error('user_devices lookup failed', devicesError)
        await serviceClient.rpc('release_retryable_push_job', {
          p_job_id: job.id,
          p_error_code: 'device_lookup_failed',
          p_error_message: devicesError.message,
          p_retry_delay_seconds: 300,
        })
        continue
      }

      const pushTokens = (devices ?? [])
        .map((item) => typeof item.push_token === 'string' ? item.push_token.trim() : '')
        .filter((token) => token.length > 0)

      if (pushTokens.length == 0) {
        await serviceClient.rpc('complete_push_outbox_job', {
          p_job_id: job.id,
          p_status: 'skipped',
          p_provider: provider,
          p_provider_message_id: null,
          p_error_code: 'no_registered_devices',
          p_error_message: 'No registered user devices were available',
        })
        results.push({ job_id: job.id, status: 'skipped' })
        continue
      }

      let deliveredCount = 0
      let firstMessageId: string | null = null
      let lastErrorCode: string | null = null
      let lastErrorMessage: string | null = null
      let retryDelaySeconds: number | null = null

      for (const token of pushTokens) {
        try {
          const messageId = await sendFcmV1Push(token, job)
          deliveredCount += 1
          firstMessageId ??= messageId
        } catch (error) {
          if (error instanceof PushSendError) {
            lastErrorCode = error.code
            lastErrorMessage = error.message
            retryDelaySeconds = error.retryDelaySeconds ?? retryDelaySeconds

            if (error.shouldDeleteToken) {
              await serviceClient.from('user_devices').delete().eq('push_token', token)
            }
            continue
          }

          lastErrorCode = 'unknown_push_error'
          lastErrorMessage = error instanceof Error ? error.message : 'Unknown push failure'
        }
      }

      if (deliveredCount > 0) {
        await serviceClient.rpc('complete_push_outbox_job', {
          p_job_id: job.id,
          p_status: 'sent',
          p_provider: provider,
          p_provider_message_id: firstMessageId,
          p_error_code: null,
          p_error_message: null,
        })
        results.push({ job_id: job.id, status: 'sent', delivered_count: deliveredCount })
      } else {
        await serviceClient.rpc('release_retryable_push_job', {
          p_job_id: job.id,
          p_error_code: lastErrorCode,
          p_error_message: lastErrorMessage,
          p_retry_delay_seconds: retryDelaySeconds ?? defaultRetryDelaySeconds,
        })
        results.push({ job_id: job.id, status: 'retry_scheduled', error_code: lastErrorCode })
      }
    }

    return jsonResponse({ worker_id: workerId, claimed_count: claimedJobs.length, results })
  } catch (error) {
    console.error('push-dispatch-worker failed', error)
    return jsonResponse({ error: 'Internal server error' }, 500)
  }
})
