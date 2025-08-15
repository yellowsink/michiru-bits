#!/bin/sh

docker compose -f /home/services/docker-compose.yml stop \
	$(docker compose -f /home/services/docker-compose.yml ps -a --format json \
		| jq 'select(.Labels | split(",") | index("ink.yellows.dontrestart=true") == null) | .Name' -r)
