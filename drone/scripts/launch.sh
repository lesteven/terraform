#!/bin/bash

# go to script dir
cd "$(dirname "$0")"

cd ..

# go to root to activate terraform
terraform init
printf yes | terraform apply

public_ip=$(terraform output ip)
firefox $public_ip
