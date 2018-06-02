#!/usr/bin/php
<?
//ini_set('error_reporting', E_ALL);
//error_reporting(E_ALL);
//header("Content-Type: text/plain");
//header("Content-Type: text/plain");
//print "Content-type: text/plain\n\n";
$downloadfile="archive.eml";
//header("content-disposition: attachment; filename=$downloadfile");
//header("content-Transfer-Encoding: binary");
//header("Pragma: no-cache");
//header("Expires: 0"); 
//include("dbinfo.php");
$tt=1;
$idtemp=$_REQUEST['idte'];

$mailstorepath=$_REQUEST['f3'];
//$fg="SELECT `mailstorepath` FROM emaildetails";
$readserver="http://127.0.0.1/cgi-bin/getmailcontentdata.cgi?f=";
$fx=$_REQUEST['f'];
$fx3=$_REQUEST['f'];
$fx=str_replace(" ","%20",$fx);
$gejsondatareadfile=$readserver.$fx."&f3=".$mailstorepath;
#print "$gejsondatareadfile";
print "Content-type: application/x-download\n\n";
#$fx=$_REQUEST['f'];
#$fx=$_REQUEST['f'];
#$fx="a.zip";
print "Content-Disposition: attachment; filename=\"".$fx3."\"\n\n";
print "Content-Transfer-Encoding: binary\n";

$fdrash = fopen($gejsondatareadfile, 'r');
while(!feof($fdrash))
{
    $outputnsefocoliocm = fgets($fdrash);
print "$outputnsefocoliocm";


}

#print "aa";


?>
