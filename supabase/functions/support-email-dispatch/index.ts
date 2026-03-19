import {
  buildSubjectPreview,
  createClient,
  createServiceClient,
  dispatchEmail,
  jsonResponse,
  requiredEnv,
  type OutboxJob,
} from '../_shared/email-runtime.ts'

Deno.serve(async (req) => {
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
    const locale = payload.locale?.trim() || 'en'
    const recipientEmail = user.email.trim().toLowerCase()
    const dedupeKey = `support_ack:${recipientEmail}:${payload.subject.trim()}`

    const { data: insertedJob, error: insertError } = await serviceClient
      .from('email_outbox_jobs')
      .insert({
        event_key: 'support_acknowledgement',
        dedupe_key: dedupeKey,
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
      })
      .select()
      .single()

    if (insertError != null) {
      console.error('support acknowledgement enqueue failed', insertError)
      return jsonResponse({ error: 'Failed to enqueue support acknowledgement' }, 500)
    }

    const job = insertedJob as OutboxJob
    const delivery = await dispatchEmail(job)
    const subjectPreview = buildSubjectPreview(job.template_key, job.payload_snapshot)

    const { error: completionError } = await serviceClient.rpc('complete_email_outbox_job', {
      p_job_id: job.id,
      p_provider: delivery.provider,
      p_provider_message_id: delivery.providerMessageId,
      p_subject_preview: subjectPreview,
    })

    if (completionError != null) {
      console.error('support acknowledgement completion failed', completionError)
      return jsonResponse({ error: 'Support acknowledgement send failed' }, 500)
    }

    return jsonResponse({
      job_id: job.id,
      provider_message_id: delivery.providerMessageId,
      status: 'sent_to_provider',
    })
  } catch (error) {
    console.error('support-email-dispatch failed', error)
    return jsonResponse({ error: 'Internal server error' }, 500)
  }
})
