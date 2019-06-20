#!/bin/bash

# install packages
sudo apt-get update
sudo apt-get install -y nginx
sudo add-apt-repository ppa:certbot/certbot -y
sudo apt install python-certbot-nginx -y

# ufw
echo y | sudo ufw enable 
sudo ufw allow 80
sudo ufw allow 443
sudo ufw allow 22

# download docker
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common -y

# add Docker GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# setup stable repository
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# install docker
sudo apt-get install docker-ce docker-ce-cli containerd.io -y


# setup nginx
cd "$(dirname "$0")"
sudo mv stevenle.xyz /etc/nginx/sites-available/stevenle.xyz
sudo ln -s /etc/nginx/sites-available/stevenle.xyz /etc/nginx/sites-enabled/
sudo sed -i 's/# server_names/server_names/' /etc/nginx/nginx.conf
sudo systemctl restart nginx

# install drone and run
sudo docker pull drone/drone:1


