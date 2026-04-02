# mk_pack_allinone_savepoint.ps1
# (Paste FULL script content here, then save)
# mk_pack_allinone_savepoint.ps1
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$downloads = Join-Path $env:USERPROFILE "Downloads"

# الملفات المطلوب تجميعها (لازم تكون موجودة في Downloads)
$files = @(
  "MK_Savepoint_Handoff_Pack_REFRESH_2026-03-11_161214.zip",
  "MK_Savepoint_Handoff_2026-03-11_161214.md",
  "TEMPLATE_Specialists_Admin_Flow.md"
)

Write-Host "== MK All-In-One Pack ==" -ForegroundColor Cyan
Write-Host "Downloads: $downloads" -ForegroundColor DarkGray

# تأكيد وجود الملفات
$missing = @()
foreach ($f in $files) {
  $p = Join-Path $downloads $f
  if (!(Test-Path $p)) { $missing += $p }
}

if ($missing.Count -gt 0) {
  Write-Host "❌ Missing files in Downloads:" -ForegroundColor Red
  $missing | ForEach-Object { Write-Host " - $_" -ForegroundColor Red }
  Write-Host "" 
  Write-Host "✅ الحل: حط الملفات الناقصة في Downloads ثم شغّل السكربت تاني." -ForegroundColor Yellow
  exit 1
}

# اسم الـ ZIP النهائي
$out = Join-Path $downloads "MK_AllInOne_Savepoint_Handoff_2026-03-11_161214.zip"

# لو موجود قبل كده امسحه
if (Test-Path $out) {
  Remove-Item $out -Force
  Write-Host "🧹 Removed old: $out" -ForegroundColor DarkYellow
}

# اعمل الـ ZIP
$paths = $files | ForEach-Object { Join-Path $downloads $_ }
Compress-Archive -Path $paths -DestinationPath $out -Force

Write-Host "✅ DONE: $out" -ForegroundColor Green
Write-Host "Open Downloads to share the single ZIP." -ForegroundColor Green