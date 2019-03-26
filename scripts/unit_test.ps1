if ($args.Length -ne 0) {
  docker-compose -f unit_test/docker-compose.yml run --rm $args[0]
} else {
  docker-compose -f unit_test/docker-compose.yml run --rm frontend
  docker-compose -f unit_test/docker-compose.yml run --rm backend
}
