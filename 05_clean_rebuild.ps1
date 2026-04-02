$ErrorActionPreference = 'Stop'
Write-Host "== STOP watch first if running ==" -ForegroundColor Yellow
if (Test-Path ".\.br_dart.pid") { powershell -ExecutionPolicy Bypass -File .\06_kill_watch.ps1 }

Write-Host "== flutter clean ==" -ForegroundColor Yellow
flutter clean

Write-Host "== flutter pub get ==" -ForegroundColor Yellow
flutter pub get

Write-Host "== build_runner build (clean) ==" -ForegroundColor Yellow
dart run build_runner build --delete-conflicting-outputs

Write-Host "DONE ✅" -ForegroundColor Green
