[CmdletBinding()]
param(
  [string]$ProjectRef = "rkvrdzwlynyionsnwfiu",
  [string]$EnvFile = ".env"
)

$ErrorActionPreference = "Stop"

function Get-EnvMap {
  param([string]$Path)

  if (-not (Test-Path $Path)) {
    throw "Environment file not found: $Path"
  }

  $map = @{}
  foreach ($line in Get-Content $Path) {
    if ($line -match '^[A-Za-z_][A-Za-z0-9_]*=') {
      $parts = $line -split '=', 2
      $map[$parts[0]] = $parts[1]
    }
  }

  return $map
}

function Resolve-CloudServiceClientKey {
  param([string]$ProjectRef)

  $apiKeys = supabase projects api-keys --project-ref $ProjectRef -o json | ConvertFrom-Json
  $legacyServiceRoleKey = ($apiKeys | Where-Object { $_.name -eq "service_role" } | Select-Object -First 1).api_key
  if (-not [string]::IsNullOrWhiteSpace($legacyServiceRoleKey)) {
    return $legacyServiceRoleKey
  }

  $secretKey = ($apiKeys | Where-Object { $_.type -eq "secret" } | Select-Object -First 1).api_key
  if (-not [string]::IsNullOrWhiteSpace($secretKey) -and $secretKey -notmatch '·') {
    return $secretKey
  }

  throw "Could not resolve a usable cloud service credential for $ProjectRef."
}

$envMap = Get-EnvMap -Path $EnvFile
$cloudServiceClientKey = Resolve-CloudServiceClientKey -ProjectRef $ProjectRef
$secretValues = [ordered]@{
  SB_SECRET_KEY                        = $cloudServiceClientKey
  INTERNAL_AUTOMATION_TOKEN             = $envMap["INTERNAL_AUTOMATION_TOKEN"]
  TRANSACTIONAL_EMAIL_PROVIDER            = $envMap["TRANSACTIONAL_EMAIL_PROVIDER"]
  TRANSACTIONAL_EMAIL_PROVIDER_ENDPOINT   = $envMap["TRANSACTIONAL_EMAIL_PROVIDER_ENDPOINT"]
  TRANSACTIONAL_EMAIL_PROVIDER_API_KEY    = $envMap["TRANSACTIONAL_EMAIL_PROVIDER_API_KEY"]
  TRANSACTIONAL_EMAIL_FROM_EMAIL          = $envMap["TRANSACTIONAL_EMAIL_FROM_EMAIL"]
  TRANSACTIONAL_EMAIL_PROVIDER_WEBHOOK_SECRET = $envMap["TRANSACTIONAL_EMAIL_PROVIDER_WEBHOOK_SECRET"]
  PUSH_NOTIFICATIONS_ENABLED              = $envMap["PUSH_NOTIFICATIONS_ENABLED"]
  PUSH_NOTIFICATIONS_PROVIDER             = $envMap["PUSH_NOTIFICATIONS_PROVIDER"]
  FIREBASE_SERVICE_ACCOUNT_JSON           = $envMap["FIREBASE_SERVICE_ACCOUNT_JSON"]
}

foreach ($entry in $secretValues.GetEnumerator()) {
  if ([string]::IsNullOrWhiteSpace($entry.Value)) {
    throw "Missing required secret value for $($entry.Key) in $EnvFile."
  }

  & supabase secrets set --project-ref $ProjectRef "$($entry.Key)=$($entry.Value)" | Out-Null
  if ($LASTEXITCODE -ne 0) {
    throw "Failed setting cloud secret $($entry.Key)."
  }
}

Write-Host "Synchronized Supabase cloud secrets for $ProjectRef."
