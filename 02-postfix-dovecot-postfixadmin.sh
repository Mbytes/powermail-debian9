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




sed -i "s/SOCKET\=local\:\$RUNDIR\/opendkim.sock/#SOCKET\=local\:\$RUNDIR\/opendkim.sock/" /etc/default/opendkim
sed -i "s/#SOCKET\=inet\:12345\@localhost/SOCKET\=inet\:12345\@localhost/" /etc/default/opendkim 
/lib/opendkim/opendkim.service.generate
systemctl daemon-reload
service opendkim restart



#/etc/init.d/opendkim start
/etc/init.d/spamassassin start
/etc/init.d/clamav-freshclam start
/etc/init.d/clamav-daemon start
/etc/init.d/postfix start
/etc/init.d/dovecot start
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

#perl files/powermail-db-pass.pl





