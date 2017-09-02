#!/bin/sh

cd /var/www/html/nextcloud
sudo -u www-data php occ trashbin:cleanup

