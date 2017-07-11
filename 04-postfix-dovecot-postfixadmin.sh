#y!/bin/sh

echo `hostname` > /etc/mailname
sh files/extra-tools/etc-config-backup.sh
groupadd -g 89 vmail 2>/dev/null
useradd -g vmail -u 89 -d /home/powermail vmail 2>/dev/null
mkdir -p /home/powermail/domains  2>/dev/null
mkdir -p /home/powermail/sieve  2>/dev/null

#/bin/cp -pR files/powermail/* /home/powermail/	

chown -R vmail:vmail /home/powermail
chmod 755 /home/powermail/bin/*
touch /var/log/dovecot.log
chmod 666 /var/log/dovecot.log
 
/bin/cp -pR files/extra-tools/* /bin/


sed -i "s/SafeBrowsing false/SafeBrowsing yes/" /etc/clamav/freshclam.conf
sed -i "s/ENABLED=0/ENABLED=1/" /etc/default/spamassassin 
sed -i "s/CRON=0/CRON=1/" /etc/default/spamassassin
sed -i 's/OPTIONS\=\"\-\-create-prefs \-\-max\-children 5 \-\-helper\-home\-dir\"/OPTIONS\=\"\-\-create-prefs \-\-max\-children 5 \-\-helper\-home\-dir \-s \/var\/log\/spamassassin\.log\"/' /etc/default/spamassassin 

sed -i "s/#    Alias \/roundcube \/var\/lib\/roundcube/    Alias \/roundcube \/var\/lib\/roundcube/" /etc/apache2/conf-enabled/roundcube.conf
sed -i "s/\$config\['default_host'\] = '';/\$config\['default_host'\] = '127.0.0.1';/" /etc/roundcube/config.inc.php



#/bin/cp -pR files/spamassassin-etc/* /etc/spamassassin/


##/bin/cp -pR files/powermail-inbound /opt/

#/etc/init.d/spamassassin restart
#/etc/init.d/clamav-freshclam restart
#/etc/init.d/clamav-daemon restart


#/bin/cp -pR files/postfix/* /etc/postfix/
#/bin/cp -pR files/dovecot/* /etc/dovecot/
#/bin/cp -pR files/opendkim.conf /etc/
#/bin/cp -pR files/opendkim /etc/


echo "Working on importing powermail MySQL database..."


MYSQLPASSVPOP=`pwgen -c -1 8`
echo $MYSQLPASSVPOP > /usr/local/src/mysql-powermail-pass


mysqladmin create powermail -uroot 
echo "GRANT ALL PRIVILEGES ON powermail.* TO powermail@localhost IDENTIFIED BY '$MYSQLPASSVPOP'" | mysql -uroot 
mysqladmin -uroot reload
mysqladmin -uroot refresh


#mysql -u powermail -p$MYSQLPASSVPOP powermail < files/powermail-basic-db.sql
###mysql -u powermail -p`cat /usr/local/src/mysql-powermail-pass` powermail < files/powermail-basic-db.sql


echo "copying powermailadmin and groupoffice in /var/www/html .."
#/bin/cp -pR files/powermailadmin /var/www/html/
#/bin/cp -p files/index.php /var/www/html/
#/bin/rm -rf /var/www/html/index.html

#mkdir /var/www/html/powermailadmin/templates_c 2>/dev/null
#chmod -R 777 /var/www/html/powermailadmin/templates_c


## disabled amavis if got install
postconf -e 'content_filter = '

#perl files/powermail-db-pass.pl

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


systemctl enable spamassassin

#start after ssl is done
#/etc/init.d/postfix start
#/etc/init.d/dovecot start
#/etc/init.d/opendkim start

