<?php

$maildate="";
$maildatex="18 Aug 2005 12:20:50 +";
$maildatex="24 Jul 2017 10:11:11 +000";
$maildatey = DateTime::createFromFormat( 'd M Y H:i:s O', $maildatex);
#$maildatey = DateTime::createFromFormat( 'd M Y H:i:s', $maildatex);


echo "xx".gettype($maildatey)."yy\n";

$maildate=$maildatey->format( 'Y_m_d');

print "\n Work & save $maildate  ";


?>
