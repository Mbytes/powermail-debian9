#!/bin/sh
apt-get -y purge clamav-unofficial-sigs
wget -q --no-check-certificate https://github.com/extremeshok/clamav-unofficial-sigs/archive/master.zip -O /tmp/clamav-unofficial-sigs.zip
unzip  -o /tmp/clamav-unofficial-sigs.zip -d /tmp/clamav-unofficial-sigs/
mkdir -p /usr/local/bin/
mkdir -p /var/log/clamav-unofficial-sigs/
mkdir -p /etc/clamav-unofficial-sigs/
/bin/cp -pRv /tmp/clamav-unofficial-sigs/clamav-unofficial-sigs-master/clamav-unofficial-sigs.sh /usr/local/bin/clamav-unofficial-sigs.sh
chmod +x /usr/local/bin/clamav-unofficial-sigs.sh
/bin/cp -pRv /tmp/clamav-unofficial-sigs/clamav-unofficial-sigs-master/config/*.* /etc/clamav-unofficial-sigs/
/bin/cp -pRv /etc/clamav-unofficial-sigs/os.debian8.conf /etc/clamav-unofficial-sigs/os.conf
echo 'user_configuration_complete="yes"' >> /etc/clamav-unofficial-sigs/user.conf 
##Install Systemd configs:
##cp -pRv /tmp/clamav-unofficial-sigs/clamav-unofficial-sigs-master/systemd/*.* /etc/systemd/
ln -vs /usr/local/bin/clamav-unofficial-sigs.sh /etc/cron.daily/


/usr/local/bin/clamav-unofficial-sigs.sh

