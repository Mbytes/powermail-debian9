#!/bin/sh


echo "deb http://repos.groupoffice.eu/ sixtwo main" > /etc/apt/sources.list.d/groupoffice.list

## not accessable /slow most time
#gpg --keyserver pool.sks-keyservers.net --recv-keys 0758838B
#gpg --export --armor 0758838B | sudo apt-key add -

cat files/groupoffice-0758838B-key.txt |  apt-key add -

apt-get update

### issue with key at times ..use unauth
##apt-get -y install groupoffice-com --allow-unauthenticated
apt-get -y install groupoffice-com 

# install only if technomail is not there
##apt-get -y install groupoffice-mailserver

## todo
# replace index.html
# have htmly website.
# have /admin for admin related links,mailscanner/mailwatch & webmin
# Remove lostpassword button
# change password to change powermail domain password
# fix sieve
# fix side blue panel
# support for openfire or ejabberd chat
# fix outlook calandar timezone
# fix auto imap-auth module enable
# fix extra module enable like popup reminder, webdav , export of cal..etc in community.
#fix admin login to groupofficeadmin login with random password
# fix imap-config for  login access
# add email archive page code based on extjs would be great
# add support for caldav & carddave via thirdpart support

