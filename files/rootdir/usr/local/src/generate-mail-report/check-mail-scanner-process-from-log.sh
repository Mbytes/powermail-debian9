#!/bin/sh

## wait in seconds
echo "Sleeping for few seconds..."
sleep 15

CHECKMIN=5
CHECKHOLD=10;
DATEX=`date +'%b %d %k:%M'`
COUNTX=`cat /var/log/mail.log | grep "MailScanner" | grep "$DATEX" | wc -l`
FILEX=/var/log/mailscannercheck.log

HOLDC=`/bin/pfHandle -s | grep "hold Queue" | sed "s/ //g" | cut -d ":" -f 2`
###HOLDC=30;

echo "Record Count : $COUNTX and Hold : $HOLDC";
#################################################
if [ "$COUNTX" -gt "1" ]; then

echo "Record $DATEX : MailScanner OK"
echo "No Record : $DATEX " >> $FILEX
echo " $COUNTX Record : $DATEX " > $FILEX

fi

#################################################

if [ "$COUNTX" -lt "1" ]; then
    
echo "Record $DATEX : MailScanner Hang"
echo "No Record : $DATEX " >> $FILEX
COUNTY=`cat $FILEX | wc -l`
echo " Checked for COUNT : $COUNTY"

if [ "$COUNTY" -gt "$CHECKMIN" ]; then

echo " Checked for HOLD : $HOLDC"

if [ "$HOLDC" -gt "$CHECKHOLD" ]; then

echo "Restart MailScanner now"
/etc/init.d/mailscanner restart
`/usr/bin/top -c -n 1 > /tmp/toplog.txt`
sendEmail -f postmaster@motilaloswal.com -t support@technoinfotech.com -u "`hostname` auto mailscanner restart with hold : $HOLDC " -m "Auto MailScanner Restarted on server `ifconfig  | grep inet | grep 192 | uniq`  with load of `w` \n " -s 127.0.0.1:25 -o tls=no -a /tmp/toplog.txt

echo " $COUNTX Record : $DATEX " > $FILEX
fi

fi

fi
#################################################



