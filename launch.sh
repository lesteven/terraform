#!/bin/bash

read -p "Enter dir: " dir

echo $dir
cd ./$dir

terraform init
printf yes | terraform apply
