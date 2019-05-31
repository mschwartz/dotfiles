#!/bin/bash

. ~/dotfiles/install-scripts/lib/platform.sh

figlet "Install Docker"

if [[ $platform == 'arch' ]]; then
  yay -Syy docker docker-machine docker-compose iptables iproute bridge-utils
  echo "RESTART MAY BE REQUIRED"
  sudo systemctl enable docker.service
  sudo systemctl restart docker.service
  sudo groupadd docker
  sudo usermod -aG docker $USER
elif [[ $platform == 'linux' ]]; then
  if [[ $platform_type == 'armv7l' ]]; then
    echo "SKIPPING ON PI"
  else
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
      edge"
    sudo apt-get update
    sudo apt-get install -y docker-ce
    sudo apt-get install -y python-pip
    sudo -H pip install docker-compose
    sudo groupadd docker
    sudo usermod -aG docker $USER
  fi
fi
