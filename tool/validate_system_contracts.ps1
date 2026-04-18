[CmdletBinding()]
param()

$ErrorActionPreference = "Stop"

function Assert-Contains {
  param(
    [string]$Content,
    [string]$Expected,
    [string]$Message
  )

  if (-not $Content.Contains($Expected)) {
    throw $Message
  }
}

function Get-FileText {
  param([string]$Path)
  return [System.IO.File]::ReadAllText((Resolve-Path $Path))
}

function Get-LineMatch {
  param(
    [string]$Content,
    [string]$Pattern,
    [string]$Message
  )

  $match = [regex]::Match($Content, $Pattern)
  if (-not $match.Success) {
    throw $Message
  }

  return $match
}

$mobilePubspec = Get-FileText "apps/mobile/pubspec.yaml"
$mobileVersionMatch = Get-LineMatch $mobilePubspec '(?m)^version:\s+([0-9]+\.[0-9]+\.[0-9]+\+[0-9]+)\s*$' "apps/mobile/pubspec.yaml is missing a semantic version with Android build metadata."
$mobileVersion = $mobileVersionMatch.Groups[1].Value

$mobileAuth = Get-FileText "apps/mobile/lib/core/auth/auth_repository.dart"
Assert-Contains $mobileAuth "const fleetFillPublicSiteOrigin = 'https://fleetfill.vercel.app';" "Mobile auth contract is missing the canonical public origin."
Assert-Contains $mobileAuth "const mobileAuthCallbackPath = '/auth/mobile-callback';" "Mobile auth contract is missing the canonical callback path."
Assert-Contains $mobileAuth "const hostedAuthRedirectUri =" "Mobile auth contract is missing the hosted callback URI."
Assert-Contains $mobileAuth "'`$fleetFillPublicSiteOrigin`$mobileAuthCallbackPath';" "Mobile auth contract is missing the hosted callback URI."
Assert-Contains $mobileAuth "const localAuthRedirectUri = 'com.carbodex.fleetfill://auth-callback';" "Mobile auth contract is missing the local custom-scheme fallback."

$supabaseConfig = Get-FileText "backend/supabase/config.toml"
Assert-Contains $supabaseConfig 'site_url = "https://fleetfill.vercel.app"' "Supabase config is missing the canonical public site URL."
Assert-Contains $supabaseConfig '"com.carbodex.fleetfill://auth-callback"' "Supabase config is missing the local mobile custom-scheme redirect."
Assert-Contains $supabaseConfig '"http://localhost:3000/**"' "Supabase config is missing the documented local admin-web dev host."
Assert-Contains $supabaseConfig '"http://127.0.0.1:3005/**"' "Supabase config is missing the documented Playwright/CI host."
Assert-Contains $supabaseConfig '"https://fleetfill.vercel.app/auth/mobile-callback"' "Supabase config is missing the canonical hosted mobile callback URL."

$adminEnv = Get-FileText "apps/admin-web/.env.example"
Assert-Contains $adminEnv "NEXT_PUBLIC_SITE_URL=https://fleetfill.vercel.app" "Admin-web env example is not aligned with the canonical public origin."
Assert-Contains $adminEnv "# NEXT_PUBLIC_SITE_URL=http://localhost:3000" "Admin-web env example is missing the local developer host example."
Assert-Contains $adminEnv "# NEXT_PUBLIC_SITE_URL=http://127.0.0.1:3005" "Admin-web env example is missing the Playwright/CI host example."

$proxyFile = Get-FileText "apps/admin-web/proxy.ts"
Assert-Contains $proxyFile 'const bypassLocalizedRouting = pathname === "/auth/mobile-callback";' "Admin-web proxy does not preserve the mobile callback route outside locale redirects."

$assetLinksPath = "apps/admin-web/public/.well-known/assetlinks.json"
if (-not (Test-Path $assetLinksPath)) {
  throw "Missing apps/admin-web/public/.well-known/assetlinks.json for Android App Links verification."
}
$assetLinks = Get-FileText $assetLinksPath
Assert-Contains $assetLinks '"package_name": "com.carbodex.fleetfill"' "assetlinks.json is missing the FleetFill Android package name."
Assert-Contains $assetLinks '"delegate_permission/common.handle_all_urls"' "assetlinks.json is missing the handle_all_urls relation."

$proprietaryNoticePath = "PROPRIETARY-NOTICE.md"
if (-not (Test-Path $proprietaryNoticePath)) {
  throw "Missing top-level PROPRIETARY-NOTICE.md."
}

