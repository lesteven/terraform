#!/bin/bash

read -s -p $'Passphrase: \n' passphrase

read -p "Key name: " key

cd ~/.ssh

dir="."

if [ -f "$dir/$key" ]; then
    echo "$key already exists"
else
    echo "creating $key"
    ssh-keygen -t rsa -f "$dir/$key" -N ""
fi
