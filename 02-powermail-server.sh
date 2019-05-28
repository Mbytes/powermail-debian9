#y!/bin/sh

## install roundcube  ,  groupoffice , postfixadmin and all mailserver stuff without mailscanner & haraka
echo `hostname` > /etc/mailname

## take one backup for safety
sh files/rootdir/bin/etc-config-backup.sh

## adding 89 so that migration from qmailtoaster setup is easier.
groupadd -g 89 vmail 2>/dev/null
useradd -g vmail -u 89 -d /home/powermail vmail 2>/dev/null

/etc/init.d/spamassassin stop 2>/dev/null
/etc/init.d/clamav-freshclam stop 2>/dev/null
/etc/init.d/clamav-daemon stop 2>/dev/null
/etc/init.d/postfix stop 2>/dev/null
/etc/init.d/dovecot stop 2>/dev/null
/etc/init.d/opendkim stop 2>/dev/null
/etc/init.d/apache2 stop 2>/dev/null

mkdir /home/groupoffice/ 2>/dev/null
chmod 777 /home/groupoffice/
chown www-data:www-data /home/groupoffice/


/bin/cp -pR files/rootdir/* /

mkdir  /var/www/html/powermailadmin/templates_c 2>/dev/null
chmod -R 777 /var/www/html/powermailadmin/templates_c

chown -R vmail:vmail /home/powermail
chmod 755 /home/powermail/bin/*

touch /var/log/dovecot.log
chmod 666 /var/log/dovecot.log
chmod 666 /var/log/clamav/clamav.log

sed -i "s/error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT/error_reporting = E_ERROR/" /etc/php/7.0/cli/php.ini
sed -i "s/error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT/error_reporting = E_ERROR/" /etc/php/7.0/apache2/php.ini

sed -i "s/SOCKET\=local\:\$RUNDIR\/opendkim.sock/#SOCKET\=local\:\$RUNDIR\/opendkim.sock/" /etc/default/opendkim
sed -i "s/#SOCKET\=inet\:12345\@localhost/SOCKET\=inet\:12345\@localhost/" /etc/default/opendkim 
/lib/opendkim/opendkim.service.generate
systemctl daemon-reload

### use same to add for other new domain too
/bin/dkim-setup.pl `hostname`

service opendkim restart

/etc/init.d/spamassassin start
/etc/init.d/clamav-freshclam start
/etc/init.d/clamav-daemon start
/etc/init.d/apache2 start

echo "Working on importing powermail MySQL database..."

MYSQLPASSVPOP=`pwgen -c -1 8`
echo $MYSQLPASSVPOP > /usr/local/src/mysql-powermail-pass
mysqladmin create powermail -uroot 
echo "GRANT ALL PRIVILEGES ON powermail.* TO powermail@localhost IDENTIFIED BY '$MYSQLPASSVPOP'" | mysql -uroot 
mysqladmin -uroot reload
mysqladmin -uroot refresh

## disabled amavis if got install
postconf -e 'content_filter = '

mysql  <  files/powermaildb.sql

sed -i "s/ohm8ahC2/`cat /usr/local/src/mysql-powermail-pass`/" /etc/postfix/sql/mysql_relay_domains_maps.cf
sed -i "s/ohm8ahC2/`cat /usr/local/src/mysql-powermail-pass`/" /etc/postfix/sql/mysql_virtual_alias_domain_catchall_maps.cf
sed -i "s/ohm8ahC2/`cat /usr/local/src/mysql-powermail-pass`/" /etc/postfix/sql/mysql_virtual_alias_domain_mailbox_maps.cf
sed -i "s/ohm8ahC2/`cat /usr/local/src/mysql-powermail-pass`/" /etc/postfix/sql/mysql_virtual_alias_domain_maps.cf
sed -i "s/ohm8ahC2/`cat /usr/local/src/mysql-powermail-pass`/" /etc/postfix/sql/mysql_virtual_alias_maps.cf
sed -i "s/ohm8ahC2/`cat /usr/local/src/mysql-powermail-pass`/" /etc/postfix/sql/mysql_virtual_domains_maps.cf
sed -i "s/ohm8ahC2/`cat /usr/local/src/mysql-powermail-pass`/" /etc/postfix/sql/mysql_virtual_mailbox_limit_maps.cf
sed -i "s/ohm8ahC2/`cat /usr/local/src/mysql-powermail-pass`/" /etc/postfix/sql/mysql_virtual_mailbox_maps.cf
sed -i "s/ohm8ahC2/`cat /usr/local/src/mysql-powermail-pass`/" /etc/dovecot/dovecot-sql.conf.ext
sed -i "s/ohm8ahC2/`cat /usr/local/src/mysql-powermail-pass`/" /etc/dovecot/dovecot-dict-sql.conf.ext
sed -i "s/ohm8ahC2/`cat /usr/local/src/mysql-powermail-pass`/" /var/www/html/powermailadmin/config.inc.php 
sed -i "s/ohm8ahC2/`cat /usr/local/src/mysql-powermail-pass`/" /var/www/html/powermailadmin/config.local.php 

sed -i "s/powermail\.mydomainname\.com/`hostname`/" /etc/postfix/main.cf
sed -i "s/ohm8ahC2/`cat /usr/local/src/mysql-powermail-pass`/" /home/powermail/etc/powermail.mysql 

## default password for mysql root on debian 9 localhost is NONE
MYSQL_ROOT_PASS=""
AUTOGENERATED_PASS=`pwgen -c -1 10`

## remove different mail log files and reset one used
echo > /var/log/mail.log
/bin/rm -rf /var/log/mail.info
/bin/rm -rf /var/log/mail.warn
/bin/rm -rf /var/log/mail.err
echo > /var/log/dovecot.log

chown -R www-data:www-data /var/www/html

echo "Working on importing GroupOffice MySQL database..."
MYSQLPASSVPOP=`pwgen -c -1 8`
echo $MYSQLPASSVPOP > /usr/local/src/mysql-groupofficedb-pass
## need to autogen

mysqladmin create groupoffice -uroot
echo "GRANT ALL PRIVILEGES ON groupoffice.* TO groupoffice@localhost IDENTIFIED BY '$MYSQLPASSVPOP'" | mysql -uroot
mysqladmin -uroot  reload
mysqladmin -uroot  refresh

sed -i "s/ohm8ahC2/`cat /usr/local/src/mysql-groupofficedb-pass`/" /etc/groupoffice/config.php

/bin/cp -p files/groupoffice-6.3.sql /tmp/groupoffice-6.3-tmp.sql
### doing sed multiple time to replace multiple time
sed -i "s/powermail\.mydomainname\.com/`hostname`/" /tmp/groupoffice-6.3-tmp.sql
sed -i "s/powermail\.mydomainname\.com/`hostname`/" /tmp/groupoffice-6.3-tmp.sql
sed -i "s/powermail\.mydomainname\.com/`hostname`/" /tmp/groupoffice-6.3-tmp.sql
sed -i "s/powermail\.mydomainname\.com/`hostname`/" /tmp/groupoffice-6.3-tmp.sql
sed -i "s/powermail\.mydomainname\.com/`hostname`/" /tmp/groupoffice-6.3-tmp.sql

mysql groupoffice < /tmp/groupoffice-6.3-tmp.sql
/bin/rm -rf /tmp/groupoffice-6.3-tmp.sql
GOPASSVPOP=`pwgen -c -1 8`
echo $GOPASSVPOP > /usr/local/src/groupofficeadmin-pass

php files/extra-addon/groupoffice63-groupofficeadmin-password-reset.php 






## update host.domainname for commented entries of letsencrypt.
sed -i "s/powermail\.mydomainname\.com/`hostname`/" /etc/dovecot/conf.d/10-ssl.conf
sed -i "s/powermail\.mydomainname\.com/`hostname`/" /etc/apache2/sites-available/default-ssl.conf

systemctl disable spampd
/etc/init.d/spampd stop

/etc/init.d/dovecot restart
/etc/init.d/postfix restart
/etc/init.d/rsyslog restart
/etc/init.d/apache2 restart

## add system domain

/home/powermail/bin/vadddomain `hostname`
/home/powermail/bin/vaddalias root@`hostname` postmaster@`hostname`
/home/powermail/bin/vaddalias clamav@`hostname` postmaster@`hostname`
/home/powermail/bin/vaddalias abuse@`hostname` postmaster@`hostname`
/home/powermail/bin/vaddalias fbl@`hostname` postmaster@`hostname`

## only useful for nextcloud if used or harakasmtp 
systemctl disable redis-server.service
systemctl disable memcached.service
/etc/init.d/redis-server stop
/etc/init.d/memcached stop

#/usr/share/clamav-unofficial-sigs/conf.d/00-clamav-unofficial-sigs.conf
# disable /comment below lines in above file
#   honeynet.hdb
#   securiteinfo.hdb
#   securiteinfobat.hdb
#   securiteinfodos.hdb
#   securiteinfoelf.hdb
#   securiteinfohtml.hdb
#   securiteinfooffice.hdb
#   securiteinfopdf.hdb
#   securiteinfosh.hdb


## install groupoffice from repo
echo "deb http://repo.group-office.com/ 63-php-70 main" > /etc/apt/sources.list.d/groupoffice.list
## not accessable /slow most time
#apt-key adv --recv-keys --keyserver pool.sks-keyservers.net 0758838B 2>/dev/null
#gpg --keyserver pool.sks-keyservers.net --recv-keys 0758838B
#gpg --export --armor 0758838B | sudo apt-key add -

cat files/groupoffice-0758838B-key.txt |  apt-key add -
apt-get update


echo "groupoffice groupoffice/dbconfig-install boolean false" | debconf-set-selections

### issue with key at times ..use unauth
##apt-get -y install groupoffice --allow-unauthenticated
apt-get -y install groupoffice 





sendEmail -f postmaster@`hostname`  -t postmaster@`hostname` -u "Test Mail via 25" -m "Test Mail" -o tls=no -s 127.0.0.1:25 2>/dev/null 1>/dev/null
sendEmail -f postmaster@`hostname`  -t postmaster@`hostname` -u "Test Mail via 2525" -m "Test Mail" -o tls=no -s 127.0.0.1:2525 2>/dev/null 1>/dev/null
echo "All Done";
echo "";