$rootReadme = Get-FileText "README.en.md"
Assert-Contains $rootReadme "This repository is publicly visible" "English README is missing the public-but-proprietary posture."
Assert-Contains $rootReadme "PROPRIETARY-NOTICE.md" "English README is missing the link to the proprietary notice."

$releaseWorkflow = Get-FileText ".github/workflows/release.yml"
Assert-Contains $releaseWorkflow "name: Validate Release Request" "Root release workflow is missing the release-request validation job."
Assert-Contains $releaseWorkflow 'release_tag is required when release_mobile is enabled.' "Root release workflow does not fail clearly when mobile release_tag is omitted."
Assert-Contains $releaseWorkflow 'expected_tag="v${mobile_version}"' "Root release workflow is missing the mobile version-to-tag validation."
Assert-Contains $releaseWorkflow "validate_only:" "Root release workflow is missing the safe validate_only rehearsal mode."

$flutterReleaseWorkflow = Get-FileText ".github/workflows/production_flutter.yml"
Assert-Contains $flutterReleaseWorkflow "environment: Production" "Production Flutter workflow is not bound to the Production environment."
Assert-Contains $flutterReleaseWorkflow 'vars.SUPABASE_URL' "Production Flutter workflow is not using the canonical SUPABASE_URL GitHub variable."
Assert-Contains $flutterReleaseWorkflow 'vars.SUPABASE_PUBLISHABLE_KEY' "Production Flutter workflow is not using the canonical SUPABASE_PUBLISHABLE_KEY GitHub variable."
Assert-Contains $flutterReleaseWorkflow 'vars.SENTRY_DSN' "Production Flutter workflow is not using the canonical SENTRY_DSN GitHub variable."
Assert-Contains $flutterReleaseWorkflow 'mobile_version="$(sed -n ''s/^version: //p'' apps/mobile/pubspec.yaml | head -n 1)"' "Production Flutter workflow is missing the mobile pubspec version lookup."
Assert-Contains $flutterReleaseWorkflow 'expected_tag="v${mobile_version}"' "Production Flutter workflow is missing the pubspec-to-tag enforcement."
Assert-Contains $flutterReleaseWorkflow "validate_only:" "Production Flutter workflow is missing the validate_only rehearsal input."

$adminReleaseWorkflow = Get-FileText ".github/workflows/production_admin_web.yml"
Assert-Contains $adminReleaseWorkflow "environment: Production" "Production admin-web workflow is not bound to the Production environment."
Assert-Contains $adminReleaseWorkflow 'short-lived CLI session token (vca_*)' "Production admin-web workflow is missing the Vercel session-token guardrail."

$supabaseReleaseWorkflow = Get-FileText ".github/workflows/production_supabase.yml"
Assert-Contains $supabaseReleaseWorkflow "environment: Production" "Production Supabase workflow is not bound to the Production environment."
Assert-Contains $supabaseReleaseWorkflow 'short-lived CLI session token (vca_*)' "Production Supabase workflow is missing the Vercel session-token guardrail."

$ciWorkflow = Get-FileText ".github/workflows/ci.yml"
Assert-Contains $ciWorkflow "actions/checkout@v6" "CI workflow is not pinned to the current checkout major."
Assert-Contains $ciWorkflow "actions/setup-node@v6" "CI workflow is not pinned to the current setup-node major."
Assert-Contains $adminReleaseWorkflow "actions/checkout@v6" "Production admin-web workflow is not pinned to the current checkout major."
Assert-Contains $adminReleaseWorkflow "actions/setup-node@v6" "Production admin-web workflow is not pinned to the current setup-node major."
Assert-Contains $supabaseReleaseWorkflow "actions/checkout@v6" "Production Supabase workflow is not pinned to the current checkout major."
Assert-Contains $supabaseReleaseWorkflow "actions/setup-node@v6" "Production Supabase workflow is not pinned to the current setup-node major."
Assert-Contains $flutterReleaseWorkflow "actions/checkout@v6" "Production Flutter workflow is not pinned to the current checkout major."
Assert-Contains $flutterReleaseWorkflow "actions/setup-java@v5" "Production Flutter workflow is not pinned to the current setup-java major."
Assert-Contains $flutterReleaseWorkflow "softprops/action-gh-release@v3" "Production Flutter workflow is not pinned to the current GitHub release action major."

$mobileLocales = Get-ChildItem "apps/mobile/lib/l10n" -Filter "intl_*.arb" | ForEach-Object {
  [regex]::Match($_.BaseName, '^intl_([a-z]{2})$').Groups[1].Value
} | Where-Object { $_ } | Sort-Object -Unique
if ($mobileLocales.Count -eq 0) {
  throw "Could not resolve any mobile locale contracts from apps/mobile/lib/l10n."
}

