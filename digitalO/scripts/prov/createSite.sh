#!/bin/bash

# install packages
sudo apt-get update
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo apt-get install -y nginx


# replace example.com w/ ip address
# "$(dirname "$0")" is the dir where the bashscript exists (createSite)
# change into this dir, b/c this is where example.com exists as well
cd "$(dirname "$0")"
public_ip=$(cat ip.txt)
sed -i "s/example.com/$public_ip/" ./example.com


# setup nginx
sudo rm /etc/nginx/sites-available/default
sudo mv example.com /etc/nginx/sites-available/default
#sudo ln -s /etc/nginx/sites-available/example.com /etc/nginx/sites-enabled/

sudo sed -i 's/# server_names/server_names/' /etc/nginx/nginx.conf
sudo systemctl restart nginx

cd ~/jsProj/nodeServer
npm i
sudo npm i pm2 -g
pm2 start ./src/index.js
