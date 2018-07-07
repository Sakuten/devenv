#!/bin/bash

docker-compose -f lint/docker-compose.yml run --rm frontend
docker-compose -f lint/docker-compose.yml run --rm backend
