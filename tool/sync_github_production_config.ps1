[CmdletBinding()]
param(
  [string]$Repo = "jhonny1994/fleetfill",
  [string]$ProjectRef = "rkvrdzwlynyionsnwfiu",
  [string]$PublicSiteUrl = "",
  [string]$GoogleServicesPath = "apps/mobile/android/app/google-services.json",
  [string]$KeystorePath = "apps/mobile/android/app/upload-keystore.jks",
  [string]$LocalSigningPropertiesPath = "apps/mobile/android/app/release-signing.local.properties",
  [string]$KeystoreAlias = "fleetfill-upload",
  [string]$GoogleWebClientId = "",
  [string]$GoogleIosClientId = "",
  [string]$SentryDsn = "",
  [string]$NetlifySiteId = "",
  [string]$NetlifyAuthToken = "",
  [switch]$GenerateKeystoreIfMissing
)

$ErrorActionPreference = "Stop"

function Set-GhVariable {
  param(
    [string]$Name,
    [string]$Value
  )

  if ([string]::IsNullOrWhiteSpace($Value)) {
    throw "Cannot set empty GitHub variable: $Name"
  }

  & gh variable set $Name --body $Value --repo $Repo | Out-Null
  if ($LASTEXITCODE -ne 0) {
    throw "Failed setting GitHub variable $Name."
  }
}

function Set-GhSecret {
  param(
    [string]$Name,
    [string]$Value
  )

  if ([string]::IsNullOrWhiteSpace($Value)) {
    throw "Cannot set empty GitHub secret: $Name"
  }

  $tmp = New-TemporaryFile
  try {
    Set-Content -Path $tmp -Value $Value -NoNewline
    Get-Content $tmp -Raw | & gh secret set $Name --repo $Repo | Out-Null
    if ($LASTEXITCODE -ne 0) {
      throw "Failed setting GitHub secret $Name."
    }
  } finally {
    Remove-Item $tmp -Force -ErrorAction SilentlyContinue
  }
}

function Resolve-OptionalValue {
  param(
    [string]$ExplicitValue,
    [hashtable]$EnvMap,
    [string]$KeyName
  )

  if (-not [string]::IsNullOrWhiteSpace($ExplicitValue)) {
    return $ExplicitValue.Trim()
  }

  if ($EnvMap.ContainsKey($KeyName)) {
    return [string]$EnvMap[$KeyName]
  }

  return ""
}

function Resolve-NetlifyAuthToken {
  param(
    [string]$ExplicitToken,
    [hashtable]$EnvMap
  )

  $candidate = Resolve-OptionalValue -ExplicitValue $ExplicitToken -EnvMap $EnvMap -KeyName "NETLIFY_AUTH_TOKEN"

  if ([string]::IsNullOrWhiteSpace($candidate)) {
    throw "Missing NETLIFY_AUTH_TOKEN. Provide a long-lived Netlify personal access token explicitly or add NETLIFY_AUTH_TOKEN to the root .env file."
  }

  return $candidate.Trim()
}

function Resolve-NetlifySiteId {
  param(
    [string]$ExplicitSiteId,
    [hashtable]$EnvMap
  )

  $candidate = Resolve-OptionalValue -ExplicitValue $ExplicitSiteId -EnvMap $EnvMap -KeyName "NETLIFY_SITE_ID"

  if ([string]::IsNullOrWhiteSpace($candidate)) {
    throw "Missing NETLIFY_SITE_ID. Provide it explicitly or add NETLIFY_SITE_ID to the root .env file."
  }

  return $candidate.Trim()
}

function Resolve-PublicSiteUrl {
  param(
    [string]$ExplicitUrl,
    [hashtable]$EnvMap
  )

  $candidate = if (-not [string]::IsNullOrWhiteSpace($ExplicitUrl)) {
    $ExplicitUrl.Trim()
  } elseif ($EnvMap.ContainsKey("PUBLIC_SITE_URL")) {
    [string]$EnvMap["PUBLIC_SITE_URL"]
  } else {
    ""
  }

  if ([string]::IsNullOrWhiteSpace($candidate)) {
    throw "Missing PUBLIC_SITE_URL. Provide it explicitly or add PUBLIC_SITE_URL to the root .env file."
  }

  return $candidate.TrimEnd("/")
}

