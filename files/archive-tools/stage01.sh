#!/bin/sh

cd /opt/archive-tools/program
find /data/extrabackup/ -type f -exec php read-mail-and-move-to-date-folder.php {} \;
cd -
date >/root/connvert-time
