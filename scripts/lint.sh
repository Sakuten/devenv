#!/bin/bash

docker-compose -f lint/docker-compose.yml run --rm frontend lint
docker-compose -f lint/docker-compose.yml run --rm backend lint
