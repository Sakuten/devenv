if ($args.Length -ne 0) {
  docker-compose -f lint/docker-compose.yml run --rm $args[0]
} else {
  docker-compose -f lint/docker-compose.yml run --rm frontend
  docker-compose -f lint/docker-compose.yml run --rm backend
}
