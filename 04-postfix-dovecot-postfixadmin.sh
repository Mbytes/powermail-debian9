#y!/bin/sh

sh files/etc-config-backup.sh
groupadd -g 89 vmail 2>/dev/null
useradd -g vmail -u 89 -d /home/powermail vmail 2>/dev/null
mkdir -p /home/powermail/domains  2>/dev/null
mkdir -p /home/powermail/sieve  2>/dev/null

#/bin/cp -pR files/powermail/* /home/powermail/	

chown -R vmail:vmail /home/powermail
#chmod 755 /home/powermail/bin/*

#mkdir /var/log/powermail/  2>/dev/null
 


#sed -i "s/AllowSupplementaryGroups false/AllowSupplementaryGroups true/" /etc/clamav/clamd.conf


#/bin/cp -pR files/spamassassin /etc/default/
#/bin/cp -pR files/spamassassin-etc/* /etc/spamassassin/

#chown vmail:vmail /var/log/powermail/smtp-inbound.log
#/bin/cp files/clamd.conf /etc/clamav/
#/bin/cp files/freshclam.conf /etc/clamav/

##/bin/cp -pR files/powermail-inbound /opt/

#/etc/init.d/spamassassin restart
#/etc/init.d/clamav-freshclam restart
#/etc/init.d/clamav-daemon restart

#/bin/cp files/rsyslog.conf /etc/
#/etc/init.d/rsyslog restart
#/bin/rm /var/log/mail.info 2>/dev/null
#/bin/rm /var/log/mail.warn 2>/dev/null
#/bin/rm /var/log/mail.err 2>/dev/null
#/bin/rm /var/log/mail.log 2>/dev/null

echo `hostname` > /etc/mailname

#/bin/cp -pR files/postfix/* /etc/postfix/
#/bin/cp -pR files/dovecot/* /etc/dovecot/
#/bin/cp -pR files/opendkim.conf /etc/
#/bin/cp -pR files/opendkim /etc/


echo "Working on importing powermail MySQL database..."


MYSQLPASSVPOP=`pwgen -c -1 8`
echo $MYSQLPASSVPOP > /usr/local/src/mysql-powermail-pass


mysqladmin create powermail -uroot -p$MYSQLPW
echo "GRANT ALL PRIVILEGES ON powermail.* TO powermail@localhost IDENTIFIED BY '$MYSQLPASSVPOP'" | mysql -uroot 
mysqladmin -uroot reload
mysqladmin -uroot refresh


#mysql -u powermail -p$MYSQLPASSVPOP powermail < files/powermail-basic-db.sql
###mysql -u powermail -p`cat /usr/local/src/mysql-powermail-pass` powermail < files/powermail-basic-db.sql





echo "copying powermailadmin and groupoffice in /var/www/html .."
/bin/cp -pR files/powermailadmin /var/www/html/
/bin/cp -p files/index.php /var/www/html/
/bin/rm -rf /var/www/html/index.html

#mkdir /var/www/html/powermailadmin/templates_c 2>/dev/null

#chmod -R 777 /var/www/html/powermailadmin/templates_c




#/bin/cp -pR files/pfHandle /bin/
#/bin/cp -pR files/sendEmail /bin/
#/bin/cp -pR files/viewmaillog /bin/
#/bin/cp -pR files/viewmaillog /bin/maillogview
#/bin/cp -pR files/etc-config-backup.sh /bin/



## disabled amavis
postconf -e 'content_filter = '
#/etc/init.d/postfix stop
#/etc/init.d/dovecot stop
#/etc/init.d/opendkim stop

#perl files/powermail-db-pass.pl
#perl files/godb-db-pass.pl 


#cd /tmp
#curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
#composer --version
#pecl install mailparse-2.1.6
#echo "extension=mailparse.so" > /etc/php5/mods-available/mailparse.ini
#ln -vs /etc/php5/mods-available/mailparse.ini /etc/php5/cli/conf.d/20-mailparse.ini
#ln -vs /etc/php5/mods-available/mailparse.ini /etc/php5/apache2/conf.d/20-mailparse.ini
#/etc/init.d/apache2 restart
#cd -
#cd /etc/php5
#composer require php-mime-mail-parser/php-mime-mail-parser
#cd -
#/etc/init.d/apache2 restart


#start after ssl is done
#/etc/init.d/postfix start
#/etc/init.d/dovecot start
#/etc/init.d/opendkim start

