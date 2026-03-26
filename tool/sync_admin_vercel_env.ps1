[CmdletBinding()]
param(
  [string]$ProjectDir = "apps/admin-web",
  [string]$ProjectRef = "rkvrdzwlynyionsnwfiu",
  [string[]]$TargetEnvironments = @("production"),
  [string]$SiteUrl = "https://fleetfill.vercel.app",
  [string]$Scope = "jhonny1994s-projects"
)

$ErrorActionPreference = "Stop"

$apiKeys = supabase projects api-keys --project-ref $ProjectRef -o json | ConvertFrom-Json
$anonKey = ($apiKeys | Where-Object { $_.name -eq "anon" }).api_key

if ([string]::IsNullOrWhiteSpace($anonKey)) {
  throw "Could not resolve the cloud anon key for project $ProjectRef."
}

$values = [ordered]@{
  NEXT_PUBLIC_SUPABASE_URL = "https://$ProjectRef.supabase.co"
  NEXT_PUBLIC_SUPABASE_ANON_KEY = $anonKey
  NEXT_PUBLIC_SITE_URL = $SiteUrl
}

foreach ($environment in $TargetEnvironments) {
  foreach ($entry in $values.GetEnumerator()) {
    & vercel env rm $entry.Key $environment --yes --scope $Scope --cwd $ProjectDir | Out-Null
    if ($LASTEXITCODE -gt 1) {
      throw "Failed removing existing Vercel env var $($entry.Key) for $environment."
    }

    & vercel env add $entry.Key $environment --value $entry.Value --yes --scope $Scope --cwd $ProjectDir | Out-Null
    if ($LASTEXITCODE -ne 0) {
      throw "Failed setting Vercel env var $($entry.Key) for $environment."
    }
  }
}

Write-Host "Synchronized apps/admin-web Vercel environment values."
