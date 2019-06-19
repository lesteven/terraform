#!/bin/bash

# install packages
sudo apt-get update
#curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
#sudo apt-get install -y nodejs
sudo apt-get install -y nginx

sudo systemctl restart nginx

