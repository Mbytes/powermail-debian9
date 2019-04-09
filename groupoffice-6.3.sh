#!/bin/sh


echo "deb http://repo.group-office.com/ 63-php-70 main" > /etc/apt/sources.list.d/groupoffice.list

## not accessable /slow most time
#apt-key adv --recv-keys --keyserver pool.sks-keyservers.net 0758838B 2>/dev/null
#gpg --keyserver pool.sks-keyservers.net --recv-keys 0758838B
#gpg --export --armor 0758838B | sudo apt-key add -

cat files/groupoffice-0758838B-key.txt |  apt-key add -


apt-get update


echo "groupoffice groupoffice/dbconfig-install boolean false" | debconf-set-selections
echo "groupoffice groupoffice/database-type select mysql" | debconf-set-selections
echo "groupoffice groupoffice/remote/host select  localhost" | debconf-set-selections
echo "groupoffice groupoffice/remote/port string  3306" | debconf-set-selections

### issue with key at times ..use unauth
##apt-get -y install groupoffice --allow-unauthenticated
apt-get -y install groupoffice 


