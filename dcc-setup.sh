#!/bin/sh

#DCC (Distributed Checksum Clearing Houses) binaries, Regrettably no debian package is available so we will compile it and install it from source:
#http://www.pc-freak.net/blog/add-dcc-distributed-checksum-clearing-houses-pyzor-and-razon-checks-in-spamassassin-on-debian-lenny-howto-improve-spamassassin-anti-spam-protection-on-debian-gnu-linux/

cd /tmp ; wget -c https://www.dcc-servers.net/dcc/source/dcc.tar.Z ; 
tar -xvzf dcc.tar.Z
cd -
cd /tmp/dcc-*
./configure
make
make install


cd -

cdcc info > /var/dcc/map.txt
chmod 0600 /var/dcc/map.txt
/bin/rm -rf /var/dcc/map
cdcc "new map; load /var/dcc/map.txt"
cdcc "delete 127.0.0.1"

sed -i "s/#loadplugin Mail\:\:SpamAssassin\:\:Plugin\:\:DCC/loadplugin Mail\:\:SpamAssassin\:\:Plugin\:\:DCC/" /etc/spamassassin/v310.pre
/etc/init.d/spamassassin restart


spamassassin -t -D dcc < /usr/share/doc/spamassassin/examples/sample-spam.txt   2>/tmp/spam-sample-report.txt 1>&2

