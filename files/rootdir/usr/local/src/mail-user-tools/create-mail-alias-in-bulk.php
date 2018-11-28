<?php

## file should have alias-email-address|to-email-address-with-comma-seprate
$filedata=file_get_contents('mail-alias-list.csv');

$fileline=explode("\n",$filedata);

for($i=0;$i<sizeof($fileline);$i++)
{
if($fileline[$i]!="")
{
#print "\n --> $i --> ".$fileline[$i];
$ux=array();
$ux=explode("|",$fileline[$i]);
## for powermail
$cmdx="/home/powermail/bin/vaddalias ".$ux[0]." ".$ux[0]."";

## for qmail
#$cmdx="/home/vpopmail/bin/valias -i ".$ux[0]." ".$ux[0]."";

print "$cmdx";
print "\n";
}
}

print "\n";


?>
