<?php


$filein="/opt/haraka-inbound/config/host_list";
$fdata=file_get_contents($filein);
$fdata=str_replace("\t","",$fdata);
$fdata=str_replace("\r","",$fdata);
$fdata=str_replace("\0","",$fdata);
$fdata=str_replace(" ","",$fdata);
$fdatax=array();
$fdatax=explode("\n",$fdata);


for($e=0;$e<sizeof($fdatax);$e++)
{
if($fdatax[$e] !="")
{
#print " echo \"------------------------------------------\"\n";
#print "echo \"".$e." - ".$fdatax[$e]."\" \n";
$cmdx="/home/powermail/bin/vadd-backupmx-domain ".$fdatax[$e]."";
print "\n $cmdx";
}
}

print "\n";
?>
