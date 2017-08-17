#!/bin/sh

cd /var/www/html/nextcloud
sudo -u www-data php occ user:setting nextcloud  files quota "3 GB"

