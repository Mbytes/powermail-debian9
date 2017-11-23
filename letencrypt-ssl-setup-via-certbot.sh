#!/bin/sh


/etc/init.d/apache2 stop
##certbot certonly -d `hostname` --standalone --agree-tos --email yourmail@example.com
certbot certonly -d `hostname` --standalone --agree-tos 


echo "MAILTO=\"\"" >> /var/spool/cron/crontabs/root 
echo "30 2 * * 1 /usr/bin/certbot renew  >> /var/log/letsencrypt-renew.log" >> /var/spool/cron/crontabs/root 

/etc/init.d/cron restart

echo "manually update SSL in apache2,postfix,dovecot,haraka"
echo "";


