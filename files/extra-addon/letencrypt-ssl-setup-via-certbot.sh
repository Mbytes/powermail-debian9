#!/bin/sh


/etc/init.d/apache2 stop
##certbot certonly -d `hostname` --standalone --agree-tos --email yourmail@example.com
certbot certonly -d `hostname` --standalone --agree-tos 

cat /etc/letsencrypt/live/`hostname`/{cert,chain,fullchain,privkey}.pem >/etc/webmin/miniserv.pem
sed -i "s/powermail\.mydomainname\.com/`hostname`/" /usr/local/src/cert-renew-and-restart.sh

#echo "MAILTO=\"\"" >> /var/spool/cron/crontabs/root 
echo "30 2 * * 1 /usr/local/src/cert-renew-and-restart.sh" >> /var/spool/cron/crontabs/root 

/etc/init.d/cron restart

echo "manually update SSL in apache2,postfix,dovecot,haraka"
echo "";


