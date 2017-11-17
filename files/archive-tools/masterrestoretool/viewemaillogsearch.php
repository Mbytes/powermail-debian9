<?
//header("Content-Type: text/plain");
//header("Content-Type: text/plain");
//header("Content-Type: text/plain");
//print "Content-type: text/plain\n\n";
$downloadfile="archive.eml";
//header("content-disposition: attachment; filename=$downloadfile");
//header("content-Transfer-Encoding: binary");
//header("Pragma: no-cache");
//header("Expires: 0"); 
include("dbinfo.php");
$tt=1;
$idtemp=$_REQUEST['idte'];

$globalwebmailuser=$_REQUEST['myunweb'];

$toaddress=$globalwebmailuser.'@sampledomain.com';

$mailstorepath=$_REQUEST['mailstorepath'];
$afromaddress=$_REQUEST['afromaddress'];
$atoaddress=$_REQUEST['atoaddress'];
$typeofsend=$_REQUEST['typeofsend'];

$mailstorepath=$_REQUEST['mailstorepath'];
//$fg="SELECT `mailstorepath` FROM emaildetails";
$readserver="http://127.0.0.1/cgi-bin/getmailcontentfirst.cgi?f=";
#$gejsondatareadfile=$readserver.$mailstorepath;
$gejsondatareadfile=$readserver.$mailstorepath."&typeofsend=".$typeofsend."&afromaddress=".$afromaddress."&atoaddress=".$atoaddress."&";

//$gejsondatareadfile=$readserver."/mnt/sda4/mail-store-path/2010-05-10/19-28/30/20100510135758.9345.qmailmint33.monster.co.in1273499952";
$fdrash = fopen($gejsondatareadfile, 'r');
#print "$gejsondatareadfile ";
//print "Sr,Email ID,First Name,Last Name,Department,Location,Mail Quota,Account Locked,Account Locked Date";
//print "\n";
print "<html><head><title>Email</title>";
?>


</head><body>

<?
if($typeofsend!="")
{
#print "<br>Email Sent to ".$toaddress." successfully.</font><br>";
}
?>
<form name="sendx" action="viewemaillogsearch.php" metohd=get>
<input type="hidden" name="afromaddress" value="<?=$toaddress?>">
<input type="hidden" name="atoaddress" value="<?=$toaddress?>">
<input type="hidden" name="idte" value="<?=$idtemp?>">
<input type="hidden" name="typeofsend" value="inject">
<input type="hidden" name="mailstorepath" value="<?=$mailstorepath?>">
<input type="button" name="" value="Click here to Restore Email Back to <?=$toaddress?>" onclick="if(confirm('Are you sure you want to restore the email?')){document.sendx.submit();}return false;">
</form>


<table width=100%><tr><td name=x-panel-body id=x-panel-body style="font-family: Tahoma,Helvetica,Arial,sans-serif;font-style:normal;font-size:14px;">

<?
while(!feof($fdrash))
{
    $outputnsefocoliocm = fgets($fdrash);

#print "\n $outputnsefocoliocm";


if($tt==1)
{
#print "rashmita".$viewtemp;
print $outputnsefocoliocm;
}}
?>
</td></tr></table></body></html>
