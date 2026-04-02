# mk_index_root_and_archive.ps1
# (Paste FULL script content here, then save)
# mk_index_root_and_archive.ps1
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$ROOT = "C:\flutterprojects\mental_key_v2"
$ARCH = Join-Path $ROOT "_archive\root_20260311_101123"

if (!(Test-Path $ROOT)) { throw "Missing root: $ROOT" }
if (!(Test-Path $ARCH)) { throw "Missing archive folder: $ARCH" }

Set-Location $ROOT

Write-Host "== Index Root vs Archive ==" -ForegroundColor Cyan
Write-Host "Root:   $ROOT" -ForegroundColor DarkGray
Write-Host "Archive:$ARCH" -ForegroundColor DarkGray
Write-Host ""

# --- Root ps1 (only root level)
$rootPs1 = Get-ChildItem -Path $ROOT -File -Filter "*.ps1" |
  Sort-Object LastWriteTime -Descending |
  Select-Object Name, FullName, Length, LastWriteTime

# --- Archive ps1 (recursive)
$archPs1 = Get-ChildItem -Path $ARCH -Recurse -File -Filter "*.ps1" -ErrorAction SilentlyContinue |
  Sort-Object LastWriteTime -Descending |
  Select-Object Name, FullName, Length, LastWriteTime

# --- Write Markdown helper
function Write-MdIndex([string]$path, [string]$title, $items) {
  $lines = @()
  $lines += "# $title"
  $lines += ""
  $lines += ("Generated: {0}" -f (Get-Date))
  $lines += ""
  $lines += ("Count: {0}" -f ($items.Count))
  $lines += ""
  $lines += "| Name | Size (KB) | Last Write | Full Path |"
  $lines += "|---|---:|---|---|"
  foreach ($it in $items) {
    $kb = [math]::Round(($it.Length / 1024), 1)
    $lw = $it.LastWriteTime.ToString("yyyy-MM-dd HH:mm:ss")
    $lines += ("| {0} | {1} | {2} | {3} |" -f $it.Name, $kb, $lw, $it.FullName.Replace("\","/"))
  }
  $lines | Set-Content -Encoding UTF8 -Path $path
}

Write-MdIndex -path ".\INDEX_ROOT_PS1.md" -title "Root PS1 Index (kept in project root)" -items $rootPs1
Write-MdIndex -path ".\INDEX_ARCHIVED_PS1.md" -title "Archived PS1 Index (_archive/root_20260311_101123)" -items $archPs1

# --- CSV summary (root vs archive)
$csv = @()
foreach ($it in $rootPs1) {
  $csv += [pscustomobject]@{
    Scope="root"
    Name=$it.Name
    LastWriteTime=$it.LastWriteTime
    SizeBytes=$it.Length
    FullPath=$it.FullName
  }
}
foreach ($it in $archPs1) {
  $csv += [pscustomobject]@{
    Scope="archive"
    Name=$it.Name
    LastWriteTime=$it.LastWriteTime
    SizeBytes=$it.Length
    FullPath=$it.FullName
  }
}
$csv | Sort-Object Scope, LastWriteTime -Descending | Export-Csv -NoTypeInformation -Encoding UTF8 ".\ROOT_VS_ARCHIVE.csv"

Write-Host "✅ Wrote:" -ForegroundColor Green
Write-Host " - .\INDEX_ROOT_PS1.md" -ForegroundColor Green
Write-Host " - .\INDEX_ARCHIVED_PS1.md" -ForegroundColor Green
Write-Host " - .\ROOT_VS_ARCHIVE.csv" -ForegroundColor Green

Write-Host ""
Write-Host "Open reports:" -ForegroundColor Yellow
Write-Host "  notepad .\INDEX_ROOT_PS1.md" -ForegroundColor Yellow
Write-Host "  notepad .\INDEX_ARCHIVED_PS1.md" -ForegroundColor Yellow