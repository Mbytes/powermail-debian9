
echo "Working on importing nextcloud webmail MySQL database..."

MYSQLPASS=`pwgen -c -1 8`
echo $MYSQLPASS > /usr/local/src/mysql-nextcloud-pass
mysqladmin create nextcloud -uroot
echo "GRANT ALL PRIVILEGES ON nextcloud.* TO nextcloud@localhost IDENTIFIED BY '$MYSQLPASS'" | mysql -uroot
mysqladmin -uroot reload
mysqladmin -uroot refresh

mysql  < files/nextcloud-db.sql


# chekc full apache default ssl config file default-ssl.conf-sample
