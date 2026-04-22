[CmdletBinding()]
param(
  [string]$ProjectRef = "",
  [string]$EnvFile = ".env",
  [string]$SupabaseUrl = "",
  [string]$AdminSiteUrl = "",
  [string]$MobileDir = "apps/mobile",
  [string]$AdminWebDir = "apps/admin-web",
  [string]$SupabaseDir = "backend",
  [switch]$SkipLocalGate,
  [switch]$SkipScheduler,
  [switch]$SkipHostedVerify
)

$ErrorActionPreference = "Stop"

function Resolve-CloudAdminKey {
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

  throw "Could not resolve a usable cloud admin API key for $ProjectRef."
}

function Assert-HasValue {
  param(
    [string]$Name,
    [string]$Value,
    [string]$ResolutionHint = ""
  )

  if (-not [string]::IsNullOrWhiteSpace($Value)) {
    return
  }

  if (-not [string]::IsNullOrWhiteSpace($ResolutionHint)) {
    throw "Missing $Name. $ResolutionHint"
  }

  throw "Missing $Name."
}

function Resolve-SupabaseProjectRef {
  param(
    [string]$ExplicitProjectRef,
    [string]$ExplicitSupabaseUrl
  )

  if (-not [string]::IsNullOrWhiteSpace($ExplicitProjectRef)) {
    return $ExplicitProjectRef.Trim()
  }

  Assert-HasValue -Name "SUPABASE_URL or ProjectRef" -Value $ExplicitSupabaseUrl -ResolutionHint "Pass -ProjectRef explicitly or provide -SupabaseUrl."
  $uri = [Uri]$ExplicitSupabaseUrl.Trim()
  $hostParts = $uri.Host.Split(".")
  if ($hostParts.Length -lt 3 -or $hostParts[1] -ne "supabase" -or $hostParts[2] -ne "co") {
    throw "Could not derive a Supabase project ref from '$ExplicitSupabaseUrl'."
  }

  return $hostParts[0]
}

function Resolve-PublicSiteUrl {
  param([string]$ExplicitUrl)

  Assert-HasValue -Name "AdminSiteUrl" -Value $ExplicitUrl -ResolutionHint "Pass -AdminSiteUrl explicitly before running hosted rollout verification."
  return $ExplicitUrl.Trim().TrimEnd("/")
}

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
  Invoke-Checked -Description "Flutter analyze" -Script { Push-Location $MobileDir; try { dart analyze } finally { Pop-Location } }
  Invoke-Checked -Description "Flutter tests" -Script { Push-Location $MobileDir; try { flutter test } finally { Pop-Location } }
  Invoke-Checked -Description "Admin web lint" -Script { pnpm --dir $AdminWebDir lint }
  Invoke-Checked -Description "Admin web typecheck" -Script { pnpm --dir $AdminWebDir typecheck }
  Invoke-Checked -Description "Admin web tests" -Script { pnpm --dir $AdminWebDir test }
  Invoke-Checked -Description "Admin web build" -Script { pnpm --dir $AdminWebDir build }
  Invoke-Checked -Description "Supabase local reset" -Script { supabase db reset --workdir $SupabaseDir --yes }
  Invoke-Checked -Description "Supabase db lint" -Script { supabase db lint --workdir $SupabaseDir }
  Invoke-Checked -Description "Supabase db tests" -Script { supabase test db --workdir $SupabaseDir }
}

$resolvedProjectRef = Resolve-SupabaseProjectRef -ExplicitProjectRef $ProjectRef -ExplicitSupabaseUrl $SupabaseUrl
$resolvedAdminSiteUrl = Resolve-PublicSiteUrl -ExplicitUrl $AdminSiteUrl

Invoke-Checked -Description "Push Supabase migrations and seed data" -Script { supabase db push --workdir $SupabaseDir --linked --include-seed }
Invoke-Checked -Description "Push Supabase config" -Script { supabase config push --workdir $SupabaseDir --project-ref $resolvedProjectRef --yes }
Invoke-Checked -Description "Sync Supabase cloud secrets" -Script { powershell -NoProfile -ExecutionPolicy Bypass -File tool/sync_supabase_cloud_secrets.ps1 -ProjectRef $resolvedProjectRef -EnvFile $EnvFile }

$deployableFunctions = Get-ChildItem (Join-Path $SupabaseDir "supabase/functions") -Directory |
  Where-Object { Test-Path (Join-Path $_.FullName "index.ts") } |
  Select-Object -ExpandProperty Name

foreach ($functionName in $deployableFunctions) {
  Invoke-Checked -Description "Deploy Supabase function $functionName" -Script {
    supabase functions deploy $functionName --project-ref $resolvedProjectRef --workdir $SupabaseDir
  }
}

$cloudSecretKey = Resolve-CloudAdminKey -ProjectRef $resolvedProjectRef

$internalAutomationToken = ""
if (Test-Path $EnvFile) {
  foreach ($line in Get-Content $EnvFile) {
    if ($line -match '^INTERNAL_AUTOMATION_TOKEN=') {
      $internalAutomationToken = ($line -split '=', 2)[1]
    }
  }
}
if ([string]::IsNullOrWhiteSpace($internalAutomationToken)) {
  throw "Missing INTERNAL_AUTOMATION_TOKEN in $EnvFile."
}

if (-not $SkipScheduler) {
  Invoke-Checked -Description "Configure hosted scheduler" -Script {
    powershell -NoProfile -ExecutionPolicy Bypass -File tool/apply_supabase_scheduler.ps1 -EnvFile $EnvFile -ProjectUrl "https://$resolvedProjectRef.supabase.co" -SecretKey $cloudSecretKey -InternalAutomationToken $internalAutomationToken
  }
}

if (-not $SkipHostedVerify) {
  Invoke-Checked -Description "Verify hosted rollout" -Script {
    powershell -NoProfile -ExecutionPolicy Bypass -File tool/verify_hosted_rollout.ps1 -ProjectRef $resolvedProjectRef -AdminSiteUrl $resolvedAdminSiteUrl -SecretKey $cloudSecretKey -InternalAutomationToken $internalAutomationToken
  }
}

Write-Host "Cloud rollout sync completed. Push the active deployment branch to let the admin-web hosting adapter publish the latest apps/admin-web commit."
