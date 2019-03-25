#!/bin/bash

# install packages

sudo apt-get update
printf Y | sudo apt-get install golang-go
printf Y | sudo apt-get install nginx

# get server code
git clone https://github.com/lesteven/goServer.git

# setup nginx
sudo mv example.com /etc/nginx/sites-available/example.com
sudo ln -s /etc/nginx/sites-available/example.com /etc/nginx/sites-enabled/

sudo sed -i 's/# server_names/server_names/' /etc/nginx/nginx.conf

sudo systemctl restart nginx
