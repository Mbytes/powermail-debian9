#!/bin/sh


mkdir /home/nextcloud/ 2>/dev/null
chmod 777 /home/nextcloud/
chown www-data:www-data /home/nextcloud/



echo "Working on importing nextcloud webmail MySQL database..."

MYSQLPASS=`pwgen -c -1 8`
echo $MYSQLPASS > /usr/local/src/mysql-nextcloud-pass
mysqladmin create nextcloud -uroot
echo "GRANT ALL PRIVILEGES ON nextcloud.* TO nextcloud@localhost IDENTIFIED BY '$MYSQLPASS'" | mysql -uroot
mysqladmin -uroot reload
mysqladmin -uroot refresh

mysql  < files/nextcloud-db.sql

/bin/rm -rf /var/www/html/nextcloud/core/skeleton/Documents/*
/bin/rm -rf /var/www/html/nextcloud/core/skeleton/Photos/*
/bin/rm -rf /var/www/html/nextcloud/core/skeleton/N*
chown -R www-data:www-data /var/www/html

NCPASS=`pwgen -c -1 8`
echo $NCPASS > /usr/local/src/nextcloudadmin-pass

echo "Nextcloud admin login: nextcloud and password $NCPASS in /usr/local/src/nextcloudadmin-pass"
cd /var/www/html/nextcloud
sudo -u www-data bash -c "export OC_PASS=$NCPASS ;php occ  user:resetpassword --password-from-env nextcloud "
cd -


/etc/init.d/redis-server restart
/etc/init.d/memcached restart

NCPASS=`pwgen -c -1 8`
echo $NCPASS > /usr/local/src/nextcloudadmin-pass

echo "Nextcloud admin login: nextcloud and password $NCPASS in /usr/local/src/nextcloudadmin-pass"
cd /var/www/html/nextcloud
sudo -u www-data bash -c "export OC_PASS=$NCPASS ;php occ  user:resetpassword --password-from-env nextcloud "
cd -

