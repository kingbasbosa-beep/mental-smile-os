param(
  [string]$ProjectPath = "C:\flutterprojects\mental_key_v2",
  [string]$ArchiveRoot = "D:\MentalSmile_Archives"
)

$ErrorActionPreference = "Stop"

if (!(Test-Path $ProjectPath)) {
  Write-Host "Project path not found: $ProjectPath" -ForegroundColor Red
  exit 1
}

$Stamp = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"

$BackupRoot    = Join-Path $ArchiveRoot "backups"
$SavepointRoot = Join-Path $ArchiveRoot "savepoints"
$ManifestRoot  = Join-Path $ArchiveRoot "checks"

$ZipPath       = Join-Path $BackupRoot "mental_key_v2_backup_$Stamp.zip"
$SavepointDir  = Join-Path $SavepointRoot "savepoint_$Stamp"
$ManifestPath  = Join-Path $ManifestRoot "backup_manifest_$Stamp.txt"

$NeededDirs = @(
  $ArchiveRoot,
  $BackupRoot,
  $SavepointRoot,
  $ManifestRoot
)

foreach ($dir in $NeededDirs) {
  if (!(Test-Path $dir)) {
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
  }
}

Write-Host "Creating lightweight savepoint..." -ForegroundColor Cyan
New-Item -ItemType Directory -Path $SavepointDir -Force | Out-Null

$ImportantPaths = @(
  "lib",
  "assets",
  "pubspec.yaml",
  "pubspec.lock",
  "analysis_options.yaml",
  "firebase.json",
  "firestore.rules",
  "storage.rules",
  "l10n.yaml",
  "web",
  "android\app\google-services.json",
  "ios\Runner\GoogleService-Info.plist"
)

foreach ($item in $ImportantPaths) {
  $source = Join-Path $ProjectPath $item
  if (Test-Path $source) {
    Copy-Item -Path $source -Destination $SavepointDir -Recurse -Force
  }
}

Write-Host "Creating full zip backup..." -ForegroundColor Cyan

$ExcludeNames = @(
  ".dart_tool",
  "build",
  ".git",
  ".idea",
  ".vscode",
  "_backup",
  "_handoff_latest",
  "_savepoints",
  "_savepoints_off"
)

$tempBackupSource = Join-Path $env:TEMP "mental_key_v2_backup_source_$Stamp"
New-Item -ItemType Directory -Path $tempBackupSource -Force | Out-Null

Get-ChildItem -Path $ProjectPath -Force | Where-Object {
  $ExcludeNames -notcontains $_.Name
} | ForEach-Object {
  Copy-Item -Path $_.FullName -Destination $tempBackupSource -Recurse -Force
}

Compress-Archive -Path (Join-Path $tempBackupSource "*") -DestinationPath $ZipPath -Force

Write-Host "Writing manifest..." -ForegroundColor Cyan

$AnalyzeStatus = "not_run"
$RunStatus = "not_run"

@"
Mental Smile / Mental Key V2 - Backup Manifest

Timestamp:
$Stamp

Project Path:
$ProjectPath

Archive Root:
$ArchiveRoot

Created Files:
- Full Zip Backup: $ZipPath
- Savepoint Folder: $SavepointDir
- Manifest: $ManifestPath

Included in Savepoint:
- lib
- assets
- pubspec.yaml
- pubspec.lock
- analysis_options.yaml
- firebase.json
- firestore.rules
- storage.rules
- l10n.yaml
- web
- android\app\google-services.json (if exists)
- ios\Runner\GoogleService-Info.plist (if exists)

Excluded from Zip Backup:
- .dart_tool
- build
- .git
- .idea
- .vscode
- _backup
- _handoff_latest
- _savepoints
- _savepoints_off

Project Status Snapshot:
- flutter analyze: $AnalyzeStatus
- flutter run: $RunStatus

Notes:
- This backup is designed to be lightweight but operationally useful.
- Savepoint contains the essential app source and config.
- Zip backup excludes heavy/generated/history folders to keep size down.
"@ | Set-Content -Path $ManifestPath -Encoding UTF8

if (Test-Path $tempBackupSource) {
  Remove-Item -Path $tempBackupSource -Recurse -Force
}

Write-Host ""
Write-Host "Backup completed successfully." -ForegroundColor Green
Write-Host "ZIP:       $ZipPath" -ForegroundColor Yellow
Write-Host "Savepoint: $SavepointDir" -ForegroundColor Yellow
Write-Host "Manifest:  $ManifestPath" -ForegroundColor Yellow
