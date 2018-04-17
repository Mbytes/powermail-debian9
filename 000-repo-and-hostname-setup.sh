#!/bin/bash

## setup local hostname with domainname and ifconfig/Local IP on this machine/vm

HOSTNAME=demo.technomail.in
IPADDR=192.163.163.119

hostname $HOSTNAME
echo "$IPADDR	$HOSTNAME" >> /etc/hosts
echo $HOSTNAME > /etc/hostname

#Disable vim automatic visual mode using mouse
echo "\"set mouse=a/g" >  ~/.vimrc


## backup existing repo by copy to root
/bin/cp -pR /etc/apt/sources.list /root/old-sources.list-`date +%s`
echo "" >  /etc/apt/sources.list
echo "deb http://httpredir.debian.org/debian stretch main contrib non-free" >> /etc/apt/sources.list
echo "deb http://httpredir.debian.org/debian stretch-updates main contrib non-free" >> /etc/apt/sources.list
echo "deb http://security.debian.org/ stretch/updates main contrib non-free" >> /etc/apt/sources.list

apt-get update
CFG_HOSTNAME_FQDN=`hostname`
echo "postfix postfix/main_mailer_type select Internet Site" | debconf-set-selections
echo "postfix postfix/mailname string $CFG_HOSTNAME_FQDN" | debconf-set-selections

#### remove exim by installing postfix before upgrade
apt-get -y install postfix 

##### configure proper timezone
#dpkg-reconfigure tzdata
##### configure locale proper
#dpkg-reconfigure locales

## set India IST time.
#/bin/rm -rf /etc/localtime
#/bin/ln -vs /usr/share/zoneinfo/Asia/Kolkata /etc/localtime

apt-get -y  upgrade

#### for adding firmware realtek driver
#apt-get install firmware-linux-nonfree
#apt-get install firmware-realtek
#update-initramfs -u


## to have features like CentOS for Bash

echo "" >> /etc/bash.bashrc
echo "alias cp='cp -i'" >> /etc/bash.bashrc
echo "alias l.='ls -d .* --color=auto'" >> /etc/bash.bashrc
echo "alias ll='ls -l --color=auto'" >> /etc/bash.bashrc
echo "alias ls='ls --color=auto'" >> /etc/bash.bashrc
echo "alias mv='mv -i'" >> /etc/bash.bashrc
echo "alias rm='rm -i'" >> /etc/bash.bashrc

#Load bashrc

source /etc/bash.bashrc




