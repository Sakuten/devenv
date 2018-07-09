#!/bin/bash

readonly cachedir="~/.cache/devenv/"

if [ ! -d "$cachedir" ]; then
  mkdir -p $cachedir
fi

declare -A targets=(
 [backend]="backend/Dockerfile.dev"  [frontend]="frontend/Dockerfile.dev"  [monitor]="monitor/Dockerfile.dev"
)

for service in "${!targets[@]}"; do
  dockerfile=${targets[$service]}

  name=$(echo "$dockerfile" | md5sum | awk '{print $1}')
  hash=$(md5sum $dockerfile | awk '{print $1}')

  cachepath="$cachedir/$name"

  if [ -e "$cachepath" ]; then
    prehash=$(cat "$cachepath")

    if [ "$hash" == "$prehash" ]; then
      echo "$dockerfile not changed. skipping"
      continue
    fi
  fi

  docker-compose build $service
  echo $hash > $cachepath
done
