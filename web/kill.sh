#!/bin/bash

source launchWeb.config

printf 'yes' | terraform destroy
rm ~/.ssh/$key_file
aws ec2 delete-key-pair --key-name $key_name
