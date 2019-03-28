$ErrorActionPreference = "Stop"

foreach ($dir in "frontend", "backend") {
  Set-Location $dir
  $untracked = git ls-files --other --exclude-standard
  if ($untracked.Length -ne 0) {
    Write-Output "Warn: Unracked files detected in ${dir}:"
    Write-Output $untracked
    Write-Output "If this is intended, you can ignore this warning."
  }
  Set-Location ..
}

docker-compose rm
docker-compose -f lint/docker-compose.yml rm
docker-compose -f test/docker-compose.yml rm
docker-compose -f unit_test/docker-compose.yml rm

docker-compose build
docker-compose -f lint/docker-compose.yml build
docker-compose -f test/docker-compose.yml build
docker-compose -f unit_test/docker-compose.yml build
