<?php

## should be without trailing /   (no slash)

$storagepath="/mnt/4tbbackup/technoarchive";

###$boxtype =1 means monthwise (2016_03)and boxtype =0 means datewise (2016_03_20)

$boxtype=1;

$path = $argv[1];
$path=str_replace("\n","",$path);
$path=str_replace("\t","",$path);
$path=str_replace("\r","",$path);
$path=str_replace("\0","",$path);

echo mime_content_type($path);
print "\n";
$ex=array();
$ex =explode(".",$path);
$gotgzip=0;
if(mime_content_type($path) =="application/x-gzip"){$gotgzip=1;}
if($ex[1] == "gz") {$gotgzip=1;}



if($gotgzip==1)
{
$cmdx ="gzip -d ".$path;
`$cmdx`;
$path=str_replace(".gz","",$path);
}
print "\nReading : $path \n";
require_once '/etc/php5/vendor/autoload.php';
$Parser = new PhpMimeMailParser\Parser();
$Parser->setPath($path);

#echo $Parser->getRawHeader('diagnostic-code');

$to = $Parser->getHeader('to');
$from = $Parser->getHeader('from');
$subject = $Parser->getHeader('subject');
$maildatex = $Parser->getHeader('date');
$maildatex = str_replace("  "," ",$maildatex);
$maildatex = str_replace("GMT"," ",$maildatex);
print "\n DATEX: ->".$maildatex."<-";
$maildatey = DateTime::createFromFormat( 'D, d M Y H:i:s O', $maildatex);
if(gettype($maildatey)=='boolean'){$maildatey = DateTime::createFromFormat( 'd M Y H:i:s O', $maildatex);}
if(gettype($maildatey)=='boolean'){$maildatey = DateTime::createFromFormat( 'D d M Y H:i:s O', $maildatex);}

if(gettype($maildatey)=='boolean'){
$dx=array();
$dx=explode("-",$maildatex);
$maildatex=$dx[0];
$dx=array();
$dx=explode(",",$maildatex);
$maildatex=$dx[1];
print "\n DATEX: ->".$maildatex."<-";
$maildatey = DateTime::createFromFormat( ' d M Y H:i:s ', $maildatex);

}



if(gettype($maildatey)=='boolean'){
$dx=array();
$dx=explode("+",$maildatex);
$maildatex=$dx[0];
$dx=array();
$dx=explode(",",$maildatex);
$maildatex=$dx[1];
print "\n DATEX: ->".$maildatex."<-";
$maildatey = DateTime::createFromFormat( ' d M Y H:i:s ', $maildatex);

}

if(gettype($maildatey)=='boolean'){
$rheader = $Parser->getHeader('received');
print "\n --> $rheader \n";
$dx=array();
$dx=explode("; ",$rheader);
$maildatex=$dx[1];
$dx=array();
$dx=explode(" -",$maildatex);
$maildatex=$dx[0];

print "\n DATEX RECV: ->".$maildatex."<-";
$maildatey = DateTime::createFromFormat( 'd M Y H:i:s', $maildatex);

}
///////////////////////////////////////

$maildate=$maildatey->format( 'Y_m_d');
$mailmon=$maildatey->format( 'Y_m');

echo gettype($maildatey), "\n";
if(gettype($maildatey)=='boolean'){$maildate=date('Y_m_d'); $mailmon=date('Y_m');}
$mailfolder=$maildate;
if($boxtype==1){$mailfolder=$mailmon;}
print "\n  $maildate --> $mailfolder";

$indexbox=$storagepath."/".$mailfolder."/indexdata";
$mainbox=$storagepath."/".$mailfolder."/maindata/".date(hi);

if(!is_dir($indexbox))
{
echo "\n Creating index folder and config file\n";
mkdir($indexbox, 0777, true);
mkdir($mainbox, 0777, true);
$configfile=$indexbox."/recoll.conf";
$topline="topdirs = ".$mainbox."\n";
file_put_contents($configfile, $topline);

}
// wait for 2 seconds
//usleep(2000000);
usleep(2);

$mtime=microtime(true);
$newfile=$mainbox."/".$mtime;
$mcmdx="mv \"".$path."\" \"".$newfile."\" ; gzip -9v \"".$newfile."\" ";
print "\n $mcmdx ";
`$mcmdx`;
$addcmdx="recollindex -c ".$indexbox."/ -i ".$newfile.".gz";
print "\n $addcmdx ";
`$addcmdx`;

$searchline="recollq -n 2  -c  ".$indexbox."/ -q \"$to\"";
print "\n$searchline\n";

print "\n";

?>
