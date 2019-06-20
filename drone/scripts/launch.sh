#!/bin/bash

# go to script dir
cd "$(dirname "$0")"

cd ..

# go to root to activate terraform
terraform init
printf yes | terraform apply


# source to get variables
public_ip=$(terraform output eip)
cd "$(dirname "$0")"
source launchWeb.config

# get public_ip 

ssh -tt -oStrictHostKeyChecking=no -i ~/.ssh/$key_file ubuntu@$public_ip 'bash -s' < ./prov/runBot.sh

cd ..
firefox $public_ip
