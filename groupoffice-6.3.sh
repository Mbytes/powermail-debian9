#!/bin/sh


#echo $MYSQLPASSVPOP > /usr/local/src/mysql-groupofficedb-pass



echo "deb http://repo.group-office.com/ 63-php-70 main" > /etc/apt/sources.list.d/groupoffice.list

## not accessable /slow most time
#apt-key adv --recv-keys --keyserver pool.sks-keyservers.net 0758838B 2>/dev/null
#gpg --keyserver pool.sks-keyservers.net --recv-keys 0758838B
#gpg --export --armor 0758838B | sudo apt-key add -

cat files/groupoffice-0758838B-key.txt |  apt-key add -

sed -i "s/ohm8ahC2/`cat /usr/local/src/groupofficeadmin-pass`/" /etc/groupoffice/config.php  

#apt-get update

### issue with key at times ..use unauth
##apt-get -y install groupoffice-com --allow-unauthenticated
#apt-get -y install groupoffice-com 


