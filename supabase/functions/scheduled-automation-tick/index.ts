import { createServiceClient, jsonResponse, requiredEnv } from '../_shared/email-runtime.ts'

Deno.serve(async (req) => {
  if (req.method !== 'POST') {
    return jsonResponse({ error: 'Method not allowed' }, 405)
  }

  try {
    const authorization = req.headers.get('Authorization')
    const expectedAuthorization = `Bearer ${requiredEnv('SUPABASE_SERVICE_ROLE_KEY')}`
    if (authorization !== expectedAuthorization) {
      return jsonResponse({ error: 'Unauthorized' }, 401)
    }

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

    const { data: expiredRejectedBookings, error: paymentExpiryError } = await serviceClient.rpc(
      'expire_payment_resubmission_deadlines',
    )
    const { data: autoCompletedDeliveries, error: deliveryExpiryError } = await serviceClient.rpc(
      'auto_complete_delivered_bookings',
    )

    if (recoveryError != null || paymentExpiryError != null || deliveryExpiryError != null) {
      console.error('recover_stale_email_outbox_jobs failed', recoveryError)
      console.error('expire_payment_resubmission_deadlines failed', paymentExpiryError)
      console.error('auto_complete_delivered_bookings failed', deliveryExpiryError)
      return jsonResponse({ error: 'Failed to run scheduled maintenance' }, 500)
    }

    return jsonResponse({
      email_dispatch: workerPayload,
      recovered_stale_jobs: recoveredJobs ?? 0,
      delivery_grace_window_expiry: autoCompletedDeliveries ?? 0,
      payment_resubmission_expiry: expiredRejectedBookings ?? 0,
    })
  } catch (error) {
    console.error('scheduled-automation-tick failed', error)
    return jsonResponse({ error: 'Internal server error' }, 500)
  }
})
