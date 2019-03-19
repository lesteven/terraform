#!/bin/bash

source launchWeb.config

rm ~/.ssh/$key_file
aws ec2 delete-key-pair --key-name $key_name
printf 'yes' | terraform destroy
