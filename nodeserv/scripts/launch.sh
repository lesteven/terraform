#!/bin/bash

# go to script dir, then one level down
cd "$(dirname "$0")/.."

# clone private repo to copy into ec2
git clone git@github.com:lesteven/nodeServer.git
mv nodeServer ./scripts/prov

terraform init
printf yes | terraform apply

# clean up
rm -rf ./scripts/prov/nodeServer
