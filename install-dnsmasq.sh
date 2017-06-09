#!/bin/bash

type=`uname -m`
unamestr=`uname`
platform='unknown'
if [[ "$unamestr" == 'Linux' ]]; then
    platform='linux'
elif [[ "$unamestr" == 'armv7' ]]; then
    platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
    platform='macos'
fi

if [[ $platform == 'linux' ]]; then
    sudo apt-get install -y dnsmasq
    sudo cp dnsmasq/dnsmasq.conf /etc/dnsmasq.conf
    sudo cp dnsmasq/dhcp.conf /etc/dnsmasq.d/
    sudo cp dnsmasq/dnsmasq.hosts.conf /etc/dnsmasq.hosts.conf
fi
