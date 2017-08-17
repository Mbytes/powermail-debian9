#!/bin/sh

/bin/rm -rf /var/www/html/nextcloud/core/skeleton/Documents/*
/bin/rm -rf /var/www/html/nextcloud/core/skeleton/Photos/* 
/bin/rm -rf /var/www/html/nextcloud/core/skeleton/N*
chown -R www-data:www-data /var/www/html
echo "Working on importing nextcloud webmail MySQL database..."

MYSQLPASS=`pwgen -c -1 8`
echo $MYSQLPASS > /usr/local/src/mysql-nextcloud-pass
NCPASS=`pwgen -c -1 8`
echo $NCPASS > /usr/local/src/nextcloudadmin-pass


mysqladmin create nextcloud -uroot
echo "GRANT ALL PRIVILEGES ON nextcloud.* TO nextcloud@localhost IDENTIFIED BY '$MYSQLPASS'" | mysql -uroot
mysqladmin -uroot reload
mysqladmin -uroot refresh

mysql  <  files/nextcloud-db.sql

## nextcloudadmin with techno02srv default password
##sudo -u www-data php /var/www/html/nextcloud/occ -n maintenance:install --database "mysql" --database-name "nextcloud"  --database-user "nextcloud" --database-pass "`cat /usr/local/src/mysql-nextcloud-pass`" --admin-user "nextcloudadmin" --admin-pass "`cat /usr/local/src/nextcloudadmin-pass`"


# chekc full apache default ssl config file default-ssl.conf-sample
