#!/bin/bash

docker-compose -f unit_test/docker-compose.yml run --rm frontend
docker-compose -f unit_test/docker-compose.yml run --rm backend
