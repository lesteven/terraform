#!/bin/bash

# install packages
sudo apt-get update
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo apt-get install -y nginx


# "$(dirname "$0")" is the dir where the bashscript exists (createSite)
cd "$(dirname "$0")"

# setup nginx
sudo mv stevenle.xyz /etc/nginx/sites-available/stevenle.xyz
sudo rm /etc/nginx/sites-enabled/default
sudo ln -s /etc/nginx/sites-available/stevenle.xyz /etc/nginx/sites-enabled/

sudo sed -i 's/# server_names/server_names/' /etc/nginx/nginx.conf
sudo systemctl restart nginx

cd ~/
git clone https://github.com/lesteven/budget.git
cd budget
npm i
npm run build
sudo npm i pm2 -g
pm2 start ./src/server/index.js
