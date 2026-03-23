import {
  createClient,
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

    console.info('support-email-dispatch request received', {
      locale: payload.locale ?? null,
      subjectLength: payload.subject?.trim().length ?? 0,
      messageLength: payload.message?.trim().length ?? 0,
    })

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

    const profileId = user.id
    const locale = normalizeSupportedLocale(payload.locale)
    const recipientEmail = user.email.trim().toLowerCase()
    const supportInbox = requiredEnv('SUPPORT_EMAIL_TO').trim().toLowerCase()
    console.info('support-email-dispatch authenticated request', {
      userId: profileId,
      recipientEmail,
      supportInbox,
      locale,
    })
    const { data, error } = await userClient.rpc(
      'enqueue_support_request_emails',
      {
        p_locale: locale,
        p_subject: payload.subject.trim(),
        p_message: payload.message.trim(),
        p_support_inbox_email: supportInbox,
      },
    )

    if (error != null) {
      const message = error.message.toLowerCase()
      if (message.includes('rate limit')) {
        console.warn('support email rate limited', {
          userId: profileId,
          recipientEmail,
          locale,
        })
        return jsonResponse({
          error: 'Support acknowledgement rate limit exceeded',
        }, 429)
      }

      console.error('support email enqueue failed', {
        error,
        userId: profileId,
        recipientEmail,
        supportInbox,
        locale,
      })
      return jsonResponse({ error: 'Failed to enqueue support request' }, 500)
    }

    const result = (data ?? {}) as {
      acknowledgement_job_id?: string
      forward_job_id?: string
      status?: string
    }

    return jsonResponse({
      acknowledgement_job_id: result.acknowledgement_job_id,
      forward_job_id: result.forward_job_id,
      status: result.status ?? 'queued',
    })
  } catch (error) {
    console.error('support-email-dispatch failed', error)
    return jsonResponse({ error: 'Internal server error' }, 500)
  }
})
