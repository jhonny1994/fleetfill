import {
  computeRetryDelaySeconds,
  createServiceClient,
  dispatchEmail,
  hasInternalAutomationAccess,
  inferDeliveryStatus,
  jsonResponse,
  normalizeSupportedLocale,
  type OutboxJob,
  requiredEnv,
} from '../_shared/email-runtime.ts'

const defaultBatchSize = 10

Deno.serve(async (req: Request) => {
  if (req.method !== 'POST') {
    return jsonResponse({ error: 'Method not allowed' }, 405)
  }

  try {
    if (!hasInternalAutomationAccess(req)) {
      return jsonResponse({ error: 'Unauthorized' }, 401)
    }

    const body = await req.json().catch(() => ({})) as { batch_size?: number }
    const serviceClient = createServiceClient()
    const workerId = `edge:${crypto.randomUUID()}`
    const batchSize = Math.max(
      1,
      Math.min(body.batch_size ?? defaultBatchSize, 25),
    )

    const { data: jobs, error: claimError } = await serviceClient.rpc(
      'claim_email_outbox_jobs',
      {
        p_worker_id: workerId,
        p_batch_size: batchSize,
      },
    )

    if (claimError != null) {
      console.error('claim_email_outbox_jobs failed', claimError)
      return jsonResponse({ error: 'Failed to claim email jobs' }, 500)
    }

    const claimedJobs = (jobs ?? []) as OutboxJob[]
    const results: Array<Record<string, unknown>> = []

    for (const job of claimedJobs) {
      try {
        const delivery = await dispatchEmail(job)
        const { error: completionError } = await serviceClient.rpc(
          'complete_email_outbox_job',
          {
            p_job_id: job.id,
            p_provider: delivery.provider,
            p_provider_message_id: delivery.providerMessageId,
            p_subject_preview: delivery.subjectPreview,
            p_template_language_code: delivery.templateLanguageCode,
          },
        )

        if (completionError != null) {
          throw completionError
        }

        results.push({
          job_id: job.id,
          status: 'sent_to_provider',
          provider_message_id: delivery.providerMessageId,
        })
      } catch (error) {
        const rawMessage = error instanceof Error
          ? error.message
          : 'unknown_error:Unknown email dispatch failure'
        const separatorIndex = rawMessage.indexOf(':')
        const errorCode = separatorIndex >= 0
          ? rawMessage.slice(0, separatorIndex)
          : 'unknown_error'
        const errorMessage = separatorIndex >= 0 ? rawMessage.slice(separatorIndex + 1) : rawMessage
        const retryDelaySeconds = computeRetryDelaySeconds(
          job.attempt_count + 1,
        )

        const { error: retryError } = await serviceClient.rpc(
          'release_retryable_email_job',
          {
            p_job_id: job.id,
            p_error_code: errorCode,
            p_error_message: errorMessage,
            p_retry_delay_seconds: retryDelaySeconds,
          },
        )

        if (retryError != null) {
          console.error('release_retryable_email_job failed', retryError)
        }

        const deliveryStatus = inferDeliveryStatus(errorCode)
        const { error: failureLogError } = await serviceClient.rpc(
          'record_email_dispatch_failure',
          {
            p_job_id: job.id,
            p_status: deliveryStatus,
            p_provider: requiredEnv('TRANSACTIONAL_EMAIL_PROVIDER')
              .trim()
              .toLowerCase(),
            p_subject_preview: null,
            p_error_code: errorCode,
            p_error_message: errorMessage,
            p_template_language_code: normalizeSupportedLocale(
              job.template_language_code ?? job.locale,
            ),
          },
        )

        if (failureLogError != null) {
          console.error('record_email_dispatch_failure failed', failureLogError)
        }

        results.push({
          job_id: job.id,
          status: deliveryStatus,
          error_code: errorCode,
        })
      }
    }

    return jsonResponse({
      worker_id: workerId,
      claimed_count: claimedJobs.length,
      results,
    })
  } catch (error) {
    console.error('transactional-email-dispatch-worker failed', error)
    return jsonResponse({ error: 'Internal server error' }, 500)
  }
})
