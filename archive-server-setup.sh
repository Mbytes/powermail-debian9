#!/bin/sh

# remove package if not on mail-server as archive does not need this.
#apt-get remove spamassassin clamd  clamav-base  clamav-daemon  clamav-docs  clamav-freshclam  clamav-unofficial-sigs  clamdscan  redis-server  bind9 unbound
#apt-get remove webmin
#apt-get autoremove

apt-get install recoll xapian-tools libpst4 antiword wv
