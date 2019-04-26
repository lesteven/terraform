#!/bin/bash

# go to script dir, then one level down
cd "$(dirname "$0")/.."

# clone private repo to copy into ec2
git clone git@github.com:lesteven/nodeServer.git

terraform init
printf yes | terraform apply

# clean up
rm -rf nodeServer
