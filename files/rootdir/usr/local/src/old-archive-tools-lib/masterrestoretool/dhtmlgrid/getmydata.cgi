#!/usr/bin/perl


$myhostname="127.0.0.1";
$mydatabase="sugarcrm";
$myusername="root";
$mypassword="gsm2k3k";
$strRequest = "<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>";
    $strRequest = $strRequest . "<REQUEST><HOSTNAME>$myhostname</HOSTNAME><DATABASE>$mydatabase</DATABASE><USER>$myusername</USER>";
    $strRequest = $strRequest . "<PASSWORD>$mypassword</PASSWORD>";
    $strRequest = $strRequest . "</REQUEST>";

print "<a href=\"172.16.100.254/cgi-bin/dhtmlgrid/getdatafull.cgi?data=$strRequest\">get data</a>";
