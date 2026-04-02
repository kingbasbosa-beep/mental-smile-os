Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$ClinicianId    = "Rq0Nirc5kQXDbSfY7dcGupMFjAj1"
$ClinicianEmail = "kingbasbosa@gmail.com"
$ClinicianPass  = "add123"

.\mk_web_fix_and_run.ps1 `
  -ClinicianId $ClinicianId `
  -ClinicianEmail $ClinicianEmail `
  -ClinicianPass $ClinicianPass `
  -ResetProfiles