function Get-EnvMap {
  param([string]$Path)

  $map = @{}
  if (-not (Test-Path $Path)) {
    return $map
  }

  foreach ($line in Get-Content $Path) {
    if ($line -match '^[A-Za-z_][A-Za-z0-9_]*=') {
      $parts = $line -split '=', 2
      $map[$parts[0]] = $parts[1]
    }
  }

  return $map
}

function New-Password {
  param([int]$Length = 32)
  $chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()-_=+'
  $bytes = New-Object byte[] $Length
  [System.Security.Cryptography.RandomNumberGenerator]::Create().GetBytes($bytes)
  -join ($bytes | ForEach-Object { $chars[$_ % $chars.Length] })
}

function Set-LocalSigningProperties {
  param(
    [string]$Path,
    [string]$StoreFile,
    [string]$StorePassword,
    [string]$KeyAlias,
    [string]$KeyPassword
  )

  @(
    "FLEETFILL_RELEASE_STORE_FILE=$StoreFile"
    "FLEETFILL_RELEASE_STORE_PASSWORD=$StorePassword"
    "FLEETFILL_RELEASE_KEY_ALIAS=$KeyAlias"
    "FLEETFILL_RELEASE_KEY_PASSWORD=$KeyPassword"
  ) | Set-Content -Path $Path
}

if (-not (Test-Path $GoogleServicesPath)) {
  throw "Missing Android Firebase config at $GoogleServicesPath."
}

$googleServices = Get-Content $GoogleServicesPath -Raw | ConvertFrom-Json
$oauthClients = @()
foreach ($client in $googleServices.client) {
  foreach ($oauth in $client.oauth_client) {
    $oauthClients += $oauth
  }
}

$resolvedGoogleWebClientId = if (-not [string]::IsNullOrWhiteSpace($GoogleWebClientId)) {
  $GoogleWebClientId
} else {
  ($oauthClients | Where-Object { $_.client_type -eq 3 } | Select-Object -First 1).client_id
}

$resolvedGoogleIosClientId = if (-not [string]::IsNullOrWhiteSpace($GoogleIosClientId)) {
  $GoogleIosClientId
} else {
  ($oauthClients | Where-Object { $_.client_type -eq 2 } | Select-Object -First 1).client_id
}

if ([string]::IsNullOrWhiteSpace($resolvedGoogleWebClientId)) {
  throw "Could not resolve GOOGLE_WEB_CLIENT_ID from $GoogleServicesPath."
}

function Remove-GhVariable {
  param([string]$Name)

  & gh variable delete $Name --repo $Repo 2>$null | Out-Null
}
$apiKeys = supabase projects api-keys --project-ref $ProjectRef -o json | ConvertFrom-Json
$publishableKey = ($apiKeys | Where-Object { $_.type -eq "publishable" } | Select-Object -First 1).api_key

if ([string]::IsNullOrWhiteSpace($publishableKey)) {
  throw "Could not resolve the Supabase publishable key for $ProjectRef."
}

$envMap = Get-EnvMap -Path ".env"
$resolvedPublicSiteUrl = Resolve-PublicSiteUrl -ExplicitUrl $PublicSiteUrl -EnvMap $envMap
$resolvedSentryDsn = if (-not [string]::IsNullOrWhiteSpace($SentryDsn)) {
  $SentryDsn
} else {
  $envMap["SENTRY_DSN"]
}
$localSigningMap = Get-EnvMap -Path $LocalSigningPropertiesPath
$storePassword = $localSigningMap["FLEETFILL_RELEASE_STORE_PASSWORD"]
$keyPassword = $localSigningMap["FLEETFILL_RELEASE_KEY_PASSWORD"]
$keyAlias = $localSigningMap["FLEETFILL_RELEASE_KEY_ALIAS"]

