param(
  [switch]$Bootstrap,
  [switch]$Seed,
  [switch]$Clinician
)

# UTF-8 console (fixes â„¹ï¸ and mojibake in logs)
chcp 65001 | Out-Null
[Console]::InputEncoding  = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

$defines = @()
if ($Bootstrap) { $defines += "--dart-define=BOOTSTRAP=true" }
if ($Seed)      { $defines += "--dart-define=SEED=true" }
if ($Clinician) { $defines += "--dart-define=CLINICIAN_MODE=true" }

flutter run -d chrome @defines
