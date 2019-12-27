function Symlink($link, $source) {
  if ((Test-Path $link) -And ((Get-Item $link).Target -ne $source)) {
    Remove-Item $link
  }

  if (-not (Test-Path $link)) {
    New-Item -Path $link -ItemType SymbolicLink -Value $source
  }
}
