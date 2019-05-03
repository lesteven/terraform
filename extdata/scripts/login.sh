#!/bin/bash

cd "$(dirname "$0")"
# source to get variables
source launchWeb.config

cd ..
read -p "webA (1) or webB (2): " pick

# get public_dns 
if [ $pick = 1 ]; then
    public_dns=$(terraform output webA_ip)
else
    public_dns=$(terraform output webB_ip)
fi

echo ubuntu@$public_dns
ssh -tt -oStrictHostKeyChecking=no -i ~/.ssh/$key_file ubuntu@$public_dns
