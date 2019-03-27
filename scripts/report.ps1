Set-Location $PSScriptRoot/..

$ver = [Environment]::OSVersion

Write-Host " * $ver"

Write-Host -NoNewline " * Sakuten/devenv@"
git rev-parse HEAD

Write-Host -NoNewline " * Sakuten/frontend@"
Set-Location frontend
git rev-parse HEAD
Set-Location ..

Set-Location backend
Write-Host -NoNewline " * Sakuten/backend@"
git rev-parse HEAD
Set-Location ..
