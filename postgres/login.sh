#!/bin/bash

cd "$(dirname "$0")"

name=$(terraform output name)
address=$(terraform output address)
port=$(terraform output port)
username=$(terraform output username)

password=$(grep password terraform.tfvars | awk '{print $3}' | sed 's/"//g')


#psql --host="$address" --port="$port" \
#    --username="$username" --password --dbname="$name"

# put quotes around connection uri, otherwise it will not work
uri="postgresql://"$username":"$password"@"$address":"$port"/"$name"\
?sslmode=verify-full&sslrootcert=cert.pem"


psql "$uri"