if ((-not (Test-Path $KeystorePath)) -and $GenerateKeystoreIfMissing) {
  $storePassword = New-Password
  $keyPassword = $storePassword
  $keytool = "C:\Program Files\Java\jdk-26\bin\keytool.exe"
  if (-not (Test-Path $keytool)) {
    $keytool = "C:\Program Files\Android\Android Studio\jbr\bin\keytool.exe"
  }
  if (-not (Test-Path $keytool)) {
    throw "Could not locate keytool.exe to generate a release keystore."
  }

  & $keytool `
    -genkeypair `
    -keystore $KeystorePath `
    -storepass $storePassword `
    -keypass $keyPassword `
    -alias $KeystoreAlias `
    -keyalg RSA `
    -keysize 4096 `
    -validity 10000 `
    -dname "CN=FleetFill, OU=Engineering, O=FleetFill, L=Algiers, S=Algiers, C=DZ" | Out-Null

  if ($LASTEXITCODE -ne 0) {
    throw "Failed to generate the Android release keystore."
  }

  Set-LocalSigningProperties `
    -Path $LocalSigningPropertiesPath `
    -StoreFile "upload-keystore.jks" `
    -StorePassword $storePassword `
    -KeyAlias $KeystoreAlias `
    -KeyPassword $keyPassword

  $keyAlias = $KeystoreAlias

} elseif (Test-Path $KeystorePath) {
  Write-Host "Using existing local Android release keystore."
}

Set-GhVariable -Name "SUPABASE_URL" -Value "https://$ProjectRef.supabase.co"
Set-GhVariable -Name "SUPABASE_PUBLISHABLE_KEY" -Value $publishableKey
Set-GhVariable -Name "PUBLIC_SITE_URL" -Value $resolvedPublicSiteUrl
if (-not [string]::IsNullOrWhiteSpace($resolvedSentryDsn)) {
  Set-GhVariable -Name "SENTRY_DSN" -Value $resolvedSentryDsn
}
Remove-GhVariable -Name "PRODUCTION_SUPABASE_URL"
Remove-GhVariable -Name "PRODUCTION_SUPABASE_PUBLISHABLE_KEY"
Set-GhVariable -Name "GOOGLE_WEB_CLIENT_ID" -Value $resolvedGoogleWebClientId
if (-not [string]::IsNullOrWhiteSpace($resolvedGoogleIosClientId)) {
  Set-GhVariable -Name "GOOGLE_IOS_CLIENT_ID" -Value $resolvedGoogleIosClientId
}

Set-GhSecret -Name "ANDROID_GOOGLE_SERVICES_JSON" -Value (Get-Content $GoogleServicesPath -Raw)

if (-not [string]::IsNullOrWhiteSpace($NetlifySiteId) -or $envMap.ContainsKey("NETLIFY_SITE_ID")) {
  $resolvedNetlifySiteId = Resolve-NetlifySiteId -ExplicitSiteId $NetlifySiteId -EnvMap $envMap
  Set-GhVariable -Name "NETLIFY_SITE_ID" -Value $resolvedNetlifySiteId
}

if (-not [string]::IsNullOrWhiteSpace($NetlifyAuthToken) -or $envMap.ContainsKey("NETLIFY_AUTH_TOKEN")) {
  $resolvedNetlifyAuthToken = Resolve-NetlifyAuthToken -ExplicitToken $NetlifyAuthToken -EnvMap $envMap
  Set-GhSecret -Name "NETLIFY_AUTH_TOKEN" -Value $resolvedNetlifyAuthToken
}

if (Test-Path $KeystorePath) {
  $keystoreBase64 = [Convert]::ToBase64String([IO.File]::ReadAllBytes((Resolve-Path $KeystorePath)))
  Set-GhSecret -Name "ANDROID_RELEASE_KEYSTORE_BASE64" -Value $keystoreBase64
  if (-not [string]::IsNullOrWhiteSpace($storePassword)) {
    Set-GhSecret -Name "ANDROID_RELEASE_STORE_PASSWORD" -Value $storePassword
    Set-GhSecret -Name "ANDROID_RELEASE_KEY_PASSWORD" -Value $(if (-not [string]::IsNullOrWhiteSpace($keyPassword)) { $keyPassword } else { $storePassword })
  }
  Set-GhSecret -Name "ANDROID_RELEASE_KEY_ALIAS" -Value $(if (-not [string]::IsNullOrWhiteSpace($keyAlias)) { $keyAlias } else { $KeystoreAlias })
}