$adminLocaleConfig = Get-FileText "apps/admin-web/lib/i18n/config.ts"
$adminLocales = ($adminLocaleConfig -split "\r?\n" | ForEach-Object {
  if ($_ -match '^\s+([a-z]{2}):\s+\{$') {
    $matches[1]
  }
}) | Sort-Object -Unique
if ($adminLocales.Count -eq 0) {
  throw "Could not resolve any admin-web locales from apps/admin-web/lib/i18n/config.ts."
}

$adminMessageLocales = Get-ChildItem "apps/admin-web/messages" -Filter "*.ts" | Select-Object -ExpandProperty BaseName | Sort-Object -Unique
if ((Compare-Object -ReferenceObject @($adminLocales) -DifferenceObject @($adminMessageLocales)).Count -ne 0) {
  throw "Admin-web locale registry and message files are out of sync."
}

if ((Compare-Object -ReferenceObject @($mobileLocales) -DifferenceObject @($adminLocales)).Count -ne 0) {
  throw "Mobile and admin-web locale contracts are out of sync."
}

$gitIgnore = Get-FileText ".gitignore"
Assert-Contains $gitIgnore "/apps/admin-web/.playwright/" ".gitignore is missing the admin-web Playwright artifact ignore."
Assert-Contains $gitIgnore "/apps/admin-web/test-results/" ".gitignore is missing the admin-web test-results ignore."

$functionDirs = Get-ChildItem "backend/supabase/functions" -Directory | Select-Object -ExpandProperty Name
$functionConfigMatches = [regex]::Matches($supabaseConfig, '(?m)^\[functions\.([^\]]+)\]')
foreach ($match in $functionConfigMatches) {
  $functionName = $match.Groups[1].Value
  if ($functionDirs -notcontains $functionName) {
    throw "Supabase config references function '$functionName' but no matching directory exists under backend/supabase/functions."
  }
}

$docsDelivery = Get-FileText "docs/delivery.md"
Assert-Contains $docsDelivery "prefer [C:\Users\raouf\projects\fleetfill\.github\workflows\release.yml]" "Delivery docs are missing the root release orchestrator guidance."
Assert-Contains $docsDelivery "Arabic, French, and English manual localization QA" "Delivery docs no longer document the supported locale QA contract."

$docsReleases = Get-FileText "docs/releases.md"
Assert-Contains $docsReleases "coordinated backend -> admin-web -> mobile release orchestration" "Release docs are missing the coordinated root orchestrator contract."
Assert-Contains $docsReleases "Production environment" "Release docs are missing the Production environment approval-gate contract."
Assert-Contains $docsReleases "Verified Android App Links" "Release docs are missing the Android App Links release posture."
Assert-Contains $docsReleases "validate_only" "Release docs are missing the no-deploy release rehearsal contract."
Assert-Contains $docsReleases '`SUPABASE_URL`' "Release docs are missing the canonical SUPABASE_URL GitHub variable."
Assert-Contains $docsReleases '`SUPABASE_PUBLISHABLE_KEY`' "Release docs are missing the canonical SUPABASE_PUBLISHABLE_KEY GitHub variable."
Assert-Contains $docsReleases '`SENTRY_DSN`' "Release docs are missing the canonical SENTRY_DSN GitHub variable."
Assert-Contains $docsReleases '`VERCEL_TOKEN`' "Release docs are missing the Vercel token contract."
Assert-Contains $docsReleases 'short-lived CLI session tokens (`vca_*`)' "Release docs are missing the Vercel session-token warning."

$appEnvironment = Get-FileText "apps/mobile/lib/core/config/app_environment.dart"
foreach ($legacyName in @(
  "APP_SUPABASE_URL",
  "APP_SUPABASE_PUBLISHABLE_KEY",
  "APP_SUPABASE_ANON_KEY",
  "APP_SENTRY_DSN",
  "APP_FIREBASE_API_KEY",
  "APP_FIREBASE_MESSAGING_SENDER_ID",
  "APP_FIREBASE_PROJECT_ID",
  "APP_FIREBASE_STORAGE_BUCKET",
  "APP_FIREBASE_ANDROID_APP_ID",
  "APP_FIREBASE_IOS_APP_ID",
  "APP_GOOGLE_WEB_CLIENT_ID",
  "APP_GOOGLE_IOS_CLIENT_ID"
)) {
  if ($appEnvironment.Contains($legacyName)) {
    throw "Mobile app environment still references legacy alias '$legacyName'."
  }
}

if ($appEnvironment.Contains("ingest.de.sentry.io")) {
  throw "Mobile app environment still contains a hardcoded Sentry DSN."
}

Write-Host "System contract validation passed."
