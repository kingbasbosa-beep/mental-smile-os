# === create missing helper scripts (02..06) ===
$ErrorActionPreference = "Stop"
$ProjectPath = (Get-Location).Path
$PidFile     = Join-Path $ProjectPath ".br_dart.pid"

function Write-PSFile([string]$Path, [string]$Content) {
  $Content | Set-Content -Path $Path -Encoding UTF8
  Write-Host "Wrote $Path" -ForegroundColor Green
}

# 06_kill_watch.ps1
$kill = @"
`$ErrorActionPreference = 'SilentlyContinue'
`$ProjectPath = (Get-Location).Path
`$PidFile = Join-Path `$ProjectPath '.br_dart.pid'
if (Test-Path `$PidFile) {
  `$pidText = (Get-Content `$PidFile | Select-Object -First 1).Trim()
  if (`$pidText -match '^\d+$') {
    `$brPid = [int]`$pidText
    `$p = Get-Process -Id `$brPid -ErrorAction SilentlyContinue
    if (`$p) {
      Write-Host "Stopping build_runner watch PID=`$brPid" -ForegroundColor Yellow
      Stop-Process -Id `$brPid -Force
    }
  }
  Remove-Item `$PidFile -Force -ErrorAction SilentlyContinue
}
Write-Host "Done. (If it was running, it's stopped.)" -ForegroundColor Green
"@
Write-PSFile ".\06_kill_watch.ps1" $kill

# 02_watch.ps1
$watch = @"
`$ErrorActionPreference = 'Stop'
`$ProjectPath = (Get-Location).Path
`$PidFile = Join-Path `$ProjectPath '.br_dart.pid'

# stop old if exists
if (Test-Path `$PidFile) {
  `$pidText = (Get-Content `$PidFile -ErrorAction SilentlyContinue | Select-Object -First 1).Trim()
  if (`$pidText -match '^\d+$') {
    `$old = [int]`$pidText
    `$p = Get-Process -Id `$old -ErrorAction SilentlyContinue
    if (`$p) { Stop-Process -Id `$old -Force }
  }
  Remove-Item `$PidFile -Force -ErrorAction SilentlyContinue
}

Write-Host "Starting build_runner watch..." -ForegroundColor Yellow
`$p = Start-Process -FilePath 'dart' -ArgumentList @('run','build_runner','watch','--delete-conflicting-outputs') -PassThru
"`$(`$p.Id)" | Set-Content -Path `$PidFile -Encoding ASCII
Write-Host "watch PID = `$(`$p.Id) saved to `$PidFile" -ForegroundColor Green
Write-Host "Leave this window open. Close it to stop watch." -ForegroundColor Cyan
Wait-Process -Id `$p.Id
if (Test-Path `$PidFile) { Remove-Item `$PidFile -Force -ErrorAction SilentlyContinue }
"@
Write-PSFile ".\02_watch.ps1" $watch

# 03_run.ps1
$run = @"
`$ErrorActionPreference = 'Stop'
Write-Host "== flutter run ==" -ForegroundColor Green
flutter run
"@
Write-PSFile ".\03_run.ps1" $run

# 04_bootstrap_run.ps1
$boot = @"
`$ErrorActionPreference = 'Stop'

function Step([string]`$name, [scriptblock]`$cmd) {
  Write-Host "`n== `$name ==" -ForegroundColor Cyan
  & `$cmd
  if (`$LASTEXITCODE -ne `$null -and `$LASTEXITCODE -ne 0) { throw "`$name failed (exit=`$LASTEXITCODE)" }
}

# sanity
if (-not (Test-Path ".\pubspec.yaml")) { throw "pubspec.yaml not found. Run from project root." }

Step "flutter pub get" { flutter pub get }
Step "build_runner build --delete-conflicting-outputs" { dart run build_runner build --delete-conflicting-outputs }

Write-Host "`n== start watch (new window) ==" -ForegroundColor Yellow
Start-Process powershell -ArgumentList @("-NoExit","-ExecutionPolicy","Bypass","-File",".\02_watch.ps1")

Step "flutter run" { flutter run }
"@
Write-PSFile ".\04_bootstrap_run.ps1" $boot

# 05_clean_rebuild.ps1 (rare)
$clean = @"
`$ErrorActionPreference = 'Stop'
Write-Host "== STOP watch first if running ==" -ForegroundColor Yellow
if (Test-Path ".\.br_dart.pid") { powershell -ExecutionPolicy Bypass -File .\06_kill_watch.ps1 }

Write-Host "== flutter clean ==" -ForegroundColor Yellow
flutter clean

Write-Host "== flutter pub get ==" -ForegroundColor Yellow
flutter pub get

Write-Host "== build_runner build (clean) ==" -ForegroundColor Yellow
dart run build_runner build --delete-conflicting-outputs

Write-Host "DONE ✅" -ForegroundColor Green
"@
Write-PSFile ".\05_clean_rebuild.ps1" $clean

Write-Host "`n=== READY ===" -ForegroundColor Green
Write-Host "First time (recommended):  powershell -ExecutionPolicy Bypass -File .\04_bootstrap_run.ps1" -ForegroundColor Yellow
Write-Host "Or just codegen+tests:       powershell -ExecutionPolicy Bypass -File .\01_make_all.ps1" -ForegroundColor Yellow
Write-Host "Run app only:                powershell -ExecutionPolicy Bypass -File .\03_run.ps1" -ForegroundColor Yellow
Write-Host "Start watch only:            powershell -ExecutionPolicy Bypass -File .\02_watch.ps1" -ForegroundColor Yellow
Write-Host "Stop watch:                  powershell -ExecutionPolicy Bypass -File .\06_kill_watch.ps1" -ForegroundColor Yellow
Write-Host "Clean rebuild (rare):         powershell -ExecutionPolicy Bypass -File .\05_clean_rebuild.ps1" -ForegroundColor Yellow
