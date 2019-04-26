#!/bin/bash

# get terraform dir
read -p "Enter dir: " dir

# go to script dir
cd "$(dirname "$0")/$dir"

# source to get variables
source ./scripts/launchWeb.config

# get public_ip 
public_ip=$(grep -w public_ip terraform.tfstate | awk '{print $2}' | sed 's/[",]//g')


ssh -tt -oStrictHostKeyChecking=no -i ~/.ssh/$key_file ubuntu@$public_ip
