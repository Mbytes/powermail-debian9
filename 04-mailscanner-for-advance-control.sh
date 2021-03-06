#!/bin/sh

#MailScanner Setup

files/rootdir/bin/etc-config-backup.sh

cd files/mailscanner-root/MailScanner-5.0.3-7/
./install.sh
cd ../../../

systemctl disable spampd 

/bin/cp -pRv files/mailscanner-root/header_checks /etc/postfix/header_checks
## disabled amavis f got installed
postconf -e 'content_filter = '
chkconfig --level 345 amavis off 2>/dev/null

/bin/cp -pRv files/mailscanner-root/MailScanner-etc/* /etc/MailScanner/

touch /etc/MailScanner/archives.filetype.rules.conf
touch /etc/MailScanner/archives.filename.rules.conf
touch /etc/MailScanner/filename.rules.conf

mkdir /var/spool/MailScanner/incoming 2>/dev/null
mkdir /var/spool/MailScanner/quarantine 2>/dev/null
mkdir /var/spool/MailScanner/incoming/Locks 2>/dev/null
chown postfix.postfix /var/spool/MailScanner/incoming
chown postfix.postfix /var/spool/MailScanner/quarantine
chown postfix:root /var/spool/postfix/

## so that mailwatch can read
chmod 744 /var/spool/postfix/incoming/
chmod 744 /var/spool/postfix/hold/
chown -R postfix  /var/log/clamav
mkdir /mail-archive-uncompress 2>/dev/null
mkdir /mail-archive-compress 2>/dev/null
mkdir /mail-archive-process 2>/dev/null
chmod 777 /mail-archive-uncompress
chmod 777 /mail-archive-compress
chmod 777 /mail-archive-process



#copy PM files to
#/usr/share/MailScanner/perl/custom
/bin/cp -pR files/mailscanner-root/MailWatch-1.2.2/MailScanner_perl_scripts/* /usr/share/MailScanner/perl/custom/
/bin/cp -pR files/mailscanner-root/MailWatch-1.2.2/mailscanner /var/www/html/
/bin/cp -pR files/mailscanner-root/MailWatch-1.2.2/tools/Postfix_relay/*.php /usr/local/bin/
/bin/cp -pR files/mailscanner-root/MailWatch-1.2.2/tools/Cron_jobs/*.php /usr/local/bin/
/bin/cp -pR files/mailscanner-root/MailWatch-1.2.2/tools/Postfix_relay/mailwatch-postfix-relay /usr/local/bin/
/bin/cp -pR files/mailscanner-root/MailWatch-1.2.2/tools/Cron_jobs/mailwatch /etc/cron.daily/ 
MYSQLPASSMW=`pwgen -c -1 8`
echo $MYSQLPASSMW > /usr/local/src/mailwatch-admin-pass

MYSQLPASSMAILW=`pwgen -c -1 8`
echo $MYSQLPASSMAILW > /usr/local/src/mysql-mailscanner-pass


echo "Creating Database mailscanner for storing all logs for mailwatch"
mysqladmin create mailscanner -uroot 
mysql < files/mailscanner-root/MailWatch-1.2.2/create.sql

echo "GRANT ALL PRIVILEGES ON mailscanner.* TO mailscanner@localhost IDENTIFIED BY '$MYSQLPASSMAILW'" | mysql -uroot
mysqladmin -uroot reload
mysqladmin -uroot refresh

echo "adding user mailwatch with password for gui access , password in /usr/local/src/mailwatch-admin-pass";
echo "INSERT INTO \`mailscanner\`.\`users\` (\`username\`, \`password\`, \`fullname\`, \`type\`, \`quarantine_report\`, \`spamscore\`, \`highspamscore\`, \`noscan\`, \`quarantine_rcpt\`) VALUES ('mailwatch', MD5('$MYSQLPASSMW'), 'Mail Admin', 'A', '0', '0', '0', '0', NULL);"  | mysql;


sed -i "s/zaohm8ahC2/`cat /usr/local/src/mysql-mailscanner-pass`/" /var/www/html/mailscanner/conf.php
sed -i "s/zaohm8ahC2/`cat /usr/local/src/mysql-mailscanner-pass`/" /usr/share/MailScanner/perl/custom/MailWatchConf.pm
sed -i "s/powermail\.mydomainname\.com/`hostname`/" /var/www/html/mailscanner/conf.php
sed -i "s/powermail\.mydomainname\.com/`hostname`/"   /etc/MailScanner/MailScanner.conf


#echo "MAILTO=\"\"" >> /var/spool/cron/crontabs/root
echo "*/5 * * * * /usr/local/bin/mailwatch-postfix-relay" >> /var/spool/cron/crontabs/root
## add Archive Part
echo "#*/3 * * * * /usr/local/src/mailarchive-scripts/fetch-and-convert.sh" >> /var/spool/cron/crontabs/root
echo "* * * * * /usr/local/src/mailarchive-scripts/add-email-from-stage2-to-final-index.sh" >> /var/spool/cron/crontabs/root
echo "#*/5 * * * * /usr/local/src/check-mail-scanner-process-from-log.sh" >> /var/spool/cron/crontabs/root
echo "#1 6 * * * /usr/local/src/generate-mail-report/send-report-with-csv.sh" >> /var/spool/cron/crontabs/root

/etc/init.d/cron restart
/etc/init.d/postfix restart
/etc/init.d/mailscanner restart
/etc/init.d/clamav-daemon restart


sendEmail -f postmaster@`hostname`  -t postmaster@`hostname` -u "Test Mail after MailScanner" -m "Test Mail after MailScanner" -o tls=no -s 127.0.0.1:25
