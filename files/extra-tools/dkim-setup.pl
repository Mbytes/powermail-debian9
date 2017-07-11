#!/usr/bin/perl

$newdomain='hricosmetics.com';

$cmdx="mkdir /etc/opendkim/keys/".$newdomain."";
`$cmdx`;
$cmdx="cd /etc/opendkim/keys/".$newdomain." ; opendkim-genkey --domain=".$newdomain." --selector=mail";
`$cmdx`;
$cmdx="echo \"mail._domainkey.".$newdomain." ".$newdomain.":default:/etc/opendkim/keys/".$newdomain."/mail.private\"  >>/etc/opendkim/KeyTable";
`$cmdx`;
$cmdx="echo \"".$newdomain." mail._domainkey.".$newdomain."\" >> /etc/opendkim/SigningTable";
`$cmdx`;
$cmdx="chmod -R 644 /etc/opendkim/keys; chown -R opendkim:opendkim /etc/opendkim/keys;chmod -R 700 /etc/opendkim/keys";
`$cmdx`;

