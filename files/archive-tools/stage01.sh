#!/bin/sh

cd /opt/archive-tools/program
find /data/extrabackup/new2/ -type f -exec php read-mail-and-move-to-date-folder.php {} \;
cd -
