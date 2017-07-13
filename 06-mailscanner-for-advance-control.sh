#!/bin/sh

#MailScanner Setup

files/etc-config-backup.sh


cd files/MailScanner-5.0.3-7/
./install.sh
cd ../../

/bin/cp -pRv files/header_checks /etc/postfix/header_checks
## disabled amavis
postconf -e 'content_filter = '
chkconfig --level 345 amavis off 2>/dev/null

/bin/cp -pRv files/MailScanner-defaults /etc/MailScanner/defaults
/bin/cp -pRv files/MailScanner-etc/* /etc/MailScanner/
###/bin/cp -pRv files/MailScanner-share/* /usr/share/MailScanner/

touch /etc/MailScanner/archives.filetype.rules.conf
touch /etc/MailScanner/archives.filename.rules.conf
touch /etc/MailScanner/filename.rules.conf

mkdir /var/spool/MailScanner/incoming
mkdir /var/spool/MailScanner/quarantine
mkdir /var/spool/MailScanner/incoming/Locks
chown postfix.postfix /var/spool/MailScanner/incoming
chown postfix.postfix /var/spool/MailScanner/quarantine
chown postfix:root /var/spool/postfix/

## so that mailwatch can read
chmod 744 /var/spool/postfix/incoming/
chmod 744 /var/spool/postfix/hold/
chown -R postfix  /var/log/clamav
mkdir /mail-archive-uncompress
mkdir /mail-archive-compress
mkdir /mail-archive-process
chmod 777 /mail-archive-uncompress
chmod 777 /mail-archive-compress
chmod 777 /mail-archive-process


/etc/init.d/clamav-daemon restart
/etc/init.d/opendkim restart

chkconfig --level 2345 opendkim on

#copy PM files to
#/usr/share/MailScanner/perl/custom
/bin/cp -pRv files/mailwatch/MailScanner_perl_scripts/MailWatch.pm /usr/share/MailScanner/perl/custom/MailWatch.pm
/bin/cp -pRv files/mailwatch/htmlfiles/mailscanner /var/www/html/

##INSERT INTO `mailscanner`.`users` (`username`, `password`, `fullname`, `type`, `quarantine_report`, `spamscore`, `highspamscore`, `noscan`, `quarantine_rcpt`) VALUES ('mailwatch', MD5('techno02srv'), 'Mail Admin', 'A', '0', '0', '0', '0', NULL);
