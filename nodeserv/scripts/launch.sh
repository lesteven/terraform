#!/bin/bash

# go to script dir
cd "$(dirname "$0")"

cd ..
ssh-keyscan github.com > ./scripts/prov/githubKey

# go to root to activate terraform
terraform init
printf yes | terraform apply

public_ip=$(terraform output ip)
firefox $public_ip
