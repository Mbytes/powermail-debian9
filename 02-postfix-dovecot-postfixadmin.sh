#y!/bin/sh

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



/bin/cp -pR files/rootdir/* /
/bin/cp -pR files/extra-tools/* /bin/
mkdir  /var/www/html/powermailadmin/templates_c 2>/dev/null
chmod -R 777 /var/www/html/powermailadmin/templates_c

chown -R vmail:vmail /home/powermail
chmod 755 /home/powermail/bin/*

touch /var/log/dovecot.log
chmod 666 /var/log/dovecot.log
chmod 666 /var/log/clamav/clamav.log



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

sed -i "s/powermail\.mydomainname\.com/`hostname`/" /etc/postfix/main.cf
sed -i "s/ohm8ahC2/`cat /usr/local/src/mysql-powermail-pass`/" /home/powermail/etc/powermail.mysql 

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


/etc/init.d/postfix start
/etc/init.d/dovecot start
/etc/init.d/rsyslog restart

## add system domain

/home/powermail/bin/vadddomain `hostname`
/home/powermail/bin/vaddalias root@`hostname` postmaster@`hostname`
/home/powermail/bin/vaddalias clamav@`hostname` postmaster@`hostname`
/home/powermail/bin/vaddalias abuse@`hostname` postmaster@`hostname`




