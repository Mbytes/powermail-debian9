#!/bin/sh

cd /opt/archive-tools/program
find /home/powermail/domains/archive.technomail.in/infotechfullbackup/Maildir/new/ -type f -exec php read-mail-and-move-to-date-folder.php {} \;
find /home/powermail/domains/archive.technomail.in/infotechfullbackup/Maildir/cur/ -type f -exec php read-mail-and-move-to-date-folder.php {} \;
cd -

