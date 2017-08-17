#!/bin/sh

NCPASS=`pwgen -c -1 8`
echo $NCPASS > /usr/local/src/nextcloud-pass-for-admin-via-gui


cd /var/www/html/nextcloud
sudo -u www-data bash -c "export OC_PASS=$NCPASS ;php occ  user:resetpassword --password-from-env nextcloud "


