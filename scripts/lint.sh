#!/bin/bash

if [ "$#" -ne 0 ]; then
  docker-compose -f lint/docker-compose.yml run --rm $@ lint
else
  docker-compose -f lint/docker-compose.yml run --rm frontend lint
  docker-compose -f lint/docker-compose.yml run --rm backend lint
fi
