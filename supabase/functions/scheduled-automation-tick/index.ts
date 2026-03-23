import { createServiceClient, jsonResponse, requiredEnv } from '../_shared/email-runtime.ts'

type TaskResult = {
  name: string
  ok: boolean
  status?: number
  payload?: Record<string, unknown>
  value?: number
  error?: string
}

async function invokeWorker(
  serviceRoleKey: string,
  supabaseUrl: string,
  name: string,
  path: string,
  body: Record<string, unknown>,
): Promise<TaskResult> {
  try {
    const response = await fetch(`${supabaseUrl}/functions/v1/${path}`, {
      method: 'POST',
      headers: {
        Authorization: `Bearer ${serviceRoleKey}`,
        'content-type': 'application/json',
      },
      body: JSON.stringify(body),
    })

    let payload: Record<string, unknown> = {}
    try {
      payload = await response.json() as Record<string, unknown>
    } catch (_) {
      payload = {}
    }

    return {
      name,
      ok: response.ok,
      status: response.status,
      payload,
      error: response.ok ? undefined : JSON.stringify(payload),
    }
  } catch (error) {
    return {
      name,
      ok: false,
      error: error instanceof Error ? error.message : 'Unknown worker error',
    }
  }
}

async function invokeRpc(
  serviceClient: ReturnType<typeof createServiceClient>,
  name: string,
  rpcName: string,
  params: Record<string, unknown>,
): Promise<TaskResult> {
  try {
    const { data, error } = await serviceClient.rpc(rpcName, params)
    if (error != null) {
      return {
        name,
        ok: false,
        error: error.message,
      }
    }

    return {
      name,
      ok: true,
      value: typeof data === 'number' ? data : Number(data ?? 0),
    }
  } catch (error) {
    return {
      name,
      ok: false,
      error: error instanceof Error ? error.message : 'Unknown RPC error',
    }
  }
}

Deno.serve(async (req: Request) => {
  if (req.method !== 'POST') {
    return jsonResponse({ error: 'Method not allowed' }, 405)
  }

  try {
    const authorization = req.headers.get('Authorization')
    const serviceRoleKey = requiredEnv('SUPABASE_SERVICE_ROLE_KEY')
    const supabaseUrl = requiredEnv('SUPABASE_URL')
    const expectedAuthorization = `Bearer ${serviceRoleKey}`
    if (authorization !== expectedAuthorization) {
      return jsonResponse({ error: 'Unauthorized' }, 401)
    }

    const serviceClient = createServiceClient()

    // Recover stale locks first so the same tick can reclaim newly unstuck work.
    const taskResults = await Promise.all([
      invokeRpc(
        serviceClient,
        'recover_stale_email_outbox_jobs',
        'recover_stale_email_outbox_jobs',
        { p_lock_age_seconds: 900 },
      ),
      invokeRpc(
        serviceClient,
        'recover_stale_generated_document_jobs',
        'recover_stale_generated_document_jobs',
        { p_lock_age_seconds: 900 },
      ),
      invokeRpc(
        serviceClient,
        'recover_stale_push_outbox_jobs',
        'recover_stale_push_outbox_jobs',
        { p_lock_age_seconds: 900 },
      ),
    ])

    taskResults.push(
      await invokeWorker(
        serviceRoleKey,
        supabaseUrl,
        'transactional_email_dispatch_worker',
        'transactional-email-dispatch-worker',
        { batch_size: 10 },
      ),
    )
    taskResults.push(
      await invokeWorker(
        serviceRoleKey,
        supabaseUrl,
        'push_dispatch_worker',
        'push-dispatch-worker',
        { batch_size: 10 },
      ),
    )
    taskResults.push(
      await invokeWorker(
        serviceRoleKey,
        supabaseUrl,
        'generated_document_worker',
        'generated-document-worker',
        { batch_size: 5 },
      ),
    )
    taskResults.push(
      await invokeRpc(
        serviceClient,
        'expire_payment_resubmission_deadlines',
        'expire_payment_resubmission_deadlines',
        {},
      ),
    )
    taskResults.push(
      await invokeRpc(
        serviceClient,
        'auto_complete_delivered_bookings',
        'auto_complete_delivered_bookings',
        {},
      ),
    )

    const failures = taskResults.filter((task) => !task.ok)
    const allSucceeded = failures.length === 0

    return jsonResponse(
      {
        ok: allSucceeded,
        tasks: taskResults,
      },
      allSucceeded ? 200 : 500,
    )
  } catch (error) {
    console.error('scheduled-automation-tick failed', error)
    return jsonResponse({ error: 'Internal server error' }, 500)
  }
})
