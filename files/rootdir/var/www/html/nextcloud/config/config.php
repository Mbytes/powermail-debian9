<?php
$CONFIG = array (
  'instanceid' => 'oc1tcv5zvhcu',
  'passwordsalt' => 'zF6DLOIuX/uO8yPJQpPlxuBUyCB62L',
  'secret' => 'DVel5QhM1GiJVqLpVNB0VDNsQ2ib7ctAXWJZDzHgflKErFoT',
  'trusted_domains' => 
  array (
    0 => 'live.technomail.in',
  ),
/* 'defaultapp' => 'rainloop', */
'knowledgebaseenabled' => false,
'enable_avatars' => true,
'allow_user_to_change_display_name' => true,


'filelocking.enabled' => true,
'memcache.local' => '\OC\Memcache\Redis',
'memcache.locking' => '\OC\Memcache\Redis',
'redis' => array(
     'host' => 'localhost',
     'port' => 6379,
      ),

  'mail_smtpmode' => 'smtp',
  'mail_from_address' => 'postmaster',
  'mail_domain' => 'powermail.mydomainname.com',
  'mail_smtphost' => '127.0.0.1',
  'mail_smtpport' => '2525',
  'user_backends' =>
  array (
    0 =>
    array (
      'class' => 'OC_User_IMAP',
      'arguments' =>
      array (
        0 => '{localhost:143/imap/novalidate-cert}',
      ),
    ),
  ),
'maintenance' => false,

  'datadirectory' => '/var/www/html/nextcloud/data',
  'overwrite.cli.url' => 'http://live.technomail.in/nextcloud',
  'dbtype' => 'mysql',
  'version' => '12.0.1.5',
  'dbname' => 'nextcloud',
  'dbhost' => 'localhost',
  'dbport' => '',
  'dbtableprefix' => 'oc_',
  'dbuser' => 'nextcloud',
  'dbpassword' => 'cae0ohGh',
  'installed' => true,
  'integrity.check.disabled' => true,
  'mail_from_address' => 'postmaster',
  'mail_smtpmode' => 'php',
  'mail_smtpauthtype' => 'LOGIN',
  'mail_domain' => 'powermail.mydomainname.com',
);
