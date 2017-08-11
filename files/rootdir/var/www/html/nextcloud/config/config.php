<?php
$CONFIG = array (
  'instanceid' => 'ocncwqyc84l2',
  'passwordsalt' => '0jiKfj3TWrNbxbFephbIshuHUhLYKG',
  'secret' => '+xFMeirecPtdJCX58Zd5+buOG3aEognfL6WRDrn+StmAGou6',
  'trusted_domains' => 
  array (
    0 => 'live.technomail.in',
  ),
  'datadirectory' => '/var/www/nextcloud-data',
  'overwrite.cli.url' => 'http://live.technomail.in/nextcloud',
  'dbtype' => 'mysql',
  'version' => '12.0.1.5',
  'dbname' => 'nextcloud',
  'dbhost' => 'localhost',
  'dbport' => '',
  'dbtableprefix' => 'oc_',
  'dbuser' => 'nextcloud',
  'dbpassword' => 'phohTo6x',
  'installed' => true,
  'knowledgebaseenabled' => false,
  'enable_avatars' => true,
  'allow_user_to_change_display_name' => true,
  'filelocking.enabled' => true,
  'memcache.local' => '\\OC\\Memcache\\Redis',
  'memcache.locking' => '\\OC\\Memcache\\Redis',
  'redis' => 
  array (
    'host' => 'localhost',
    'port' => 6379,
  ),
  'mail_smtpmode' => 'smtp',
  'mail_from_address' => 'postmaster',
  'mail_domain' => 'live.technomail.in',
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
  'mail_smtpauthtype' => 'LOGIN',
);
