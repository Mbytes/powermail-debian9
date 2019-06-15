#!/bin/sh

apt-get -y  install libchm-bin  libchm-dev libchm1 binfmt-support gcc-arm-linux-gnueabihf parted qemu-user-static  debootstrap


# https://www.lesbonscomptes.com/pages/signatures.html
#https://www.lesbonscomptes.com/recoll/download.html#debian

#gpg --keyserver pool.sks-keyservers.net --recv-key F8E3347256922A8AE767605B7808CE96D38B9201
gpg --recv-key '4C6E 80B6 374D CD5F 53AB 706A 32D9 C2A8 35ED 066C'
gpg --recv-key 'F8E3 3472 5692 2A8A E767 605B 7808 CE96 D38B 9201'

gpg --export '7808CE96D38B9201' | sudo apt-key add -


echo "deb http://www.lesbonscomptes.com/recoll/debian/ stretch main" > /etc/apt/sources.list.d/recoll.list
echo "deb-src http://www.lesbonscomptes.com/recoll/debian/ stretch main >> /etc/apt/sources.list.d/recoll.list

apt-get update
apt-get -y install recoll python-recoll python3-recoll

