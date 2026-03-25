[CmdletBinding()]
param(
  [string]$ProjectRef = "rkvrdzwlynyionsnwfiu",
  [string]$EnvFile = ".env",
  [string]$AdminSiteUrl = "https://fleetfill.vercel.app",
  [string]$VercelScope = "jhonny1994s-projects",
  [switch]$SkipLocalGate,
  [switch]$SkipScheduler,
  [switch]$SkipHostedVerify
)

$ErrorActionPreference = "Stop"

function Invoke-Checked {
  param(
    [Parameter(Mandatory = $true)]
    [string]$Description,
    [Parameter(Mandatory = $true)]
    [scriptblock]$Script
  )

  Write-Host "==> $Description"
  & $Script
  if ($LASTEXITCODE -ne 0) {
    throw "$Description failed with exit code $LASTEXITCODE."
  }
}

if (-not $SkipLocalGate) {
  Invoke-Checked -Description "Flutter analyze" -Script { dart analyze }
  Invoke-Checked -Description "Flutter tests" -Script { flutter test }
  Invoke-Checked -Description "Admin web lint" -Script { pnpm --dir admin-web lint }
  Invoke-Checked -Description "Admin web typecheck" -Script { pnpm --dir admin-web typecheck }
  Invoke-Checked -Description "Admin web tests" -Script { pnpm --dir admin-web test }
  Invoke-Checked -Description "Admin web build" -Script { pnpm --dir admin-web build }
  Invoke-Checked -Description "Supabase local reset" -Script { supabase db reset --yes }
  Invoke-Checked -Description "Supabase db lint" -Script { supabase db lint }
  Invoke-Checked -Description "Supabase db tests" -Script { supabase test db }
}

Invoke-Checked -Description "Push Supabase migrations" -Script { supabase db push --linked }
Invoke-Checked -Description "Push Supabase config" -Script { supabase config push --project-ref $ProjectRef --yes }
Invoke-Checked -Description "Sync Supabase cloud secrets" -Script { powershell -NoProfile -ExecutionPolicy Bypass -File tool/sync_supabase_cloud_secrets.ps1 -ProjectRef $ProjectRef -EnvFile $EnvFile }

$deployableFunctions = Get-ChildItem "supabase/functions" -Directory |
  Where-Object { Test-Path (Join-Path $_.FullName "index.ts") } |
  Select-Object -ExpandProperty Name

foreach ($functionName in $deployableFunctions) {
  Invoke-Checked -Description "Deploy Supabase function $functionName" -Script {
    supabase functions deploy $functionName --project-ref $ProjectRef
  }
}

$apiKeys = supabase projects api-keys --project-ref $ProjectRef -o json | ConvertFrom-Json
$cloudApiKey = ($apiKeys | Where-Object { $_.type -eq "legacy" -and $_.name -eq "service_role" } | Select-Object -First 1).api_key
if ([string]::IsNullOrWhiteSpace($cloudApiKey)) {
  $cloudApiKey = ($apiKeys | Where-Object { $_.type -eq "secret" } | Select-Object -First 1).api_key
}
if ([string]::IsNullOrWhiteSpace($cloudApiKey)) {
  throw "Could not resolve the cloud Supabase secret API key for $ProjectRef."
}

if (-not $SkipScheduler) {
  Invoke-Checked -Description "Configure hosted scheduler" -Script {
    powershell -NoProfile -ExecutionPolicy Bypass -File tool/apply_supabase_scheduler.ps1 -EnvFile $EnvFile -ProjectUrl "https://$ProjectRef.supabase.co" -ApiKey $cloudApiKey
  }
}

Invoke-Checked -Description "Sync admin-web Vercel env" -Script {
  powershell -NoProfile -ExecutionPolicy Bypass -File tool/sync_admin_vercel_env.ps1 -ProjectDir admin-web -ProjectRef $ProjectRef -SiteUrl $AdminSiteUrl -Scope $VercelScope
}

if (-not $SkipHostedVerify) {
  Invoke-Checked -Description "Verify hosted rollout" -Script {
    powershell -NoProfile -ExecutionPolicy Bypass -File tool/verify_hosted_rollout.ps1 -ProjectRef $ProjectRef -AdminSiteUrl $AdminSiteUrl -ProjectDir admin-web -VercelScope $VercelScope -ApiKey $cloudApiKey
  }
}

Write-Host "Cloud rollout sync completed. Push main to let Vercel Git integration publish the latest admin-web commit."
