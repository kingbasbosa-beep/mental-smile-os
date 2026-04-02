Set-StrictMode -Version Latest
$ErrorActionPreference="Stop"

$root = (Get-Location).Path
$outDir = Join-Path $root "_handoff_latest"
$stamp = Get-Date -Format "yyyyMMdd_HHmmss"

# Recreate folder
if (Test-Path $outDir) { Remove-Item $outDir -Recurse -Force }
New-Item -ItemType Directory -Path $outDir | Out-Null

# --- What we copy (adjust freely) ---
$paths = @(
  "lib",
  "pubspec.yaml",
  "pubspec.lock",
  "analysis_options.yaml",
  "firebase.json",
  ".firebaserc",
  "firestore.rules",
  "firestore.indexes.json"
) | ForEach-Object { Join-Path $root $_ } | Where-Object { Test-Path $_ }

if (-not $paths -or $paths.Count -eq 0) { throw "Nothing to handoff (no known files found)." }

Write-Host "== Copying ==" -ForegroundColor Cyan
foreach ($p in $paths) {
  $rel = $p.Substring($root.Length).TrimStart("\")
  $dest = Join-Path $outDir $rel
  $destDir = Split-Path $dest -Parent
  if (-not (Test-Path $destDir)) { New-Item -ItemType Directory -Path $destDir | Out-Null }
  if ((Get-Item $p).PSIsContainer) {
    Copy-Item $p $dest -Recurse -Force
  } else {
    Copy-Item $p $dest -Force
  }
  Write-Host " + $rel" -ForegroundColor DarkGray
}

# --- HANDOFF summary ---
$handoff = Join-Path $outDir "HANDOFF.md"
@"
# Mental Key v2 — Handoff (latest)
Generated: $stamp

## What we achieved in this chat
- Fixed analyzer noise by excluding/renaming backup folders so they don't break analysis.
- Restored correct imports (package:) and removed local relative router imports.
- Implemented dual-window dev flow using `MK_ROLE`:
  - Client window: normal flow
  - Clinician window: opens clinician inbox route
- Ensured Anonymous Auth happens before app role routing so each window gets its own UID.
- Updated Firestore rules to allow clinician inbox read/update for docs where:
  - clinicianId == request.auth.uid OR clientId == request.auth.uid
- Verified two different anonymous UIDs:
  - Clinician UID: CLPeJhKwEMV37eihAUD0WbvFFBX2
  - Client UID:    6KG4SnI0F4MimHweiF8LZbVLJ643
- Confirmed inbox shows request and approve flow works.

## How to run (two windows)
Client:
flutter run -d chrome --web-port=50505 --dart-define=MK_ROLE=client --dart-define=MK_ENV=dev

Clinician:
flutter run -d chrome --web-port=50506 --dart-define=MK_ROLE=clinician --dart-define=MK_ENV=dev

## Firestore rules deploy
firebase use dev
firebase deploy --only firestore:rules

## Notes / next tasks
- Cleanup: remove temporary DEV-only routing/inbox shortcuts when moving to real clinician auth/claims.
- Consider creating seed script for booking_requests test data instead of manual console add.
"@ | Set-Content $handoff -Encoding UTF8

# --- Manifest (safe: exclude MANIFEST + HANDOFF to avoid locking/hash self-reference) ---
$manifest = Join-Path $outDir "MANIFEST.txt"
$manifestTmp = Join-Path $outDir "MANIFEST.tmp.txt"

"Generated: $stamp" | Set-Content $manifestTmp -Encoding UTF8

Get-ChildItem $outDir -Recurse -File |
  Where-Object { $_.Name -notin @("MANIFEST.txt","MANIFEST.tmp.txt","HANDOFF.md") } |
  ForEach-Object {
    $rel = $_.FullName.Substring($outDir.Length).TrimStart("\")
    $h = (Get-FileHash $_.FullName -Algorithm SHA256).Hash
    "$h  $rel"
  } | Add-Content $manifestTmp -Encoding UTF8

Move-Item -Force $manifestTmp $manifest

Write-Host "`n✅ DONE: $outDir" -ForegroundColor Green
Write-Host " - HANDOFF.md + MANIFEST.txt created" -ForegroundColor Green
