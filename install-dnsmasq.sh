#!/bin/sh

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
    sudo cp dnsmasq.conf /etc/dnsmasq.conf
    sudo cp dnsmasq.hosts.conf /etc/dnsmasq.d/
fi
