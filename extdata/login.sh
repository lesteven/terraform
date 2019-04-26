#!/bin/bash

# source to get variables
source launchWeb.config

read -p "First (1) or second (2): " pick

# get public_dns 
if [ $pick = 1 ]; then
    public_dns=$(grep -w public_dns terraform.tfstate | awk '{print $2}' | sed 's/[",]//g' | head -n1)
else
    public_dns=$(grep -w public_dns terraform.tfstate | awk '{print $2}' | sed 's/[",]//g' | tail -n1)
fi

echo ubuntu@$public_dns
ssh -tt -oStrictHostKeyChecking=no -i ~/.ssh/$key_file ubuntu@$public_dns
