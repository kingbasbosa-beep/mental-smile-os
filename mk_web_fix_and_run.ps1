param(
  [Parameter(Mandatory=$true)]
  [string]$ClinicianId,

  [Parameter(Mandatory=$true)]
  [string]$ClinicianEmail,

  [Parameter(Mandatory=$true)]
  [string]$ClinicianPass,

  [switch]$ResetProfiles,
  [switch]$SeedClinician,
  [switch]$UseSkiaWeb,

  [int]$ClientPort,
  [int]$ClinicianPort
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

if (-not $PSBoundParameters.ContainsKey('ClientPort') -or $ClientPort -eq 0) { $ClientPort = 50505 }
if (-not $PSBoundParameters.ContainsKey('ClinicianPort') -or $ClinicianPort -eq 0) { $ClinicianPort = 50506 }

$ROOT = "C:\flutterprojects\mental_key_v2"
Set-Location $ROOT

Write-Host "== Mental Key v2 :: Web (Client + Clinician) ==" -ForegroundColor Cyan
Write-Host ("Client    http://localhost:{0}" -f $ClientPort)
Write-Host ("Clinician http://localhost:{0}" -f $ClinicianPort)
Write-Host ("ClinicianId={0}" -f $ClinicianId)
Write-Host ("ClinicianEmail={0}" -f $ClinicianEmail)
if ($SeedClinician) { Write-Host "✅ SeedClinician: ON (one-time)" -ForegroundColor Green }

$env:MK_DEV_CLINICIAN_ID  = $ClinicianId
$env:MK_DEV_CLINICIAN_UID = $ClinicianId
$env:MK_CLINICIAN_EMAIL   = $ClinicianEmail
$env:MK_CLINICIAN_PASS    = $ClinicianPass
Write-Host "✅ Dev clinician env locked" -ForegroundColor Green

$profiles = Join-Path $ROOT ".mk_chrome_profiles"
$clientProfile    = Join-Path $profiles "client"
$clinicianProfile = Join-Path $profiles "clinician"

if ($ResetProfiles) {
  Write-Host "== Reset chrome profiles ==" -ForegroundColor Cyan
  if (Test-Path $profiles) { Remove-Item $profiles -Recurse -Force }
}

New-Item -ItemType Directory -Force -Path $clientProfile    | Out-Null
New-Item -ItemType Directory -Force -Path $clinicianProfile | Out-Null

Write-Host "== Kill dart/flutter_tester ==" -ForegroundColor Cyan
Get-Process dart,flutter_tester -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue

Write-Host "== flutter clean ==" -ForegroundColor Cyan
flutter clean
if ($LASTEXITCODE -ne 0) { throw "flutter clean failed" }

Write-Host "== flutter pub get ==" -ForegroundColor Cyan
flutter pub get
if ($LASTEXITCODE -ne 0) { throw "flutter pub get failed" }

$commonDefines = @(
  "--dart-define=MK_ENV=dev",
  "--dart-define=MK_DEV_CLINICIAN_ID=$ClinicianId",
  "--dart-define=MK_DEV_CLINICIAN_UID=$ClinicianId",
  "--dart-define=MK_CLINICIAN_EMAIL=$ClinicianEmail",
  "--dart-define=MK_CLINICIAN_PASS=$ClinicianPass"
)

if ($UseSkiaWeb) {
  $commonDefines += "--dart-define=FLUTTER_WEB_USE_SKIA=true"
}

$clientArgs = @(
  "run","-d","chrome",
  "--web-port=$ClientPort",
  "--web-browser-flag=--user-data-dir=$clientProfile",
  "--web-browser-flag=--no-first-run",
  "--web-browser-flag=--no-default-browser-check",
  "--dart-define=MK_ROLE=client"
) + $commonDefines

$clinArgs = @(
  "run","-d","chrome",
  "--web-port=$ClinicianPort",
  "--web-browser-flag=--user-data-dir=$clinicianProfile",
  "--web-browser-flag=--no-first-run",
  "--web-browser-flag=--no-default-browser-check",
  "--dart-define=MK_ROLE=clinician"
) + $commonDefines

if ($SeedClinician) {
  $clinArgs += "--dart-define=MK_SEED_CLINICIAN=true"
  Write-Host "✅ MK_SEED_CLINICIAN=true passed to clinician window" -ForegroundColor Green
}

Write-Host "== Launch Client ==" -ForegroundColor Cyan
Start-Process -FilePath "flutter" -ArgumentList $clientArgs | Out-Null
Start-Sleep -Milliseconds 800
Write-Host "== Launch Clinician ==" -ForegroundColor Cyan
Start-Process -FilePath "flutter" -ArgumentList $clinArgs | Out-Null
Write-Host "✅ Done. Two web windows launched." -ForegroundColor Green
