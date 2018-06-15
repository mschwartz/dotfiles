#!/bin/bash

. ~/dotfiles/install-scripts/lib/platform.sh

if [[ $platform == 'linux' ]]; then
    sudo apt-get install -y dnsmasq
    sudo mkdir -p /etc/dnsmasq.d

    # configure dnsmasq
    echo "copy dnsmasq.conf"
    sudo cp dnsmasq/dnsmasq.conf /etc/dnsmasq.conf
    # dns IP/hosts configuration file
    echo "copy dnsmasq.hosts.conf"
    sudo cp dnsmasq/dnsmasq.hosts.conf /etc/dnsmasq.hosts.conf

    # only copy dhcp.conf if on bigmoney
    # this will make bigmoney the only dhcp authority
    if [[ $hostname == 'bigmoney' ]]; then
      echo "copy dhcp config"
      sudo cp dnsmasq/dhcp.conf /etc/dnsmasq.d/
    else
      echo "remove dhcp config"
      sudo rm /etc/dnsmasq.d/dhcp.conf
    fi

    echo "restarting dnsmasq"
    sudo service dnsmasq restart
    sudo service dnsmasq restart
    grep dhcp-leasefile /etc/dnsmasq.d/dhcp.conf
elif [[ $platform == 'macos' ]]; then
    echo not implemented
fi

