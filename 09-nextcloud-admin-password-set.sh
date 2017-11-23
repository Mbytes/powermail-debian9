#!/bin/sh


/etc/init.d/redis-server restart
/etc/init.d/memcached restart

NCPASS=`pwgen -c -1 8`
echo $NCPASS > /usr/local/src/nextcloudadmin-pass

echo "Nextcloud admin login: nextcloud and password $NCPASS in /usr/local/src/nextcloudadmin-pass"
cd /var/www/html/nextcloud
sudo -u www-data bash -c "export OC_PASS=$NCPASS ;php occ  user:resetpassword --password-from-env nextcloud "
cd -

