#!/bin/sh

# Docker
echo "Docker"

sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
echo "CURL"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install -y docker-ce
sudo apt-get install -y python-pip -y
echo "PIP"
sudo -H pip install docker-compose
sudo groupadd docker
sudo usermod -aG docker $USER
