# include scoop libs
$dir = "$HOME\scoop\apps\scoop\current"
. "$dir\lib\versions.ps1"
. "$dir\lib\buckets.ps1"
. "$dir\lib\depends.ps1"
. "$dir\lib\core.ps1"
. "$dir\lib\manifest.ps1"

function ScoopInstall($app) {
  if ((app_status $app).installed -ne $true) {
    scoop install $app
  }
}

function ScoopBucket($bucket) {
  $dir = Find-BucketDirectory $name -Root
  if (-not (Test-Path $dir)) {
    scoop bucket add $bucket
  }
}
