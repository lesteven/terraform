#!/bin/bash

cd "$(dirname "$0")"
source drone.config

sudo docker container run \
    --volume=/var/run/docker.sock:/var/run/docker.sock \
    --volume=/var/lib/drone:/data \
    --env=DRONE_GITHUB_SERVER=https://github.com \
    --env=DRONE_GITHUB_CLIENT_ID="$github_client_id" \
    --env=DRONE_GITHUB_CLIENT_SECRET="$github_client_secret" \
    --env=DRONE_RUNNER_CAPACITY=2 \
    --env=DRONE_SERVER_HOST="$server_host" \
    --env=DRONE_SERVER_PROTO="$server_proto" \
    --env=DRONE_TLS_AUTOCERT=true \
    --publish=3000:80 \
    --publish=443:443 \
    --restart=always \
    --detach=true \
    --name=drone \
  drone/drone:1
