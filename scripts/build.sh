#!/bin/bash

readonly cachedir="$HOME/.cache/devenv/"

if [ ! -d "$cachedir" ]; then
  mkdir -p "$cachedir"
fi

declare -A targets
targets[backend]="backend/Dockerfile.dev"
targets[frontend]="frontend/Dockerfile.dev"
targets[monitor]="monitor/Dockerfile.dev"

function build() {
  dockerfile="$1"
  service="$2"

  name=$(echo "$dockerfile" | md5sum | awk '{print $1}')
  hash=$(md5sum "$dockerfile" | awk '{print $1}')

  cachepath="$cachedir/$name"

  if [ -e "$cachepath" ]; then
    prehash=$(cat "$cachepath")

    if [ "$hash" == "$prehash" ]; then
      echo "$dockerfile not changed. skipping"
      return
    fi
  fi

  docker-compose build $service
  echo $hash > "$cachepath"
}

if [ "$#" -ne 0 ]; then
  build "${targets[$1]}" $1
else
  for service in "${!targets[@]}"; do
    build "${targets[$service]}" $service
  done
fi
