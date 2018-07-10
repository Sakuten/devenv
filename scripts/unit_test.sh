#!/bin/bash

if [ "$#" -ne 0 ]; then
  docker-compose -f unit_test/docker-compose.yml run --rm $@
else
  docker-compose -f unit_test/docker-compose.yml run --rm frontend
  docker-compose -f unit_test/docker-compose.yml run --rm backend
fi
