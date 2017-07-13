#!/bin/sh

perl makelocalcf-auto-body-filter.pl
perl makelocalcf-auto-header-filter.pl
echo running spamassassin lint
spamassassin --lint
echo restarting spamd service
/etc/init.d/spamassassin restart
