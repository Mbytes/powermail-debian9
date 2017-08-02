#!/bin/sh

MYSQLPASSVPOP=`pwgen -c -1 8`
echo $MYSQLPASSVPOP > /usr/local/src/mysql-admin-pass




echo "GRANT ALL PRIVILEGES ON *.* TO admin@localhost IDENTIFIED BY '$MYSQLPASSVPOP'" | mysql -uroot
mysqladmin -uroot reload
mysqladmin -uroot refresh

