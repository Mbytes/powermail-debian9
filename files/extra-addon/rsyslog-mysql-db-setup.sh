#!/bin/sh

### to copy all syslog into Database for processing & web interface
GENERATED_PASS=`pwgen -c -1 10`

echo "rsyslog-mysql     rsyslog-mysql/dbconfig-install  boolean true" | debconf-set-selections
echo "rsyslog-mysql rsyslog-mysql/mysql/admin-pass password $MYSQL_ROOT_PASS" | debconf-set-selections
echo "rsyslog-mysql rsyslog-mysql/mysql/app-pass password $GENERATED_PASS" |debconf-set-selections
echo "rsyslog-mysql rsyslog-mysql/password-confirm password $GENERATED_PASS" |debconf-set-selections
echo "rsyslog-mysql rsyslog-mysql/app-password-confirm password $GENERATED_PASS" |debconf-set-selections
#echo "rsyslog-mysql   rsyslog-mysql/install-error     select  ignore" |debconf-set-selections

# Disabled for installation , only if syslog is needed in database to be used
apt-get install rsyslog-mysql

