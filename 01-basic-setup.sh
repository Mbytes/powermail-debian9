#!/bin/bash

apt-get update
#apt-get upgrade

#CFG_HOSTNAME_FQDN = `hostname`

#echo "postfix postfix/main_mailer_type select Internet Site" | debconf-set-selections
#echo "postfix postfix/mailname string $CFG_HOSTNAME_FQDN" | debconf-set-selections

apt-get -y install vim openssh-server net-tools pwgen dialog dialog postfix xfsprogs clamav clamav-base clamav-daemon clamav-freshclam clamdscan clamav-unofficial-sigs  spamassassin  spampd  spamc  sa-compile build-essential iptraf  mariadb-server build-essential bridge-utils mc screen elinks git curl wget telnet iputils-ping sudo bind9 debconf-utils pwgen software-properties-common postfix-mysql dovecot-mysql dovecot-sieve dovecot-managesieved php-imap phpmyadmin php-mcrypt mcrypt dovecot-imapd dovecot-pop3d dovecot-sieve dovecot-antispam sendemail fail2ban libwbxml2-utils openssl pyzor razor rsync mailutils  p7zip-full elfutils p7zip-rar autoconf whiptail automake proftpd-basic postfix-pcre whois opendkim opendkim-tools libemail-valid-perl libmail-sendmail-perl libmime-charset-perl libmime-encwords-perl libnet-domain-tld-perl libserf-1-1 libsvn1 subversion tnef zip apache2 unbound certbot acmetool apt-transport-https libssl-dev pflogsumm dirmngr php-mail mysqltuner dnsutils  zoo unzip bzip2 arj nomarch lzop cabextract apt-listchanges libnet-ldap-perl libauthen-sasl-perl clamav-docs daemon libio-string-perl libio-socket-ssl-perl libnet-ident-perl zip libnet-dns-perl systemd unrar-free p7zip rpm2cpio tnef libtool flex bison debhelper  mariadb-client quota quotatool wamerican apache2-doc  libapache2-mod-php libapache2-mod-fcgid apache2-suexec-pristine  php-memcache php-imagick php-gettext php7.0 php7.0-common php7.0-gd php7.0-mysql php7.0-imap php7.0-cli php7.0-cgi php-pear php7.0-mcrypt php7.0-curl php7.0-intl php7.0-pspell php7.0-recode php7.0-sqlite3 php7.0-tidy php7.0-xmlrpc php7.0-xsl php7.0-zip php7.0-mbstring php7.0-imap php7.0-mcrypt php7.0-snmp php7.0-xmlrpc php7.0-xsl dos2unix   automysqlbackup  ethtool lftp ncftp chkrootkit  unrtf catdvi libfann2  altermime libberkeleydb-perl libconvert-binhex-perl libconvert-tnef-perl libconvert-uulib-perl libio-stringy-perl libmime-tools-perl libnet-cidr-lite-perl libnet-libidn-perl  libnet-patricia-perl libunix-syslog-perl pax ripole libauthen-pam-perl  libio-pty-perl apt-show-versions libapt-pkg-perl imagemagick memcached  tidy php-apcu libclass-dbi-mysql-perl ca-certificates catdoc exiv2 libexiv2-14 libgif7 liblept5 libtesseract-data libtesseract3 poppler-utils tesseract-ocr tesseract-ocr-eng tesseract-ocr-equ tesseract-ocr-osd spf-tools-perl  libmail-srs-perl  libmail-spf-xs-perl libencode-zapcp1252-perl bc lynx swaks redis-server libdigest-sha3-perl libencode-detect-perl libgeo-ip-perl lhasa libsnmp-perl  rpm unrar pyzor-doc php-mailparse 


a2enmod actions > /dev/null 2>&1 
a2enmod proxy_fcgi > /dev/null 2>&1 
a2enmod alias > /dev/null 2>&1 


a2enmod suexec > /dev/null 2>&1
a2enmod rewrite > /dev/null 2>&1
a2enmod ssl > /dev/null 2>&1
a2enmod actions > /dev/null 2>&1
a2enmod include > /dev/null 2>&1
a2enmod dav_fs > /dev/null 2>&1
a2enmod dav > /dev/null 2>&1
a2enmod auth_digest > /dev/null 2>&1
a2enmod fcgid > /dev/null 2>&1
a2enmod cgi > /dev/null 2>&1
a2enmod headers > /dev/null 2>&1
#a2enmod fastcgi > /dev/null 2>&1
	

# ngnix is install for imap/smrp load balance if needed
/etc/init.d/apache2  stop
#apt-get -y install nginx-full php-fpm

#Disable vim automatic visual mode using mouse
echo "\"set mouse=a/g" >  ~/.vimrc

