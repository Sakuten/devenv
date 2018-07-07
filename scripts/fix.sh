#!/bin/bash

docker-compose -f lint/lint.yml run --rm frontend
docker-compose -f lint/lint.yml run --rm backend
