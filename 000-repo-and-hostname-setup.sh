#!/bin/bash

## setup local hostname with domainname and ifconfig/Local IP on this machine/vm

## sample
###HOSTNAME=powermail.domainname.com
###IPADDR=192.168.1.1

###HOSTNAME=powermail.domainname.com
###IPADDR=192.168.1.1

##disable ipv6 as most time not required
sysctl -w net.ipv6.conf.all.disable_ipv6=1
sysctl -w net.ipv6.conf.default.disable_ipv6=1


#build rc.local as it not there by default in debian 9.x and 10.x
/bin/cp -pR /etc/rc.local /usr/local/old-rc.local-`date +%s` 2>/dev/null
touch /etc/rc.local
printf '%s\n' '#!/bin/bash'  | sudo tee -a /etc/rc.local
echo "sysctl -w net.ipv6.conf.all.disable_ipv6=1" >>/etc/rc.local
echo "sysctl -w net.ipv6.conf.default.disable_ipv6=1" >> /etc/rc.local
echo "exit 0" >> /etc/rc.local
chmod 755 /etc/rc.local

echo "[Unit]" > /etc/systemd/system/rc-local.service
echo " Description=/etc/rc.local Compatibility" >> /etc/systemd/system/rc-local.service
echo " ConditionPathExists=/etc/rc.local" >> /etc/systemd/system/rc-local.service
echo "" >> /etc/systemd/system/rc-local.service
echo "[Service]" >> /etc/systemd/system/rc-local.service
echo " Type=forking" >> /etc/systemd/system/rc-local.service
echo " ExecStart=/etc/rc.local start" >> /etc/systemd/system/rc-local.service
echo " TimeoutSec=0" >> /etc/systemd/system/rc-local.service
echo " StandardOutput=tty" >> /etc/systemd/system/rc-local.service
echo " RemainAfterExit=yes" >> /etc/systemd/system/rc-local.service
echo " SysVStartPriority=99" >> /etc/systemd/system/rc-local.service
echo "" >> /etc/systemd/system/rc-local.service
echo "[Install]" >> /etc/systemd/system/rc-local.service
echo " WantedBy=multi-user.target" >> /etc/systemd/system/rc-local.service

systemctl enable rc-local
systemctl start rc-local


## backup existing repo by copy to root
/bin/cp -pR /etc/apt/sources.list /usr/local/old-sources.list-`date +%s`
echo "" >  /etc/apt/sources.list
echo "deb http://httpredir.debian.org/debian stretch main contrib non-free" >> /etc/apt/sources.list
echo "deb http://httpredir.debian.org/debian stretch-updates main contrib non-free" >> /etc/apt/sources.list
echo "deb http://security.debian.org/ stretch/updates main contrib non-free" >> /etc/apt/sources.list

apt-get update
apt-get -y install vim screen wget telnet openssh-server mc iptraf iputils-ping git sudo bind9 curl elinks xfsprogs debconf-utils pwgen net-tools
apt-get upgrade

hostname $HOSTNAME
echo "$IPADDR   $HOSTNAME" >> /etc/hosts
echo $HOSTNAME > /etc/hostname

#Disable vim automatic visual mode using mouse
echo "\"set mouse=a/g" >  ~/.vimrc
echo "syntax on" >> ~/.vimrc

apt-get update
CFG_HOSTNAME_FQDN=`hostname`
echo "postfix postfix/main_mailer_type select Internet Site" | debconf-set-selections
echo "postfix postfix/mailname string $CFG_HOSTNAME_FQDN" | debconf-set-selections

#### remove exim by installing postfix before upgrade
apt-get -y install postfix 
apt-get -y  upgrade

##### configure proper timezone
#dpkg-reconfigure tzdata
##### configure locale proper
#dpkg-reconfigure locales
## set India IST time.
#/bin/rm -rf /etc/localtime
#/bin/ln -vs /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
#### for adding firmware realtek driver
#apt-get install firmware-linux-nonfree
#apt-get install firmware-realtek
#update-initramfs -u
## only if VM notfor LXC
## for proxmox/kvm better preformance
#apt-get -y install qemu-guest-agent

##  To have features like CentOS for Bash
echo "" >> /etc/bash.bashrc
echo "alias cp='cp -i'" >> /etc/bash.bashrc
echo "alias l.='ls -d .* --color=auto'" >> /etc/bash.bashrc
echo "alias ll='ls -l --color=auto'" >> /etc/bash.bashrc
echo "alias ls='ls --color=auto'" >> /etc/bash.bashrc
echo "alias mv='mv -i'" >> /etc/bash.bashrc
echo "alias rm='rm -i'" >> /etc/bash.bashrc

#Load bashrc

source /etc/bash.bashrc




