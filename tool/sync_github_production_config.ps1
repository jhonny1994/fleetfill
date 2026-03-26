[CmdletBinding()]
param(
  [string]$Repo = "jhonny1994/fleetfill",
  [string]$ProjectRef = "rkvrdzwlynyionsnwfiu",
  [string]$GoogleServicesPath = "apps/mobile/android/app/google-services.json",
  [string]$VercelProjectFile = "apps/admin-web/.vercel/project.json",
  [string]$KeystorePath = "apps/mobile/android/app/upload-keystore.jks",
  [string]$LocalSigningPropertiesPath = "apps/mobile/android/app/release-signing.local.properties",
  [string]$KeystoreAlias = "fleetfill-upload",
  [string]$GoogleWebClientId = "",
  [string]$GoogleIosClientId = "",
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
$apiKeys = supabase projects api-keys --project-ref $ProjectRef -o json | ConvertFrom-Json
$publishableKey = ($apiKeys | Where-Object { $_.type -eq "publishable" } | Select-Object -First 1).api_key

if ([string]::IsNullOrWhiteSpace($publishableKey)) {
  throw "Could not resolve the Supabase publishable key for $ProjectRef."
}

$vercelProject = Get-Content $VercelProjectFile -Raw | ConvertFrom-Json
$vercelAuth = Get-Content "$env:APPDATA\com.vercel.cli\Data\auth.json" -Raw | ConvertFrom-Json
$envMap = Get-EnvMap -Path ".env"
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

Set-GhVariable -Name "PRODUCTION_SUPABASE_URL" -Value "https://$ProjectRef.supabase.co"
Set-GhVariable -Name "PRODUCTION_SUPABASE_PUBLISHABLE_KEY" -Value $publishableKey
Set-GhVariable -Name "GOOGLE_WEB_CLIENT_ID" -Value $resolvedGoogleWebClientId
if (-not [string]::IsNullOrWhiteSpace($resolvedGoogleIosClientId)) {
  Set-GhVariable -Name "GOOGLE_IOS_CLIENT_ID" -Value $resolvedGoogleIosClientId
}
Set-GhVariable -Name "VERCEL_ORG_ID" -Value $vercelProject.orgId
Set-GhVariable -Name "VERCEL_ADMIN_WEB_PROJECT_ID" -Value $vercelProject.projectId

Set-GhSecret -Name "ANDROID_GOOGLE_SERVICES_JSON" -Value (Get-Content $GoogleServicesPath -Raw)
Set-GhSecret -Name "VERCEL_TOKEN" -Value $vercelAuth.token

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
