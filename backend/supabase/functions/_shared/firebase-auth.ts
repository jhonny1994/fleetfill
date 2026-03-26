type FirebaseServiceAccount = {
  project_id: string
  client_email: string
  private_key: string
  token_uri?: string
}

type CachedAccessToken = {
  token: string
  expiresAtMs: number
}

let cachedAccessToken: CachedAccessToken | null = null
let cachedServiceAccount: FirebaseServiceAccount | null = null

function base64UrlEncode(input: string | Uint8Array) {
  const bytes = typeof input === 'string' ? new TextEncoder().encode(input) : input
  let binary = ''
  for (const byte of bytes) {
    binary += String.fromCharCode(byte)
  }

  return btoa(binary)
    .replace(/\+/g, '-')
    .replace(/\//g, '_')
    .replace(/=+$/g, '')
}

function pemToArrayBuffer(pem: string) {
  const normalized = pem
    .replace(/-----BEGIN PRIVATE KEY-----/g, '')
    .replace(/-----END PRIVATE KEY-----/g, '')
    .replace(/\s+/g, '')

  const decoded = atob(normalized)
  const bytes = new Uint8Array(decoded.length)
  for (let index = 0; index < decoded.length; index += 1) {
    bytes[index] = decoded.charCodeAt(index)
  }

  return bytes.buffer
}

function requiredString(value: unknown, field: string) {
  if (typeof value !== 'string' || value.trim().length === 0) {
    throw new Error(`FIREBASE_SERVICE_ACCOUNT_JSON is missing ${field}`)
  }

  return value.trim()
}

function tryParseJsonCandidate(candidate: string): unknown {
  const parsed = JSON.parse(candidate)
  if (typeof parsed === 'string') {
    return JSON.parse(parsed)
  }

  return parsed
}

function normalizeLooseJsonObject(candidate: string) {
  return candidate.replace(/([{,]\s*)([A-Za-z_][A-Za-z0-9_]*)(\s*:)/g, '$1"$2"$3')
}

function parseFirebaseServiceAccountJson(rawJson: string) {
  const candidates = new Set<string>([rawJson])

  if (
    (rawJson.startsWith('"') && rawJson.endsWith('"'))
    || (rawJson.startsWith("'") && rawJson.endsWith("'"))
  ) {
    candidates.add(rawJson.slice(1, -1))
  }

  let lastError: unknown = null
  for (const candidate of candidates) {
    try {
      return tryParseJsonCandidate(candidate)
    } catch (error) {
      lastError = error
    }

    const normalized = normalizeLooseJsonObject(candidate)
    if (normalized !== candidate) {
      try {
        return tryParseJsonCandidate(normalized)
      } catch (error) {
        lastError = error
      }
    }

    try {
      const decoded = new TextDecoder().decode(Uint8Array.from(atob(candidate), (char) => char.charCodeAt(0)))
      return tryParseJsonCandidate(decoded)
    } catch (error) {
      lastError = error
    }
  }

  throw new Error(
    `FIREBASE_SERVICE_ACCOUNT_JSON is not valid JSON: ${lastError instanceof Error ? lastError.message : 'unknown error'}`,
  )
}

export function getFirebaseServiceAccount() {
  if (cachedServiceAccount != null) {
    return cachedServiceAccount
  }

  const rawJson = Deno.env.get('FIREBASE_SERVICE_ACCOUNT_JSON')?.trim()
  if (!rawJson) {
    throw new Error('Missing required environment variable: FIREBASE_SERVICE_ACCOUNT_JSON')
  }

  let parsed: unknown
  try {
    parsed = parseFirebaseServiceAccountJson(rawJson)
  } catch (error) {
    throw error
  }

  if (parsed == null || typeof parsed !== 'object') {
    throw new Error('FIREBASE_SERVICE_ACCOUNT_JSON must decode to an object')
  }

  const serviceAccount: FirebaseServiceAccount = {
    project_id: requiredString((parsed as Record<string, unknown>).project_id, 'project_id'),
    client_email: requiredString((parsed as Record<string, unknown>).client_email, 'client_email'),
    private_key: requiredString((parsed as Record<string, unknown>).private_key, 'private_key'),
    token_uri: typeof (parsed as Record<string, unknown>).token_uri === 'string'
      ? ((parsed as Record<string, unknown>).token_uri as string).trim()
      : undefined,
  }

  cachedServiceAccount = serviceAccount
  return serviceAccount
}

async function signJwt(unsignedJwt: string, privateKeyPem: string) {
  const cryptoKey = await crypto.subtle.importKey(
    'pkcs8',
    pemToArrayBuffer(privateKeyPem),
    {
      name: 'RSASSA-PKCS1-v1_5',
      hash: 'SHA-256',
    },
    false,
    ['sign'],
  )

  const signature = await crypto.subtle.sign(
    'RSASSA-PKCS1-v1_5',
    cryptoKey,
    new TextEncoder().encode(unsignedJwt),
  )

  return base64UrlEncode(new Uint8Array(signature))
}

export async function getFirebaseMessagingAccessToken() {
  const nowMs = Date.now()
  if (cachedAccessToken != null && cachedAccessToken.expiresAtMs - nowMs > 60_000) {
    return cachedAccessToken.token
  }

  const serviceAccount = getFirebaseServiceAccount()
  const issuedAt = Math.floor(nowMs / 1000)
  const expiresAt = issuedAt + 3600
  const header = { alg: 'RS256', typ: 'JWT' }
  const claims = {
    iss: serviceAccount.client_email,
    sub: serviceAccount.client_email,
    aud: serviceAccount.token_uri ?? 'https://oauth2.googleapis.com/token',
    scope: 'https://www.googleapis.com/auth/firebase.messaging',
    iat: issuedAt,
    exp: expiresAt,
  }

  const encodedHeader = base64UrlEncode(JSON.stringify(header))
  const encodedClaims = base64UrlEncode(JSON.stringify(claims))
  const unsignedJwt = `${encodedHeader}.${encodedClaims}`
  const signedJwt = `${unsignedJwt}.${await signJwt(unsignedJwt, serviceAccount.private_key)}`

  const response = await fetch(serviceAccount.token_uri ?? 'https://oauth2.googleapis.com/token', {
    method: 'POST',
    headers: { 'content-type': 'application/x-www-form-urlencoded' },
    body: new URLSearchParams({
      grant_type: 'urn:ietf:params:oauth:grant-type:jwt-bearer',
      assertion: signedJwt,
    }),
  })

  const responseText = await response.text()
  let responseBody: Record<string, unknown> = {}
  try {
    responseBody = responseText ? JSON.parse(responseText) as Record<string, unknown> : {}
  } catch (_) {
    responseBody = {}
  }

  if (!response.ok) {
    throw new Error(
      `firebase_oauth_failed:${typeof responseBody.error_description === 'string' ? responseBody.error_description : responseText || `HTTP ${response.status}`}`,
    )
  }

  const accessToken = typeof responseBody.access_token === 'string' ? responseBody.access_token : null
  const expiresIn = typeof responseBody.expires_in === 'number' ? responseBody.expires_in : 3600
  if (accessToken == null || accessToken.trim().length === 0) {
    throw new Error('firebase_oauth_failed:OAuth token response did not contain an access token')
  }

  cachedAccessToken = {
    token: accessToken,
    expiresAtMs: nowMs + expiresIn * 1000,
  }

  return accessToken
}
