import { createServiceClient, jsonResponse } from '../_shared/email-runtime.ts'

Deno.serve(async (req) => {
  if (req.method !== 'POST') {
    return jsonResponse({ error: 'Method not allowed' }, 405)
  }

  try {
    const serviceClient = createServiceClient()

    const workerResponse = await fetch(
      `${Deno.env.get('SUPABASE_URL')}/functions/v1/transactional-email-dispatch-worker`,
      {
        method: 'POST',
        headers: {
          Authorization: `Bearer ${Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')}`,
          'content-type': 'application/json',
        },
        body: JSON.stringify({ batch_size: 10 }),
      },
    )

    let workerPayload: Record<string, unknown> = {}
    try {
      workerPayload = await workerResponse.json() as Record<string, unknown>
    } catch (_) {
      workerPayload = {}
    }

    const { data: recoveredJobs, error: recoveryError } = await serviceClient.rpc(
      'recover_stale_email_outbox_jobs',
      { p_lock_age_seconds: 900 },
    )

    if (recoveryError != null) {
      console.error('recover_stale_email_outbox_jobs failed', recoveryError)
      return jsonResponse({ error: 'Failed to recover stale email jobs' }, 500)
    }

    return jsonResponse({
      email_dispatch: workerPayload,
      recovered_stale_jobs: recoveredJobs ?? 0,
      delivery_grace_window_expiry: 'not_implemented_yet',
      payment_resubmission_expiry: 'not_implemented_yet',
    })
  } catch (error) {
    console.error('scheduled-automation-tick failed', error)
    return jsonResponse({ error: 'Internal server error' }, 500)
  }
})
