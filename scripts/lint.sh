#!/bin/bash

docker-compose -f lint/lint.yml run --rm frontend lint
docker-compose -f lint/lint.yml run --rm backend lint
