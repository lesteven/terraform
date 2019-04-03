#!/bin/bash

# source to get variables
source launchWeb.config

# get public_ip 
public_ip=$(grep -w public_ip terraform.tfstate | awk '{print $2}' | sed 's/[",]//g')

ssh -tt -oStrictHostKeyChecking=no -i ~/.ssh/$key_file ubuntu@$public_ip 'bash -s' < runExecutable.sh
