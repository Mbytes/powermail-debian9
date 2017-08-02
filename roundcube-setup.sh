#!/bin/sh

#apt-get install -y roundcube roundcube-core roundcube-mysql roundcube-plugins roundcube-plugins-extra 
#sed -i "s/#    Alias \/roundcube \/var\/lib\/roundcube/    Alias \/roundcube \/var\/lib\/roundcube/" /etc/apache2/conf-enabled/roundcube.conf
#sed -i "s/\$config\['default_host'\] = '';/\$config\['default_host'\] = '127.0.0.1';/" /etc/roundcube/config.inc.php
#sed -i "s/\$config\['smtp_server'\] = '';/\$config\['smtp_server'\] = '127.0.0.1';/" /etc/roundcube/config.inc.php



echo "Working on importing roundcube webmail MySQL database..."


MYSQLPASS=`pwgen -c -1 8`
echo $MYSQLPASS > /usr/local/src/mysql-roundcube-webmail-pass


mysqladmin create roundcube -uroot
echo "GRANT ALL PRIVILEGES ON roundcube.* TO roundcube@localhost IDENTIFIED BY '$MYSQLPASS'" | mysql -uroot
mysqladmin -uroot reload
mysqladmin -uroot refresh



