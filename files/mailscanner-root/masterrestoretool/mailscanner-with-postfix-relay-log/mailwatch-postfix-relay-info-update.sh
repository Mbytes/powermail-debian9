#!/bin/sh

BASEDIR=$(dirname $0)
echo $BASEDIR
cd $BASEDIR

if [ -f '/tmp/read-mailscanner-with-postfix-relay-log.pid' ];
then
   echo "File /tmp/read-mailscanner-with-postfix-relay-log.pid exists"
else

touch /tmp/read-mailscanner-with-postfix-relay-log.pid
date


/usr/bin/php -q /usr/local/src/mailscanner-with-postfix-relay-log/mailwatch_postfix_relay.php --refresh

/usr/bin/php -q /usr/local/src/mailscanner-with-postfix-relay-log/mailwatch_mailscanner_relay.php --refresh

date
/bin/rm -rf /tmp/read-mailscanner-with-postfix-relay-log.pid

fi


