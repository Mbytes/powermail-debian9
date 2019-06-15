#!/bin/sh

echo > /etc/apt/sources.list.d/nodesource.list

echo "deb https://deb.nodesource.com/node_6.x stretch main" >> /etc/apt/sources.list.d/nodesource.list
echo "deb-src https://deb.nodesource.com/node_6.x stretch main" >> /etc/apt/sources.list.d/nodesource.list

curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -

touch /var/log/haraka-inbound.log
chown vmail:vmail /var/log/haraka-inbound.log
chmod 666 /var/log/haraka-inbound.log

mkdir /var/spool/haraka-inbound
chown vmail:vmail /var/spool/haraka-inbound


apt-get update

apt-get install -y nodejs

npm install -g Haraka
npm install -g haraka-plugin-syslog
npm install -g iconv
npm install -g mailparser
npm install -g mailin
## for dev of modules
npm install -g eslint

npm install -g haraka-plugin-asn
npm install -g maxmind-geolite-mirror
npm install -g tmp
npm install -g haraka-plugin-outbound-rate-limit
npm install -g haraka-plugin-limit
npm install -g haraka-plugin-fcrdns
npm install -g address-rfc2822
npm install -g haraka-plugin-attachment
npm install -g nodemailer
npm install -g haraka-plugin-fcrdns
##npm install -g haraka-plugin-graph

/bin/cp -pR ../files/haraka-inbound /opt/

sed -i "s/powermail\.mydomainname\.com/`hostname`/" /opt/haraka-inbound/config/host_list
sed -i "s/powermail\.mydomainname\.com/`hostname`/" /opt/haraka-inbound/config/tls.ini

/etc/init.d/postfix stop
echo "make postfix local only as haraka check for port 25"
postconf -e 'inet_interfaces = loopback-only';
sed -i "s/smtp      inet  n       \-       y       \-       \-       smtpd/2525      inet  n       \-       y       \-       \-       smtpd/" /etc/postfix/master.cf
hostname > /opt/haraka-inbound/config/me

mkdir -p /usr/local/share/GeoIP

echo "Downloading GeoIP database ..can take few minutes..please wait.."
/usr/bin/maxmind-geolite-mirror

/bin/cp -pRv /usr/lib/node_modules/Haraka/contrib/Haraka.cf /etc/mail/spamassassin/
/bin/cp -pRv /usr/lib/node_modules/Haraka/contrib/Haraka.pm /etc/mail/spamassassin/


echo "All Done\n";



