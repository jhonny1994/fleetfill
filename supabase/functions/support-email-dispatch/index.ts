import {
  createClient,
  createServiceClient,
  jsonResponse,
  normalizeSupportedLocale,
  requiredEnv,
} from '../_shared/email-runtime.ts'

Deno.serve(async (req: Request) => {
  if (req.method !== 'POST') {
    return jsonResponse({ error: 'Method not allowed' }, 405)
  }

  try {
    const payload = await req.json() as {
      locale?: string
      subject?: string
      message?: string
    }

    if (!payload.subject || !payload.message) {
      return jsonResponse({ error: 'subject and message are required' }, 400)
    }

    if (
      payload.subject.trim().length > 160 ||
      payload.message.trim().length > 4000
    ) {
      return jsonResponse({ error: 'support message is too large' }, 400)
    }

    const authorization = req.headers.get('Authorization')
    if (!authorization) {
      return jsonResponse({ error: 'Missing authorization header' }, 401)
    }

    const userClient = createClient(
      requiredEnv('SUPABASE_URL'),
      requiredEnv('SUPABASE_ANON_KEY'),
      {
        global: { headers: { Authorization: authorization } },
      },
    )

    const {
      data: { user },
      error: authError,
    } = await userClient.auth.getUser()

    if (authError != null || user == null || !user.email?.trim()) {
      return jsonResponse({ error: 'Unauthorized' }, 401)
    }

    const serviceClient = createServiceClient()
    const profileId = user.id
    const locale = normalizeSupportedLocale(payload.locale)
    const recipientEmail = user.email.trim().toLowerCase()
    const supportInbox = requiredEnv('SUPPORT_EMAIL_TO').trim().toLowerCase()
    const ackDedupeKey = `support_ack:${profileId}:${crypto.randomUUID()}`
    const forwardDedupeKey = `support_forward:${profileId}:${crypto.randomUUID()}`

    const { error: rateLimitError } = await serviceClient.rpc(
      'assert_rate_limit',
      {
        p_key: `support-email-dispatch:${profileId}`,
        p_limit: 3,
        p_window_seconds: 3600,
      },
    )

    if (rateLimitError != null) {
      return jsonResponse({
        error: 'Support acknowledgement rate limit exceeded',
      }, 429)
    }

    const { data: insertedJobs, error: insertJobsError } = await serviceClient
      .from('email_outbox_jobs')
      .insert([
        {
          event_key: 'support_acknowledgement',
          dedupe_key: ackDedupeKey,
          profile_id: profileId,
          template_key: 'support_acknowledgement',
          locale,
          recipient_email: recipientEmail,
          priority: 'high',
          status: 'queued',
          available_at: new Date().toISOString(),
          payload_snapshot: {
            subject: payload.subject.trim(),
            message: payload.message.trim(),
          },
        },
        {
          event_key: 'support_request_forwarded',
          dedupe_key: forwardDedupeKey,
          profile_id: profileId,
          template_key: 'support_request_forwarded',
          locale,
          recipient_email: supportInbox,
          priority: 'high',
          status: 'queued',
          available_at: new Date().toISOString(),
          payload_snapshot: {
            subject: payload.subject.trim(),
            message: payload.message.trim(),
            sender_email: recipientEmail,
            profile_id: profileId,
          },
        },
      ])
      .select()

    if (insertJobsError != null) {
      console.error('support email enqueue failed', insertJobsError)
      return jsonResponse({ error: 'Failed to enqueue support request' }, 500)
    }

    const jobs = (insertedJobs ?? []) as Array<
      { id: string; event_key: string }
    >
    const acknowledgementJob = jobs.find((job) => job.event_key === 'support_acknowledgement')
    const forwardJob = jobs.find((job) => job.event_key === 'support_request_forwarded')

    return jsonResponse({
      acknowledgement_job_id: acknowledgementJob?.id,
      forward_job_id: forwardJob?.id,
      status: 'queued',
    })
  } catch (error) {
    console.error('support-email-dispatch failed', error)
    return jsonResponse({ error: 'Internal server error' }, 500)
  }
})
