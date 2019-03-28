$ErrorActionPreference = "Stop"

$cachedir = "$HOME\.cache\devenv\"

if (!(Test-Path $cachedir)) {;
  mkdir $cachedir
}

$targets = @{
  backend = "backend\Dockerfile.dev";
  frontend = "frontend\Dockerfile.dev";
  monitor = "monitor\Dockerfile.dev";
}

function build($dockerfile, $service) {
  $namedata = [System.Text.Encoding]::ASCII.GetBytes($dockerfile)
  $md5 = [System.Security.Cryptography.MD5]::create()
  $namehash = $md5.computeHash($namedata)
  $name = [System.BitConverter]::ToString($namehash). `
          ToLower().Replace("-", "")
  $hash = Get-FileHash $dockerfile -Algorithm MD5

  $cachepath = "$cachedir/$name"

  if (Test-Path $cachepath) {
    $prehash = Get-Content $cachepath

    if ($hash.Hash.Equals($prehash)) {
      Write-Output "$dockerfile not changed. skipping";
      return
    }
  }

  docker-compose build $service
  Write-Output $hash.Hash > $cachepath
}

if ($args.Length -ne 0) {
  build $targets[$args[0]] $args[0]
} else {
  foreach ($key in $targets.Keys) {
    build $targets[$key] $key
  }
}
