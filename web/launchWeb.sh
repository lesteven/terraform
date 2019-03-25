#!/bin/bash

# source to get variables
source launchWeb.config

# create private key
aws ec2 create-key-pair --key-name $key_name | jq -r ".KeyMaterial" > ~/.ssh/$key_file

# init and apply terraform
terraform init
printf 'yes' | terraform apply

chmod 600 ~/.ssh/$key_file

