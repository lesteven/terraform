#!/bin/bash

read -p "Enter dir: " dir

echo $dir
cd ./$dir

printf yes | terraform destroy
