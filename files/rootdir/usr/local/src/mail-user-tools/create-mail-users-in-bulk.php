<?php

## file should have user-email-address,email-password per line

$filedata=file_get_contents('newuser.csv');

$fileline=explode("\n",$filedata);

for($i=0;$i<sizeof($fileline);$i++)
{
if($fileline[$i]!="")
{
#print "\n --> $i --> ".$fileline[$i];
$ux=array();
$ux=explode(",",$fileline[$i]);
$cmdx="/home/powermail/bin/vadduser ".$ux[0]." \"".$ux[1]."\"" ;

print "$cmdx";
print "\n";
}
}

print "\n";
?>

