#!/bin/bash

. ./install-scripts/lib/platform.sh

if [[ $platform == 'linux' ]]; then
    sudo apt-get install -y dnsmasq
    sudo cp dnsmasq/dnsmasq.conf /etc/dnsmasq.conf
    sudo cp dnsmasq/dhcp.conf /etc/dnsmasq.d/
    sudo cp dnsmasq/dnsmasq.hosts.conf /etc/dnsmasq.hosts.conf

    sudo mkdir -p /etc/dnsmasq.d
    sudo cp dnsmasq/dnsmasq.conf /etc/dnsmasq.conf
elif [[ $platform == 'macos' ]]; then
    echo not implemented
fi

