#!/bin/bash

# source to get variables
source launchWeb.config

# get public_dns 
public_dns=$(grep -w public_ip terraform.tfstate | awk '{print $2}' | sed 's/[",]//g')


ssh -tt -oStrictHostKeyChecking=no -i ~/.ssh/$key_file ubuntu@$public_dns
