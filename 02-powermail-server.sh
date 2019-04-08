#y!/bin/sh

## install roundcube  ,  groupoffice , postfixadmin and all mailserver stuff without mailscanner & haraka
echo `hostname` > /etc/mailname
sh files/extra-tools/etc-config-backup.sh
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
/bin/cp -pR files/extra-tools/* /bin/
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




#/etc/init.d/opendkim start
/etc/init.d/spamassassin start
/etc/init.d/clamav-freshclam start
/etc/init.d/clamav-daemon start
/etc/init.d/apache2 start

#systemctl enable spamassassin

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

echo "roundcube-core roundcube/dbconfig-install boolean true"  | debconf-set-selections
echo "roundcube-core roundcube/app-password-confirm password $AUTOGENERATED_PASS"  | debconf-set-selections
echo "roundcube-core roundcube/mysql/app-pass password $AUTOGENERATED_PASS"  | debconf-set-selections




apt-get install -y roundcube roundcube-core roundcube-mysql roundcube-plugins roundcube-plugins-extra
sed -i "s/#    Alias \/roundcube \/var\/lib\/roundcube/    Alias \/roundcube \/var\/lib\/roundcube/" /etc/apache2/conf-enabled/roundcube.conf
sed -i "s/\$config\['default_host'\] = '';/\$config\['default_host'\] = '127.0.0.1';/" /etc/roundcube/config.inc.php
sed -i "s/\$config\['smtp_server'\] = '';/\$config\['smtp_server'\] = '127.0.0.1';/" /etc/roundcube/config.inc.php



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



echo > /var/log/mail.log
/bin/rm -rf /var/log/mail.info
/bin/rm -rf /var/log/mail.warn
/bin/rm -rf /var/log/mail.err
echo > /var/log/dovecot.log

chown -R www-data:www-data /var/www/html


echo "Working on importing godb GroupOffice MySQL database..."
MYSQLPASSVPOP=`pwgen -c -1 8`
echo $MYSQLPASSVPOP > /usr/local/src/mysql-godb-pass
## need to autogen

mysqladmin create godb -uroot
echo "GRANT ALL PRIVILEGES ON godb.* TO godb@localhost IDENTIFIED BY '$MYSQLPASSVPOP'" | mysql -uroot
mysqladmin -uroot  reload
mysqladmin -uroot  refresh

mysql  godb < files/godb-fresh.sql

GOPASSVPOP=`pwgen -c -1 8`
echo $GOPASSVPOP > /usr/local/src/groupofficeadmin-pass
echo "update godb.go_users set password=md5('$GOPASSVPOP'), password_type='md5' where username='groupofficeadmin'" | mysql;


#sed -i "s/ohm8ahC2/`cat /usr/local/src/mysql-nextcloud-pass`/" /var/www/html/nextcloud/config/config.php
#sed -i "s/powermail\.mydomainname\.com/`hostname`/" /var/www/html/nextcloud/config/config.php

sed -i "s/ohm8ahC2/`cat /usr/local/src/mysql-godb-pass`/" /var/www/html/groupoffice/config.php
sed -i "s/powermail\.mydomainname\.com/`hostname`/" /var/www/html/groupoffice/config.php
sed -i "s/powermail\.mydomainname\.com/`hostname`/" /var/www/html/groupoffice/imapauth.config.php


## add Archive Part its now with mailscanner
#echo "MAILTO=\"\"" >> /var/spool/cron/crontabs/root
#echo "*/3 * * * * /usr/local/src/mailarchive-scripts/fetch-and-convert.sh" >> /var/spool/cron/crontabs/root
#echo "* * * * * /usr/local/src/mailarchive-scripts/add-email-from-stage2-to-final-index.sh" >> /var/spool/cron/crontabs/root


sed -i "s/powermail\.mydomainname\.com/`hostname`/" /etc/dovecot/conf.d/10-ssl.conf
sed -i "s/powermail\.mydomainname\.com/`hostname`/" /etc/apache2/sites-available/default-ssl.conf

systemctl disable spampd.service
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

## only useful for nextcloud if used
systemctl disable redis-server.service
systemctl disable memcached.service
/etc/init.d/redis-server stop
/etc/init.d/memcached stop



sendEmail -f postmaster@`hostname`  -t postmaster@`hostname` -u "Test Mail via 25" -m "Test Mail" -o tls=no -s 127.0.0.1:25 2>/dev/null 1>/dev/null
sendEmail -f postmaster@`hostname`  -t postmaster@`hostname` -u "Test Mail via 2525" -m "Test Mail" -o tls=no -s 127.0.0.1:2525 2>/dev/null 1>/dev/null
echo "All Done";
echo "";
