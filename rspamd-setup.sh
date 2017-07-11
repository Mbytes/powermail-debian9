#!/bin/sh
#https://rspamd.com/doc/quickstart.html
#CODENAME=`lsb_release -c -s`
curl -s https://rspamd.com/apt-stable/gpg.key | apt-key add -
echo "deb http://rspamd.com/apt-stable/ stretch main" > /etc/apt/sources.list.d/rspamd.list
echo "deb-src http://rspamd.com/apt-stable/ stretch main" >> /etc/apt/sources.list.d/rspamd.list
apt-get update
#apt-get --no-install-recommends install rspamd
apt-get install rspamd