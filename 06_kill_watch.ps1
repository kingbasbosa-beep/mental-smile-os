$ErrorActionPreference = 'SilentlyContinue'
$Here = Split-Path -Parent $(\System.Management.Automation.InvocationInfo.MyCommand.Path)
$PidFile = Join-Path $Here '.br_dart.pid'

if (Test-Path $PidFile) {
  $pidText = (Get-Content $PidFile -ErrorAction SilentlyContinue | Select-Object -First 1).Trim()
  if ($pidText -match '^\d+$') {
    $brPid = [int]$pidText
    $p = Get-Process -Id $brPid -ErrorAction SilentlyContinue
    if ($p) {
      Write-Host "Stopping build_runner watch PID=$brPid" -ForegroundColor Yellow
      Stop-Process -Id $brPid -Force
    }
  }
  Remove-Item $PidFile -Force -ErrorAction SilentlyContinue
}
Write-Host "Done. (If it was running, it's stopped.)" -ForegroundColor Green
