[CmdletBinding()]
param(
  [string]$ProjectRef = "rkvrdzwlynyionsnwfiu",
  [string]$AdminSiteUrl = "https://fleetfill.vercel.app",
  [string]$ProjectDir = "admin-web",
  [string]$VercelScope = "jhonny1994s-projects",
  [string]$SecretKey = "",
  [string]$InternalAutomationToken = "",
  [switch]$RequirePreviewEnv
)

$ErrorActionPreference = "Stop"

function Assert-CommandSucceeded {
  param(
    [int]$ExitCode,
    [string]$Message
  )

  if ($ExitCode -ne 0) {
    throw $Message
  }
}

$expectedFunctions = @(
  "scheduled-automation-tick",
  "signed-file-url",
  "push-dispatch-worker",
  "transactional-email-dispatch-worker",
  "generated-document-worker",
  "email-provider-webhook"
)

$functionsJson = & supabase functions list --project-ref $ProjectRef -o json
Assert-CommandSucceeded -ExitCode $LASTEXITCODE -Message "Failed to list Supabase Edge Functions."
$functions = $functionsJson | ConvertFrom-Json

foreach ($slug in $expectedFunctions) {
  $match = $functions | Where-Object { $_.slug -eq $slug -and $_.status -eq "ACTIVE" }
  if ($null -eq $match) {
    throw "Expected active cloud function '$slug' was not found."
  }
}

$protectedFunctions = @(
  "scheduled-automation-tick",
  "signed-file-url",
  "push-dispatch-worker",
  "transactional-email-dispatch-worker",
  "generated-document-worker"
)

foreach ($slug in $protectedFunctions) {
  try {
    $null = Invoke-WebRequest -Uri "https://$ProjectRef.supabase.co/functions/v1/$slug" -Method POST -UseBasicParsing -ErrorAction Stop
    throw "Protected function '$slug' unexpectedly allowed an unauthenticated request."
  } catch {
    $statusCode = $_.Exception.Response.StatusCode.value__
    if ($statusCode -ne 401) {
      throw "Protected function '$slug' returned $statusCode instead of 401."
    }
  }
}

try {
  $null = Invoke-WebRequest -Uri "https://$ProjectRef.supabase.co/functions/v1/email-provider-webhook" -Method POST -UseBasicParsing -ErrorAction Stop
  throw "Webhook function unexpectedly accepted an unsigned request."
} catch {
  $statusCode = $_.Exception.Response.StatusCode.value__
  if ($statusCode -ne 401) {
    throw "Webhook function returned $statusCode instead of 401."
  }
}

$signInResponse = Invoke-WebRequest -Uri "$AdminSiteUrl/ar/sign-in" -UseBasicParsing
if ($signInResponse.StatusCode -lt 200 -or $signInResponse.StatusCode -ge 400) {
  throw "Admin sign-in page returned status $($signInResponse.StatusCode)."
}

$supabaseSecretKey = $SecretKey
$resolvedInternalAutomationToken = $InternalAutomationToken
if (([string]::IsNullOrWhiteSpace($supabaseSecretKey) -or [string]::IsNullOrWhiteSpace($resolvedInternalAutomationToken)) -and (Test-Path ".env")) {
  foreach ($line in Get-Content ".env") {
    if ($line -match '^SUPABASE_SECRET_KEY=') {
      $supabaseSecretKey = ($line -split '=', 2)[1]
    }
    if ($line -match '^INTERNAL_AUTOMATION_TOKEN=') {
      $resolvedInternalAutomationToken = ($line -split '=', 2)[1]
    }
  }
}

if (-not [string]::IsNullOrWhiteSpace($supabaseSecretKey)) {
  $rpcHeaders = @{
    apikey        = $supabaseSecretKey
    Authorization = "Bearer $supabaseSecretKey"
    "Content-Type" = "application/json"
  }

  $schedulerStatus = Invoke-RestMethod `
    -Uri "https://$ProjectRef.supabase.co/rest/v1/rpc/scheduled_automation_status" `
    -Method Post `
    -Headers $rpcHeaders `
    -Body "{}"

  if (@($schedulerStatus).Count -eq 0) {
    throw "Hosted scheduled automation job is not installed."
  }

  $wilayas = Invoke-RestMethod `
    -Uri "https://$ProjectRef.supabase.co/rest/v1/wilayas?select=id&limit=1" `
    -Method Get `
    -Headers $rpcHeaders

  if (@($wilayas).Count -eq 0) {
    throw "Hosted location seed is missing: table 'wilayas' returned no rows."
  }
}

if (-not [string]::IsNullOrWhiteSpace($resolvedInternalAutomationToken)) {
  $authHeaders = @{
    Authorization = "Bearer $resolvedInternalAutomationToken"
    "Content-Type" = "application/json"
  }

  $response = Invoke-WebRequest `
    -Uri "https://$ProjectRef.supabase.co/functions/v1/scheduled-automation-tick" `
    -Method POST `
    -Headers $authHeaders `
    -Body "{}" `
    -UseBasicParsing

  if ($response.StatusCode -lt 200 -or $response.StatusCode -ge 600) {
    throw "Protected function 'scheduled-automation-tick' did not accept the internal automation token."
  }
}

$productionEnvJson = cmd /c "vercel env ls production --format json --scope $VercelScope --cwd $ProjectDir 2>&1"
Assert-CommandSucceeded -ExitCode $LASTEXITCODE -Message "Failed to list Vercel production environment variables."
$productionEnvPayload = (($productionEnvJson -join "`n") -replace '^[^{]*', '') | ConvertFrom-Json
$productionEnv = $productionEnvPayload.envs

foreach ($requiredVar in @("NEXT_PUBLIC_SUPABASE_URL", "NEXT_PUBLIC_SUPABASE_ANON_KEY", "NEXT_PUBLIC_SITE_URL")) {
  if (($productionEnv | Where-Object { $_.key -eq $requiredVar }).Count -eq 0) {
    throw "Missing Vercel production environment variable '$requiredVar'."
  }
}

if ($RequirePreviewEnv) {
  $previewEnvJson = cmd /c "vercel env ls preview --format json --scope $VercelScope --cwd $ProjectDir 2>&1"
  Assert-CommandSucceeded -ExitCode $LASTEXITCODE -Message "Failed to list Vercel preview environment variables."
  $previewEnvPayload = (($previewEnvJson -join "`n") -replace '^[^{]*', '') | ConvertFrom-Json
  $previewEnv = $previewEnvPayload.envs

  foreach ($requiredVar in @("NEXT_PUBLIC_SUPABASE_URL", "NEXT_PUBLIC_SUPABASE_ANON_KEY", "NEXT_PUBLIC_SITE_URL")) {
    if (($previewEnv | Where-Object { $_.key -eq $requiredVar }).Count -eq 0) {
      throw "Missing Vercel preview environment variable '$requiredVar'."
    }
  }
}

Write-Host "Hosted rollout verification passed for Supabase cloud and Vercel."
