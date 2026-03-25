[CmdletBinding()]
param(
  [string]$EnvFile = ".env",
  [string]$ProjectUrl = "",
  [string]$ApiKey = ""
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
$serviceRoleKey = if (-not [string]::IsNullOrWhiteSpace($ApiKey)) { $ApiKey } else { $envMap["SUPABASE_SERVICE_ROLE_KEY"] }

if ([string]::IsNullOrWhiteSpace($projectUrl)) {
  throw "Missing SUPABASE_URL in $EnvFile."
}

if ([string]::IsNullOrWhiteSpace($serviceRoleKey)) {
  throw "Missing SUPABASE_SERVICE_ROLE_KEY in $EnvFile."
}

$headers = @{
  apikey        = $serviceRoleKey
  Authorization = "Bearer $serviceRoleKey"
  "Content-Type" = "application/json"
}

$body = @{
  project_url  = $projectUrl
  bearer_token = $serviceRoleKey
} | ConvertTo-Json -Depth 4

Invoke-RestMethod `
  -Uri "$projectUrl/rest/v1/rpc/configure_scheduled_automation" `
  -Method Post `
  -Headers $headers `
  -Body $body | Out-Null

Write-Host "Configured hosted scheduler via service-role RPC."
