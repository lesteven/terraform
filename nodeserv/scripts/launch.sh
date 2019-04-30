#!/bin/bash

# go to script dir
cd "$(dirname "$0")"

# clone private repo to copy into ec2
git clone git@github.com:lesteven/nodeServer.git ./prov/nodeServer

# go to root to activate terraform
cd ..
terraform init
printf yes | terraform apply

# clean up
rm -rf ./scripts/prov/nodeServer

public_ip=$(terraform output ip)
firefox $public_ip
