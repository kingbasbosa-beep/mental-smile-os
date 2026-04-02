$ErrorActionPreference = 'Stop'

function Step([string]$name, [scriptblock]$cmd) {
  Write-Host "
== $name ==" -ForegroundColor Cyan
  & $cmd
  if ($LASTEXITCODE -ne $null -and $LASTEXITCODE -ne 0) { throw "$name failed (exit=$LASTEXITCODE)" }
}

if (-not (Test-Path ".\pubspec.yaml")) { throw "pubspec.yaml not found. Run from project root." }

Step "flutter pub get" { flutter pub get }
Step "build_runner build --delete-conflicting-outputs" { dart run build_runner build --delete-conflicting-outputs }

Write-Host "
== start watch (new window) ==" -ForegroundColor Yellow
Start-Process powershell -ArgumentList @("-NoExit","-ExecutionPolicy","Bypass","-File",".\02_watch.ps1")

Step "ADB reset" { adb kill-server; adb start-server; adb devices }
Step "flutter run" { flutter run }
