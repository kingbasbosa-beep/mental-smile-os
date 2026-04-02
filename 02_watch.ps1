param([switch]$Restart)

$ErrorActionPreference = 'Stop'
$ProjectPath = (Get-Location).Path
$PidFile = Join-Path $ProjectPath '.br_dart.pid'

if ($Restart -and (Test-Path $PidFile)) {
  powershell -ExecutionPolicy Bypass -File .\06_kill_watch.ps1 | Out-Host
}

if (Test-Path $PidFile) {
  $pidText = (Get-Content $PidFile -ErrorAction SilentlyContinue | Select-Object -First 1).Trim()
  if ($pidText -match '^\d+$') {
    $oldPid = [int]$pidText
    $p = Get-Process -Id $oldPid -ErrorAction SilentlyContinue
    if ($p) { Stop-Process -Id $oldPid -Force }
  }
  Remove-Item $PidFile -Force -ErrorAction SilentlyContinue
}

Write-Host "Starting build_runner watch..." -ForegroundColor Yellow
$p = Start-Process -FilePath 'dart' -ArgumentList @('run','build_runner','watch','--delete-conflicting-outputs') -PassThru
"$($p.Id)" | Set-Content -Path $PidFile -Encoding ASCII
Write-Host "watch PID = $($p.Id) saved to $PidFile" -ForegroundColor Green
Write-Host "Leave this window open. Close it to stop watch." -ForegroundColor Cyan
Wait-Process -Id $p.Id
if (Test-Path $PidFile) { Remove-Item $PidFile -Force -ErrorAction SilentlyContinue }
