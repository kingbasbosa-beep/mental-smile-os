# mk_checkpoint.ps1 (v3)
# One-button savepoint: analyze + handoff + inject schema + inject ops docs + zip

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$ROOT = "C:\flutterprojects\mental_key_v2"
Set-Location $ROOT

function Update-MdBlock {
  param(
    [Parameter(Mandatory=$true)][string]$Path,
    [Parameter(Mandatory=$true)][string]$StartMarker,
    [Parameter(Mandatory=$true)][string]$EndMarker,
    [Parameter(Mandatory=$true)][string]$BlockContent
  )

  $content = Get-Content $Path -Raw

  if (($content -match [regex]::Escape($StartMarker)) -and ($content -match [regex]::Escape($EndMarker))) {
    $pattern = [regex]::Escape($StartMarker) + ".*?" + [regex]::Escape($EndMarker)
    $replacement = $StartMarker + "`r`n`r`n" + $BlockContent + "`r`n`r`n" + $EndMarker
    $content = [regex]::Replace($content, $pattern, $replacement, [System.Text.RegularExpressions.RegexOptions]::Singleline)
  } else {
    $content = $content.TrimEnd() + "`r`n`r`n" + $StartMarker + "`r`n`r`n" + $BlockContent + "`r`n`r`n" + $EndMarker + "`r`n"
  }

  Set-Content -Path $Path -Value $content -Encoding UTF8
}

Write-Host "== CHECKPOINT ==" -ForegroundColor Cyan
Write-Host ("Time: " + (Get-Date))
Write-Host ("Root: " + (Get-Location).Path)
Write-Host ""

Write-Host "== flutter analyze ==" -ForegroundColor Cyan
flutter analyze
if ($LASTEXITCODE -ne 0) { throw "FAILED: flutter analyze (exit=$LASTEXITCODE)" }

if (!(Test-Path ".\mk_handoff_latest.ps1")) { throw "mk_handoff_latest.ps1 not found." }

Write-Host "== mk_handoff_latest.ps1 ==" -ForegroundColor Cyan
.\mk_handoff_latest.ps1

$handoffMd = ".\_handoff_latest\HANDOFF.md"
if (!(Test-Path $handoffMd)) { throw "Missing: $handoffMd" }

# ---- Schema block ----
$schemaBlock = @"
## Firestore schema (dev)

### booking_requests (collection)

Purpose: client submits a booking request; clinician reviews in inbox and approves/ignores.

Required fields
- clientId (string) — UID of client (must equal auth.uid on create)
- clinicianId (string) — UID of clinician assigned to handle the request
- status (string) — pending | approved | rejected
- createdAt (timestamp) — server/client timestamp (Now)

Optional client fields
- note (string) — free text note (client may edit only while status == pending)

Clinician handling fields (written on update by clinician)
- approvedSlot (string) — optional note/slot when approving
- rejectReason (string) — optional reason when rejecting/ignoring
- handledByClinicianId (string) — clinician UID (should match clinicianId)
- handledByClinicianName (string) — display name (dev may be "DEV Clinician")
- updatedAt (string) — ISO8601 timestamp string

Lifecycle
1) Client creates doc with status=pending
2) Clinician inbox filters clinicianId == auth.uid and status == pending
3) Clinician sets status=approved|rejected and writes handling fields

Indexes
- Composite index required for inbox query:
  clinicianId ASC, status ASC, createdAt DESC

### debug/{uid} (doc)

- read/write allowed only for the same authenticated uid
- used for lightweight diagnostics in dev
"@

Update-MdBlock -Path $handoffMd -StartMarker "<!-- SCHEMA:START -->" -EndMarker "<!-- SCHEMA:END -->" -BlockContent $schemaBlock
Write-Host "✅ Updated HANDOFF.md with schema block" -ForegroundColor Green

# ---- Ops docs block ----
$opsBlock = @"
## Operations quickstart (dev)

### Run (dual windows)
- Start client + clinician (kill + clean + pub get + run):
  .\mk_run_dual_web.ps1
- Start and immediately generate fresh handoff zip:
  .\mk_run_dual_web.ps1 -Checkpoint

Flags
- -NoKill   skip killing chrome/dart (not recommended if UID/session collides)
- -NoClean  skip flutter clean
- -NoPubGet skip flutter pub get
- -NoRun    prepare only (no launch)

### Savepoint / Handoff
- Generate _handoff_latest + update HANDOFF blocks + zip:
  .\mk_checkpoint.ps1

### Firestore rules (tight v1.1)
- booking_requests:
  - create: allowed only if clientId == auth.uid
  - read: allowed for client owner OR assigned clinician
  - update:
    - clinician can update status + handling fields (approved/rejected + metadata)
    - client can update only note while status is pending
  - delete: disabled
- debug/{uid}: read/write only for same uid
- resources: read-only
- default deny for all other paths
"@

Update-MdBlock -Path $handoffMd -StartMarker "<!-- OPS:START -->" -EndMarker "<!-- OPS:END -->" -BlockContent $opsBlock
Write-Host "✅ Updated HANDOFF.md with ops quickstart" -ForegroundColor Green

Write-Host "== Compress-Archive _handoff_latest.zip ==" -ForegroundColor Cyan
Compress-Archive -Path .\_handoff_latest\* -DestinationPath .\_handoff_latest.zip -Force

Write-Host "✅ CHECKPOINT DONE: _handoff_latest.zip refreshed" -ForegroundColor Green
