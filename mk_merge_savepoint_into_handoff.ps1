# mk_merge_savepoint_into_handoff.ps1
# (Paste FULL script content here, then save)
# mk_merge_savepoint_into_handoff.ps1
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$root = "C:\flutterprojects\mental_key_v2"
Set-Location $root

$savepoint = Join-Path $root "C0_SAVEPOINT_SYSTEM_OVERVIEW.md"
$handoff = Join-Path $root "_handoff_latest\HANDOFF.md"

if (!(Test-Path $savepoint)) { throw "Missing savepoint file: $savepoint (run mk_write_savepoint_md.ps1 first)" }
if (!(Test-Path $handoff)) { throw "Missing HANDOFF.md at: $handoff (run mk_checkpoint.ps1 once first)" }

$stamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
$markerStart = "<!-- SAVEPOINT_START -->"
$markerEnd   = "<!-- SAVEPOINT_END -->"

$sp = Get-Content $savepoint -Raw
$block = @"
$markerStart
## Savepoint (C5 + C6) — $stamp

$sp

$markerEnd
"@

$h = Get-Content $handoff -Raw

# إذا موجود بلوك قديم، نستبدله. لو مش موجود، نضيفه في آخر الملف.
if ($h -match [regex]::Escape($markerStart)) {
  $h2 = [regex]::Replace(
    $h,
    "(?s)" + [regex]::Escape($markerStart) + ".*?" + [regex]::Escape($markerEnd),
    $block
  )
} else {
  $h2 = $h + "`r`n`r`n" + $block
}

Copy-Item $handoff "$handoff.bak_savepoint_$((Get-Date).ToString('yyyyMMdd_HHmmss'))" -Force
Set-Content -Path $handoff -Value $h2 -Encoding UTF8

Write-Host "✅ Updated HANDOFF.md with Savepoint block" -ForegroundColor Green

if (Test-Path ".\mk_checkpoint.ps1") {
  Write-Host "== mk_checkpoint.ps1 ==" -ForegroundColor Cyan
  .\mk_checkpoint.ps1
} else {
  Write-Host "⚠️ mk_checkpoint.ps1 not found. Skipping checkpoint." -ForegroundColor Yellow
}