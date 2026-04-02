$ErrorActionPreference = 'Stop'

Write-Host "== ADB reset ==" -ForegroundColor Yellow
adb kill-server | Out-Host
adb start-server | Out-Host
adb devices | Out-Host

Write-Host "== flutter run ==" -ForegroundColor Green
flutter run
