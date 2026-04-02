function Invoke-CleanPaste {
  param([Parameter(Mandatory=$true)][string]$Text)

  $lines = $Text -split "(`r`n|`n|`r)"
  $clean = foreach($l in $lines){
    $x = $l.TrimEnd()
    $x = $x -replace '^\s*PS\s+[A-Z]:\\[^>]*>\s*', ''
    $x = $x -replace '^\s*[A-Z]:\\[^>]*>\s*', ''
    if($x.Trim().Length -gt 0){ $x }
  }

  $script = ($clean -join "`r`n")
  Write-Host "`n--- Running cleaned script ---" -ForegroundColor Cyan
  Write-Host $script -ForegroundColor DarkGray
  Invoke-Expression $script
}
