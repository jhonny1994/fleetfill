[CmdletBinding()]
param(
  [Parameter(Position = 0)]
  [ValidateSet("validate", "install", "help")]
  [string]$Action = "help",

  [Parameter(Position = 1)]
  [ValidateSet("all", "mobile", "admin-web", "supabase")]
  [string]$Surface = "all"
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

function Show-Help {
  Write-Host "FleetFill workspace helper"
  Write-Host ""
  Write-Host "Usage:"
  Write-Host "  powershell -NoProfile -ExecutionPolicy Bypass -File tool/workspace.ps1 validate all"
  Write-Host "  powershell -NoProfile -ExecutionPolicy Bypass -File tool/workspace.ps1 validate mobile"
  Write-Host "  powershell -NoProfile -ExecutionPolicy Bypass -File tool/workspace.ps1 validate admin-web"
  Write-Host "  powershell -NoProfile -ExecutionPolicy Bypass -File tool/workspace.ps1 validate supabase"
  Write-Host "  powershell -NoProfile -ExecutionPolicy Bypass -File tool/workspace.ps1 install all"
}

function Run-MobileValidate {
  Invoke-Checked -Description "Flutter dependencies" -Script { Push-Location apps/mobile; try { flutter pub get } finally { Pop-Location } }
  Invoke-Checked -Description "Flutter localization generation" -Script { Push-Location apps/mobile; try { dart run intl_utils:generate } finally { Pop-Location } }
  Invoke-Checked -Description "Flutter analyze" -Script { Push-Location apps/mobile; try { flutter analyze } finally { Pop-Location } }
  Invoke-Checked -Description "Flutter tests" -Script { Push-Location apps/mobile; try { flutter test } finally { Pop-Location } }
}

function Run-AdminValidate {
  Invoke-Checked -Description "Admin install" -Script { pnpm --dir apps/admin-web install --frozen-lockfile }
  Invoke-Checked -Description "Admin lint" -Script { pnpm --dir apps/admin-web lint }
  Invoke-Checked -Description "Admin typecheck" -Script { pnpm --dir apps/admin-web typecheck }
  Invoke-Checked -Description "Admin tests" -Script { pnpm --dir apps/admin-web test }
  Invoke-Checked -Description "Admin build" -Script { pnpm --dir apps/admin-web build }
}

function Run-SupabaseValidate {
  Invoke-Checked -Description "Supabase start" -Script { supabase start --workdir backend }
  Invoke-Checked -Description "Supabase db reset" -Script { supabase db reset --workdir backend --yes }
  Invoke-Checked -Description "Supabase db lint" -Script { supabase db lint --workdir backend }
  Invoke-Checked -Description "Supabase db tests" -Script { supabase test db --workdir backend }
}

function Run-MobileInstall {
  Invoke-Checked -Description "Flutter dependencies" -Script { Push-Location apps/mobile; try { flutter pub get } finally { Pop-Location } }
}

function Run-AdminInstall {
  Invoke-Checked -Description "Admin install" -Script { pnpm --dir apps/admin-web install --frozen-lockfile }
}

switch ($Action) {
  "help" {
    Show-Help
  }
  "install" {
    switch ($Surface) {
      "all" {
        Run-MobileInstall
        Run-AdminInstall
      }
      "mobile" {
        Run-MobileInstall
      }
      "admin-web" {
        Run-AdminInstall
      }
      "supabase" {
        Write-Host "Supabase has no separate install step."
      }
    }
  }
  "validate" {
    try {
      switch ($Surface) {
        "all" {
          Run-MobileValidate
          Run-AdminValidate
          Run-SupabaseValidate
        }
        "mobile" {
          Run-MobileValidate
        }
        "admin-web" {
          Run-AdminValidate
        }
        "supabase" {
          Run-SupabaseValidate
        }
      }
    } finally {
      if ($Surface -eq "all" -or $Surface -eq "supabase") {
        try {
          & supabase stop --workdir backend | Out-Null
        } catch {
        }
      }
    }
  }
}
