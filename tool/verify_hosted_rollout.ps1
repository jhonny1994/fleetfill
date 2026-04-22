[CmdletBinding()]
param(
  [string]$ProjectRef = "",
  [string]$SupabaseUrl = "",
  [string]$AdminSiteUrl = "",
  [string]$SecretKey = "",
  [string]$InternalAutomationToken = ""
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

function Assert-CommandSucceeded {
  param(
    [int]$ExitCode,
    [string]$Message
  )

  if ($ExitCode -ne 0) {
    throw $Message
  }
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

function Resolve-HostedAdminSiteUrl {
  param([string]$ExplicitUrl)

  Assert-HasValue -Name "AdminSiteUrl" -Value $ExplicitUrl -ResolutionHint "Pass -AdminSiteUrl explicitly or provide PUBLIC_SITE_URL in the caller environment."
  return $ExplicitUrl.Trim().TrimEnd("/")
}

$resolvedProjectRef = Resolve-SupabaseProjectRef -ExplicitProjectRef $ProjectRef -ExplicitSupabaseUrl $SupabaseUrl
$resolvedAdminSiteUrl = Resolve-HostedAdminSiteUrl -ExplicitUrl $AdminSiteUrl

$expectedFunctions = @(
  "scheduled-automation-tick",
  "signed-file-url",
  "push-dispatch-worker",
  "transactional-email-dispatch-worker",
  "generated-document-worker",
  "email-provider-webhook"
)

$functionsJson = & supabase functions list --project-ref $resolvedProjectRef -o json
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
    $null = Invoke-WebRequest -Uri "https://$resolvedProjectRef.supabase.co/functions/v1/$slug" -Method POST -UseBasicParsing -ErrorAction Stop
    throw "Protected function '$slug' unexpectedly allowed an unauthenticated request."
  } catch {
    $statusCode = $_.Exception.Response.StatusCode.value__
    if ($statusCode -ne 401) {
      throw "Protected function '$slug' returned $statusCode instead of 401."
    }
  }
}

try {
  $null = Invoke-WebRequest -Uri "https://$resolvedProjectRef.supabase.co/functions/v1/email-provider-webhook" -Method POST -UseBasicParsing -ErrorAction Stop
  throw "Webhook function unexpectedly accepted an unsigned request."
} catch {
  $statusCode = $_.Exception.Response.StatusCode.value__
  if ($statusCode -ne 401) {
    throw "Webhook function returned $statusCode instead of 401."
  }
}

$signInResponse = Invoke-WebRequest -Uri "$resolvedAdminSiteUrl/ar/sign-in" -UseBasicParsing
if ($signInResponse.StatusCode -lt 200 -or $signInResponse.StatusCode -ge 400) {
  throw "Admin sign-in page returned status $($signInResponse.StatusCode)."
}

$supabaseSecretKey = $SecretKey
$resolvedInternalAutomationToken = $InternalAutomationToken
if ([string]::IsNullOrWhiteSpace($resolvedInternalAutomationToken) -and (Test-Path ".env")) {
  foreach ($line in Get-Content ".env") {
    if ($line -match '^INTERNAL_AUTOMATION_TOKEN=') {
      $resolvedInternalAutomationToken = ($line -split '=', 2)[1]
    }
  }
}

if ([string]::IsNullOrWhiteSpace($supabaseSecretKey) -or $supabaseSecretKey -match '·') {
  $supabaseSecretKey = Resolve-CloudAdminKey -ProjectRef $resolvedProjectRef
}

if (-not [string]::IsNullOrWhiteSpace($supabaseSecretKey)) {
  $rpcHeaders = @{
    apikey        = $supabaseSecretKey
    Authorization = "Bearer $supabaseSecretKey"
    "Content-Type" = "application/json"
  }

  $schedulerStatus = Invoke-RestMethod `
    -Uri "https://$resolvedProjectRef.supabase.co/rest/v1/rpc/scheduled_automation_status" `
    -Method Post `
    -Headers $rpcHeaders `
    -Body "{}"

  if (@($schedulerStatus).Count -eq 0) {
    throw "Hosted scheduled automation job is not installed."
  }

  $wilayas = Invoke-RestMethod `
    -Uri "https://$resolvedProjectRef.supabase.co/rest/v1/wilayas?select=id&limit=1" `
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
    -Uri "https://$resolvedProjectRef.supabase.co/functions/v1/scheduled-automation-tick" `
    -Method POST `
    -Headers $authHeaders `
    -Body "{}" `
    -UseBasicParsing

  if ($response.StatusCode -lt 200 -or $response.StatusCode -ge 600) {
    throw "Protected function 'scheduled-automation-tick' did not accept the internal automation token."
  }
}
Write-Host "Hosted rollout verification passed for backend/supabase and the configured admin-web host."
