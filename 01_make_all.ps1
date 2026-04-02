$ErrorActionPreference = "Stop"
$ProjectPath = (Get-Location).Path
$PidFile     = Join-Path $ProjectPath ".br_dart.pid"

function Stop-BuildRunnerIfAny {
  if (Test-Path $PidFile) {
    $pidText = (Get-Content $PidFile -ErrorAction SilentlyContinue | Select-Object -First 1).Trim()
    if ($pidText -match '^\d+$') {
      $brPid = [int]$pidText
      $p = Get-Process -Id $brPid -ErrorAction SilentlyContinue
      if ($p) {
        Write-Host "Stopping build_runner (dart) PID=$brPid" -ForegroundColor Yellow
        Stop-Process -Id $brPid -Force
      }
    }
    Remove-Item $PidFile -Force -ErrorAction SilentlyContinue
  }
}

function Step($name, [scriptblock]$cmd) {
  Write-Host "`n== $name ==" -ForegroundColor Cyan
  & $cmd
  if ($LASTEXITCODE -ne $null -and $LASTEXITCODE -ne 0) { throw "$name failed (exit=$LASTEXITCODE)" }
}

# sanity checks
if (-not (Test-Path (Join-Path $ProjectPath "pubspec.yaml"))) { throw "pubspec.yaml not found." }
if (-not (Test-Path (Join-Path $ProjectPath "lib\main.dart"))) { throw "lib\main.dart not found. Wrong folder?" }

Step "flutter pub get" { flutter pub get }
Step "build_runner build --delete-conflicting-outputs" { dart run build_runner build --delete-conflicting-outputs }
Step "flutter test" { flutter test }

Write-Host "
ALL DONE" -ForegroundColor Green
