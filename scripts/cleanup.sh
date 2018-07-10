#!/bin/bash

set -e

for dir in frontend backend; do
  cd $dir
  untracked=$(git ls-files --other --exclude-standard)
  if [[ -n "$untracked" ]]; then
    echo "Warn: Unracked files detected in $dir:"
    echo $untracked
    echo "If this is intended, you can ignore this warning."
  fi
  cd ..
done


docker-compose rm
docker-compose -f lint/docker-compose.yml rm
docker-compose -f test/docker-compose.yml rm
docker-compose -f unit_test/docker-compose.yml rm

docker-compose build
docker-compose -f lint/docker-compose.yml build
docker-compose -f test/docker-compose.yml build
docker-compose -f unit_test/docker-compose.yml build
