#!/bin/sh

wget http://download.proxmox.com/debian/proxmox-ve-release-5.x.gpg -O /etc/apt/trusted.gpg.d/proxmox-ve-release-5.x.gpg
echo "deb http://download.proxmox.com/debian/pmg stretch pmg-no-subscription" >/etc/apt/sources.list.d/pmg.list

apt-get update
apt-get -y upgrade
apt-get -y install proxmox-mailgateway screen vim iptraf 
