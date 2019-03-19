#!/bin/bash

# source to get variables
source launchWeb.config

# create private key
aws ec2 create-key-pair --key-name $key_name | jq -r ".KeyMaterial" > ~/.ssh/$key_file

# init and apply terraform
terraform init
printf 'yes' | terraform apply

chmod 600 ~/.ssh/$key_file


echo wait for ec2 to stabilize
sleep 10s
echo start ssh

# ssh into container
source login.sh
