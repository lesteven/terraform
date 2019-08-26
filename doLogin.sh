#!/bin/bash

# get terraform dir
read -p "Enter dir: " dir

# go to script dir
cd "$(dirname "$0")/$dir"

read -p "Enter keyname: " key

ip=$(terraform output ip)

ssh -tt -oStrictHostKeyChecking=no -i "~/.ssh/$key" "root@$ip"
