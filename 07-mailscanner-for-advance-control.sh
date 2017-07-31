#!/bin/sh

#MailScanner Setup

files/extra-tools/etc-config-backup.sh

cd files/mailscanner-root/MailScanner-5.0.3-7/
./install.sh
cd ../../../

/bin/cp -pRv files/mailscanner-root/header_checks /etc/postfix/header_checks
## disabled amavis
postconf -e 'content_filter = '
chkconfig --level 345 amavis off 2>/dev/null

/bin/cp -pRv files/mailscanner-root/MailScanner-etc/* /etc/MailScanner/

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



#copy PM files to
#/usr/share/MailScanner/perl/custom
/bin/cp -pR files/mailscanner-root/MailWatch-1.2.2/MailScanner_perl_scripts/* /usr/share/MailScanner/perl/custom/
/bin/cp -pR files/mailscanner-root/MailWatch-1.2.2/mailscanner /var/www/html/
/bin/cp -pR files/mailscanner-root/MailWatch-1.2.2/tools/Postfix_relay/*.php /usr/local/bin/
/bin/cp -pR files/mailscanner-root/MailWatch-1.2.2/tools/Postfix_relay/mailwatch-postfix-relay /usr/local/bin/


echo "Creating Database mailscanner for storing all logs for mailwatch"
mysql < files/mailscanner-root/MailWatch-1.2.2/create.sql



MWPASS=`cat /usr/local/src/mailwatch-admin-pass`

echo 'INSERT INTO `mailscanner`.`users` (`username`, `password`, `fullname`, `type`, `quarantine_report`, `spamscore`, `highspamscore`, `noscan`, `quarantine_rcpt`) VALUES ("mailwatch", MD5("$MWPASS"), "Mail Admin", "A", "0", "0", "0", "0", NULL);' | mysql;



echo "MAILTO=\"\"" >> /var/spool/cron/crontabs/root
echo "*/5 * * * * /usr/local/bin/mailwatch-postfix-relay" >> /var/spool/cron/crontabs/root

/etc/init.d/cron restart
/etc/init.d/postfix restart
/etc/init.d/mailscanner restart


