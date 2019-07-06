#!/bin/bash

cd "$(dirname "$0")"

name=$(terraform output name)
address=$(terraform output address)
port=$(terraform output port)
username=$(terraform output username)

password=$(grep password terraform.tfvars | awk '{print $3}' | sed 's/"//g')

str="dbname="$name" user="$username" password="$password" host="$address" sslmode=verify-full sslrootcert=cert.pem"

echo "str = '"$str"'" > config.py
