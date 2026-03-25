[CmdletBinding()]
param(
  [string]$EnvFile = ".env",
  [string]$ProjectUrl = "",
  [string]$SecretKey = "",
  [string]$InternalAutomationToken = ""
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

$envMap = Get-EnvMap -Path $EnvFile
$projectUrl = if (-not [string]::IsNullOrWhiteSpace($ProjectUrl)) { $ProjectUrl } else { $envMap["SUPABASE_URL"] }
$supabaseSecretKey = if (-not [string]::IsNullOrWhiteSpace($SecretKey)) { $SecretKey } else { $envMap["SUPABASE_SECRET_KEY"] }
$resolvedInternalAutomationToken = if (-not [string]::IsNullOrWhiteSpace($InternalAutomationToken)) { $InternalAutomationToken } else { $envMap["INTERNAL_AUTOMATION_TOKEN"] }

if ([string]::IsNullOrWhiteSpace($projectUrl)) {
  throw "Missing SUPABASE_URL in $EnvFile."
}

if ([string]::IsNullOrWhiteSpace($supabaseSecretKey)) {
  throw "Missing SUPABASE_SECRET_KEY in $EnvFile."
}

if ([string]::IsNullOrWhiteSpace($resolvedInternalAutomationToken)) {
  throw "Missing INTERNAL_AUTOMATION_TOKEN in $EnvFile."
}

$headers = @{
  apikey        = $supabaseSecretKey
  Authorization = "Bearer $supabaseSecretKey"
  "Content-Type" = "application/json"
}

$body = @{
  project_url               = $projectUrl
  internal_automation_token = $resolvedInternalAutomationToken
} | ConvertTo-Json -Depth 4

Invoke-RestMethod `
  -Uri "$projectUrl/rest/v1/rpc/configure_scheduled_automation" `
  -Method Post `
  -Headers $headers `
  -Body $body | Out-Null

Write-Host "Configured hosted scheduler with the internal automation token."