if (-not [string]::IsNullOrWhiteSpace($envMap["SUPABASE_AUTH_EXTERNAL_GOOGLE_CLIENT_SECRET"])) {
  Set-GhSecret -Name "SUPABASE_AUTH_EXTERNAL_GOOGLE_CLIENT_SECRET" -Value $envMap["SUPABASE_AUTH_EXTERNAL_GOOGLE_CLIENT_SECRET"]
}

if (-not [string]::IsNullOrWhiteSpace($envMap["SUPABASE_ACCESS_TOKEN"])) {
  Set-GhSecret -Name "SUPABASE_ACCESS_TOKEN" -Value $envMap["SUPABASE_ACCESS_TOKEN"]
}

if (-not [string]::IsNullOrWhiteSpace($envMap["INTERNAL_AUTOMATION_TOKEN"])) {
  Set-GhSecret -Name "INTERNAL_AUTOMATION_TOKEN" -Value $envMap["INTERNAL_AUTOMATION_TOKEN"]
}

if (-not [string]::IsNullOrWhiteSpace($envMap["TRANSACTIONAL_EMAIL_PROVIDER"])) {
  Set-GhVariable -Name "TRANSACTIONAL_EMAIL_PROVIDER" -Value $envMap["TRANSACTIONAL_EMAIL_PROVIDER"]
}

if (-not [string]::IsNullOrWhiteSpace($envMap["TRANSACTIONAL_EMAIL_PROVIDER_ENDPOINT"])) {
  Set-GhVariable -Name "TRANSACTIONAL_EMAIL_PROVIDER_ENDPOINT" -Value $envMap["TRANSACTIONAL_EMAIL_PROVIDER_ENDPOINT"]
}

if (-not [string]::IsNullOrWhiteSpace($envMap["TRANSACTIONAL_EMAIL_PROVIDER_API_KEY"])) {
  Set-GhSecret -Name "TRANSACTIONAL_EMAIL_PROVIDER_API_KEY" -Value $envMap["TRANSACTIONAL_EMAIL_PROVIDER_API_KEY"]
}

if (-not [string]::IsNullOrWhiteSpace($envMap["TRANSACTIONAL_EMAIL_FROM_EMAIL"])) {
  Set-GhVariable -Name "TRANSACTIONAL_EMAIL_FROM_EMAIL" -Value $envMap["TRANSACTIONAL_EMAIL_FROM_EMAIL"]
}

if (-not [string]::IsNullOrWhiteSpace($envMap["TRANSACTIONAL_EMAIL_PROVIDER_WEBHOOK_SECRET"])) {
  Set-GhSecret -Name "TRANSACTIONAL_EMAIL_PROVIDER_WEBHOOK_SECRET" -Value $envMap["TRANSACTIONAL_EMAIL_PROVIDER_WEBHOOK_SECRET"]
}

if (-not [string]::IsNullOrWhiteSpace($envMap["PUSH_NOTIFICATIONS_ENABLED"])) {
  Set-GhVariable -Name "PUSH_NOTIFICATIONS_ENABLED" -Value $envMap["PUSH_NOTIFICATIONS_ENABLED"]
}

if (-not [string]::IsNullOrWhiteSpace($envMap["PUSH_NOTIFICATIONS_PROVIDER"])) {
  Set-GhVariable -Name "PUSH_NOTIFICATIONS_PROVIDER" -Value $envMap["PUSH_NOTIFICATIONS_PROVIDER"]
}

if (-not [string]::IsNullOrWhiteSpace($envMap["FIREBASE_SERVICE_ACCOUNT_JSON"])) {
  Set-GhSecret -Name "FIREBASE_SERVICE_ACCOUNT_JSON" -Value $envMap["FIREBASE_SERVICE_ACCOUNT_JSON"]
}

Write-Host "Synchronized GitHub production config for $Repo using apps/mobile and apps/admin-web."
