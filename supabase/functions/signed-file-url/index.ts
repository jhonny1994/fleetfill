import { createClient } from 'https://esm.sh/@supabase/supabase-js@2.57.4'

const jsonHeaders = { 'content-type': 'application/json' }
const signedUrlExpirySeconds = 60

function resolveRequestOrigin(req: Request) {
  const forwardedProto = req.headers.get('x-forwarded-proto')?.trim()
  const forwardedHost = req.headers.get('x-forwarded-host')?.trim()
  if (forwardedProto && forwardedHost) {
    return `${forwardedProto}://${forwardedHost}`
  }

  const host = req.headers.get('host')?.trim()
  if (host) {
    return `${new URL(req.url).protocol}//${host}`
  }

  return new URL(req.url).origin
}

function resolveClientOrigin(
  req: Request,
  preferredBaseUrl?: string,
) {
  const normalizedPreferredBaseUrl = preferredBaseUrl?.trim()
  if (normalizedPreferredBaseUrl) {
    try {
      return new URL(normalizedPreferredBaseUrl).origin
    } catch (_) {
      // Ignore invalid client-supplied URLs and fall back to the request origin.
    }
  }

  return resolveRequestOrigin(req)
}

function shouldRewriteSignedUrlHost(hostname: string) {
  const normalized = hostname.trim().toLowerCase()
  return (
    normalized === 'kong' ||
    normalized === 'localhost' ||
    normalized === '127.0.0.1' ||
    normalized === 'host.docker.internal'
  )
}

function rewriteSignedUrlForClient(
  req: Request,
  signedUrl: string,
  preferredBaseUrl?: string,
) {
  const clientOrigin = resolveClientOrigin(req, preferredBaseUrl)

  try {
    const parsed = new URL(signedUrl)
    if (shouldRewriteSignedUrlHost(parsed.hostname)) {
      const clientBase = new URL(clientOrigin)
      parsed.protocol = clientBase.protocol
      parsed.host = clientBase.host
      return parsed.toString()
    }
    return parsed.toString()
  } catch (_) {
    return new URL(signedUrl, clientOrigin).toString()
  }
}

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

function requireSupabaseSecretKey() {
  const value =
    Deno.env.get('SB_SECRET_KEY')?.trim() ??
    Deno.env.get('SUPABASE_SECRET_KEY')?.trim()
  if (!value) {
    throw new Error(
      'Missing required environment variable: SB_SECRET_KEY or SUPABASE_SECRET_KEY',
    )
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

  let payload: { bucket_id?: string; object_path?: string; public_base_url?: string }
  try {
    payload = await req.json()
  } catch (_) {
    return jsonResponse({ error: 'Invalid JSON body' }, 400)
  }

    const bucketId = payload.bucket_id?.trim()
    const objectPath = payload.object_path?.trim()
    const publicBaseUrl = payload.public_base_url?.trim()

  if (!bucketId || !objectPath) {
    return jsonResponse(
      { error: 'bucket_id and object_path are required' },
      400,
    )
  }

  try {
    const supabaseUrl = requireEnv('SUPABASE_URL')
    const anonKey = requireEnv('SUPABASE_ANON_KEY')
    const supabaseSecretKey = requireSupabaseSecretKey()

    const userClient = createClient(supabaseUrl, anonKey, {
      global: {
        headers: { Authorization: authorization },
      },
    })

    const serviceClient = createClient(supabaseUrl, supabaseSecretKey)

    const {
      data: { user },
      error: authError,
    } = await userClient.auth.getUser()

    if (authError != null || user == null) {
      return jsonResponse({ error: 'Unauthorized' }, 401)
    }

    const { data: authorizationResult, error: authorizationError } = await serviceClient.rpc(
      'authorize_private_file_access_for_user',
      {
        p_actor_id: user.id,
        p_bucket_id: bucketId,
        p_object_path: objectPath,
      },
    )

    if (authorizationError != null) {
      console.error('signed-file-url authorization error', {
        userId: user.id,
        bucketId,
        objectPath,
        authorizationError,
      })
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

    const clientSignedUrl = rewriteSignedUrlForClient(
      req,
      signedUrlData.signedUrl,
      publicBaseUrl,
    )

    console.info('signed-file-url success', {
      requestOrigin: resolveRequestOrigin(req),
      resolvedClientOrigin: resolveClientOrigin(req, publicBaseUrl),
      originalSignedUrl: signedUrlData.signedUrl,
      clientSignedUrl,
      userId: user.id,
      bucketId,
      objectPath,
    })

    return jsonResponse({
      signed_url: clientSignedUrl,
      expires_in_seconds: signedUrlExpirySeconds,
      bucket_id: bucketId,
      object_path: objectPath,
    })
  } catch (error) {
    console.error('signed-file-url unexpected error', error)
    return jsonResponse({ error: 'Internal server error' }, 500)
  }
})
