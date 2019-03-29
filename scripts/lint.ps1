if ($args.Length -ne 0) {
  docker-compose -f lint/docker-compose.yml run --rm $args[0] lint
} else {
  docker-compose -f lint/docker-compose.yml run --rm frontend lint
  docker-compose -f lint/docker-compose.yml run --rm backend lint
}
