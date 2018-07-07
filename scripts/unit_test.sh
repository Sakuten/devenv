#!/bin/bash

docker-compose -f unit_test/test.yml run --rm frontend
docker-compose -f unit_test/test.yml run --rm backend
