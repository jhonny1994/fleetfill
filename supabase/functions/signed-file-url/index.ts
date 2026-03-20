import { createClient } from 'https://esm.sh/@supabase/supabase-js@2.57.4'

const jsonHeaders = { 'content-type': 'application/json' }
const signedUrlExpirySeconds = 60

function jsonResponse(body: Record<string, unknown>, status = 200) {
  return new Response(JSON.stringify(body), {
    status,
    headers: jsonHeaders,
  })
}

function requireEnv(name: string) {
  const value = Deno.env.get(name)?.trim()
  if (!value) {
    throw new Error(`Missing required environment variable: ${name}`)
  }
  return value
}

Deno.serve(async (req: Request) => {
  if (req.method != 'POST') {
    return jsonResponse({ error: 'Method not allowed' }, 405)
  }

  const authorization = req.headers.get('Authorization')
  if (!authorization) {
    return jsonResponse({ error: 'Missing authorization header' }, 401)
  }

  let payload: { bucket_id?: string; object_path?: string }
  try {
    payload = await req.json()
  } catch (_) {
    return jsonResponse({ error: 'Invalid JSON body' }, 400)
  }

  const bucketId = payload.bucket_id?.trim()
  const objectPath = payload.object_path?.trim()

  if (!bucketId || !objectPath) {
    return jsonResponse(
      { error: 'bucket_id and object_path are required' },
      400,
    )
  }

  try {
    const supabaseUrl = requireEnv('SUPABASE_URL')
    const anonKey = requireEnv('SUPABASE_ANON_KEY')
    const serviceRoleKey = requireEnv('SUPABASE_SERVICE_ROLE_KEY')

    const userClient = createClient(supabaseUrl, anonKey, {
      global: {
        headers: { Authorization: authorization },
      },
    })

    const serviceClient = createClient(supabaseUrl, serviceRoleKey)

    const {
      data: { user },
      error: authError,
    } = await userClient.auth.getUser()

    if (authError != null || user == null) {
      return jsonResponse({ error: 'Unauthorized' }, 401)
    }

    const { data: authorizationResult, error: authorizationError } = await userClient.rpc(
      'authorize_private_file_access',
      {
        p_bucket_id: bucketId,
        p_object_path: objectPath,
      },
    )

    if (authorizationError != null) {
      console.error('signed-file-url authorization error', authorizationError)
      return jsonResponse(
        { error: 'Failed to authorize document access' },
        400,
      )
    }

    if (authorizationResult != true) {
      return jsonResponse({ error: 'Forbidden' }, 403)
    }

    const { data: signedUrlData, error: signedUrlError } = await serviceClient
      .storage
      .from(bucketId)
      .createSignedUrl(objectPath, signedUrlExpirySeconds)

    if (signedUrlError != null || signedUrlData?.signedUrl == null) {
      console.error('signed-file-url createSignedUrl error', signedUrlError)
      return jsonResponse({ error: 'Signed URL is unavailable' }, 500)
    }

    return jsonResponse({
      signed_url: signedUrlData.signedUrl,
      expires_in_seconds: signedUrlExpirySeconds,
      bucket_id: bucketId,
      object_path: objectPath,
    })
  } catch (error) {
    console.error('signed-file-url unexpected error', error)
    return jsonResponse({ error: 'Internal server error' }, 500)
  }
})
