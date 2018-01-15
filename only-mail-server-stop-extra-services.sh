#!/bin/sh

/etc/init.d/webmin stop 2>/dev/null ; systemctl disable webmin
/etc/init.d/spampd stop 2>/dev/null ; systemctl disable spampd
/etc/init.d/spamassassin stop 2>/dev/null ; systemctl disable spamassassin
/etc/init.d/clamav-daemon stop 2>/dev/null ; systemctl disable clamav-daemon
/etc/init.d/clamav-freshclam stop 2>/dev/null ; systemctl disable clamav-freshclam
/etc/init.d/memcached stop 2>/dev/null ; systemctl disable memcached
/etc/init.d/redis-server stop 2>/dev/null ; systemctl disable redis-server
/etc/init.d/proftpd stop 2>/dev/null ; systemctl disable proftpd
