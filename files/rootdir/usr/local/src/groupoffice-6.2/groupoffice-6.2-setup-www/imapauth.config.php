<?php
/**
 * For more information visit: http://wiki4.group-office.com/wiki/IMAP_or_LDAP_authentication
 */

$config[] =
	array(
	'proto' => 'imap',
	'domains' => '*',
	'host' => 'localhost',
	'port' => '143',
	'ssl' => false,
	'tls' => false,
	'novalidate_cert' => false,
	'mbroot' => '',//you might have to change this to INBOX
	'remove_domain_from_username' => false,
	'create_email_account' => true,
	'groups' => array('Internal'),
			
	'store_password'=>true, //By default the passwords are stored using two way encryption in the database. The encryption key is stored on disk and not in the database. You can disable this and not store the password at all but just keep it in the session. The downside is that email accounts can't be shared when you don't store passwords.

	'smtp_host'=>'localhost',
	'smtp_port'=>'25',
	'smtp_encryption'=>'',
	'smtp_username'=>'',
	'smtp_password'=>'',

//	'imapauth_combo_domains' => 'mydomainname.com,powermail.mydomainname.com',
//	'imapauth_default_domain' => 'mydomainname.com',

	'smtp_use_login_credentials'=>true, //set to true to use the login username and password for SMTP authentication too.

	'ldap_use_email_as_imap_username'=>false
	);


//$config[] =
//	array(
//	'proto' => 'imap',
//	'domains' => 'example.com', //for different imap servers you can define them with the explicit domain name
//	'host' => 'localhost',
//	'port' => '143',
//	'ssl' => false,
//	'novalidate_cert' => false,
//	'mbroot' => '',//you might have to change this to INBOX
//	'remove_domain_from_username' => false,
//	'create_email_account' => true,
//	'groups' => array('Internal'),
//
//	'smtp_host'=>'localhost',
//	'smtp_port'=>'25',
//	'smtp_encryption'=>'',
//	'smtp_username'=>'',
//	'smtp_password'=>'',
//	'smtp_use_login_credentials'=>false, //set to true to use the login username and password for SMTP authentication too.
//
//	'ldap_use_email_as_imap_username'=>false,
//	'imapauth_combo_domains' => 'example.com,example2.com',
//	'imapauth_default_domain' => 'example.com'
//	);
?>
