#!/bin/bash

# install packages

sudo apt-get update
yes | sudo add-apt-repository ppa:longsleep/golang-backports

printf Y | sudo apt-get install golang-go
printf Y | sudo apt-get install nginx

# replace example.com w/ ip address
public_ip=$(curl ifconfig.me)
sed -i "s/example.com/$public_ip/" example.com

# get server code
git clone https://github.com/lesteven/goServer.git
cd ~/goServer
sudo go build server.go
exec ./server&
cd ~

# setup nginx
sudo mv example.com /etc/nginx/sites-available/example.com
sudo ln -s /etc/nginx/sites-available/example.com /etc/nginx/sites-enabled/

sudo sed -i 's/# server_names/server_names/' /etc/nginx/nginx.conf

sudo systemctl restart nginx
