<?php

#session_name('groupoffice');
#session_start();

#print " aaa ".$_SESSION['GO_SESSION']['username'];
#$globalwebmailuser=$_SESSION['GO_SESSION']['username'];

$globalwebmailuser=$_REQUEST['myunweb'];
$globaldomain="sampledomain.com";
if($globalwebmailuser=="fullbackup")
{
#$globalwebmailuser="pankajp";
}

#print "-> $globalwebmailuser";
if($globalwebmailuser=="")
{
#exit;
}




include("dbinfo.php");
$globaldomain="sampledomain.com";
$rdd="";
$enterdate=$_REQUEST['enterdate'];
$selectdateelsto=$_REQUEST['selectdateelsto'];
$emaillogsearchcomb=$_REQUEST['emaillogsearchcomb'];
$emaillogsusername=$_REQUEST['emaillogsusername'];
$gnelsaddsubject=$_REQUEST['gnelsaddsubject'];
//$globalwebmailuserre=$_REQUEST['globalwebmailuser'];
#$globalwebmailuserre=$globalwebmailuser;
$globalwebmailuserre=$globalwebmailuser."@".$globaldomain;



#print $globaldomain;
$start = (integer) (isset($_POST['start']) ? $_POST['start'] : $_GET['start']);
$end = (integer) (isset($_POST['limit']) ? $_POST['limit'] : $_GET['limit']);

$filter = $_REQUEST["filter"];
$sort=$_REQUEST['sort'];
$rr=$rr.">>>".$sort;
$dir=$_REQUEST["dir"];
$filtersql="";
if(count($filter)>0)
{
$rr=$rr."FITLERSTART\n";
for($a=0;$a<count($filter);$a++)
{
$xfield=$filter[$a]['field'];
$xtype=$filter[$a]['data']['type'];
$xvalue=$filter[$a]['data']['value'];
$xcomparison=$filter[$a]['data']['comparison'];
$scell=$xfield;
$sqlf1="";
$sqlf2="";
if($xcomparison=="gt"){$xcomparison=">";}
if($xcomparison=="lt"){$xcomparison="<";}
if($xcomparison=="gte"){$xcomparison=">=";}
if($xcomparison=="lte"){$xcomparison="<=";}
if($xcomparison=="eq"){$xcomparison="=";}
if($xcomparison=="" && $xtype=="string"){$xcomparison="like";}
if($xcomparison==""){$xcomparison="=";}
if($xcomparison=="neq"){$xcomparison="!=";}
if($xcomparison=="like"){$xcomparison="LIKE"; $sqlf1="%";$sqlf2="%";}
if($xcomparison=="in"){$xcomparison="IN";}
if($xcomparison=="notin"){$xcomparison="NOT IN";}
$filtersql=$filtersql." and `".$scell."` ".$xcomparison." '".$sqlf1.$xvalue.$sqlf2."' ";
$rr=$rr."-->".$filtersql;
#$stringDatau=$stringDatau."\n".$a."-".$xfield."--".$xtype."--".$xvalue."---".$xcomparison."---$filtersql\n";
}
#$stringDatau=$stringDatau.$filtersql;
}

#$filtersql="";

$orderbyx="";
#$rr=$rr."  \n sort1 $sort $dir      ";
if($sort != "" && $dir != "")
{
$scell=$sort;
$orderbyx="order by `".$scell."` $dir ";

$rr=$rr.$sort.">>>".$dir;

}



if($orderbyx =="")
{
//$orderbyx="  ORDER BY `emailid` DESC";
}


$rt1="%";
$rt2="%";
$sqlwhere="";
if($emaillogsearchcomb == "From Email" && $emaillogsusername != ""){
$sqlwhere="AND emailfrom='".$emaillogsusername."' and  emailto='".$globalwebmailuserre."'";
}
if($emaillogsearchcomb == "To Email" && $emaillogsusername != ""){
$sqlwhere="AND emailfrom='".$globalwebmailuserre."' and emailto='".$emaillogsusername."'";
}
if($emaillogsearchcomb == "From Domain" && $emaillogsusername != "" ){
$sqlwhere="AND emailfromdomain='".$emaillogsusername."' and  emailto='".$globalwebmailuserre."'";
}
if($emaillogsearchcomb == "To Domain" && $emaillogsusername != "" ){
$sqlwhere="AND emailtodomain='".$emaillogsusername."' AND emailfrom='".$globalwebmailuserre."' ";
}

if($emaillogsusername == ""){
$sqlwhere="AND ( emailfrom='".$globalwebmailuserre."' or emailto='".$globalwebmailuserre."'  )";
}

if($gnelsaddsubject != "" ){
$sqlwheresub="AND subject LIKE '".$rt1.$gnelsaddsubject.$rt2."'"; 
}

$defaultdatest=" AND `emaildate` >= '".$enterdate."'";
$defaultdateend=" AND `emaildate` <= '".$selectdateelsto."'";


$getsql="show tables";
$rbb=0;
$rsg1 = mysql_query($getsql) ;
$sqlniadeli="";
while($tech1=mysql_fetch_array($rsg1))
{
#print "--> ".$tech1[0];
if($rbb!=0)
{
$sqlniadeli=$sqlniadeli." union ";
}
$rbb++;
$sqlniadeli= $sqlniadeli."SELECT `id`, `adddatetime`, `adddate`, `emaildatetime`, `emaildate`, `emailfrom`, `emailfromdomain`, `emailfromfull`, `emailto`, `emailtodomain`, `emailtofull`, `subject`, `attachment01`, `attachment02`, `attachment03`, `attachment04`, `attachment05`, `attachment06`, `attachment07`, `attachment08`, `attachment09`, `attachment10`, `mailsize` , `mailstorepath` FROM `".$tech1[0]."` where 1 ".$defaultdatest." ".$defaultdateend." ".$sqlwhere." ".$sqlwheresub." ".$filtersql."  ";
}

$sqlniadeli=$sqlniadeli."  ".$orderbyx." ";



$sqlndeli=$sqlniadeli." LIMIT ".$start.",".$end."";

#print "-- $sqlndeli";
#exit;



#$myFile = "testFile.txt";
#$fh = fopen($myFile, 'w') or die("can't open file");
#$stringData="\n  $sqlndeli  \n $dx   \n";
#fwrite($fh, $stringData);
#fclose($fh);
#exit;


$rs_countg = mysql_query($sqlniadeli) or die(mysql_error());
$domainrows = mysql_num_rows($rs_countg);
$rsg = mysql_query($sqlndeli) or die(mysql_error());
$rdd=$rdd.$sqlndeli;
#print $sqlndeli;
$prows = mysql_num_rows($rsg);


$dx=mysql_error();

#$myFile = "testFile.txt";
#$fh = fopen($myFile, 'w') or die("can't open file");
#$stringData="\n  $sqlndeli  \n $dx   \n";
#fwrite($fh, $stringData);
#fclose($fh);


$jsid=0;

print "{\"meta\":{\"code\":1,\"exception\":[],\"success\":true,\"message\":null},\"data\":{\"totalels\":".$domainrows.",\"resultsels\":[";

while($techdomainarray=mysql_fetch_array($rsg))
{
$jsid++;
$techid=$techdomainarray[0];
$techid=$jsid;
$adddatetime=$techdomainarray[1];
$adddate=$techdomainarray[2];
$emaildatetime=$techdomainarray[3];
$emaildate=$techdomainarray[4];
$emailfrom=$techdomainarray[5];
$emailfromdomain=$techdomainarray[6];
$emailfromfull =$techdomainarray[7];
$emailto=$techdomainarray[8];
$emailtodomain=$techdomainarray[9];
$emailtofull=$techdomainarray[10];
$subject=$techdomainarray[11];
$subject=str_replace("\n","",$subject);
$subject=str_replace("\t","",$subject);
$subject=str_replace("\r","",$subject);
$subject=str_replace('"',"",$subject);
$subject=str_replace('\0',"",$subject);
$attachment01=$techdomainarray[12];
$attachment01=str_replace("\n","",$attachment01);
$attachment01=str_replace("\t","",$attachment01);
$attachment01=str_replace("\r","",$attachment01);
$attachment01=str_replace('"',"",$attachment01);
$attachment01=str_replace('\0',"",$attachment01);

$attachment02=$techdomainarray[13];
$attachment02=str_replace("\n","",$attachment02);
$attachment02=str_replace("\t","",$attachment02);
$attachment02=str_replace("\r","",$attachment02);
$attachment02=str_replace('"',"",$attachment02);


$attachment03=$techdomainarray[14];
$attachment04=$techdomainarray[15];
$attachment05=$techdomainarray[16];
$attachment06=$techdomainarray[17];
$attachment07=$techdomainarray[18];
$attachment08=$techdomainarray[19];
$attachment09=$techdomainarray[20];
$attachment10=$techdomainarray[21];
$mailsize=$techdomainarray[22];
$mailstorepath=$techdomainarray[23];

print "{";
#print "\"checkdomac\":\"".$tr."\",";
print "\"id\":\"".$techid."\",";
print "\"adddatetime\":\"".$adddatetime."\",";
#print "\"adddate\":\"".$adddate."\",";
print "\"emaildatetime\":\"".$emaildatetime."\",";
#print "\"emaildate\":\"".$emaildate."\",";
print "\"emailfrom\":\"".$emailfrom."\",";
#print "\"emailfromdomain\":\"".$emailfromdomain."\",";
#print "\"emailfromfull\":\"".$emailfromfull."\",";
print "\"emailto\":\"".$emailto."\",";
#print "\"emailtodomain\":\"".$emailtodomain."\",";
#print "\"emailtofull\":\"".$emailtofull."\",";
print "\"subject\":\"".$subject."\",";
print "\"attachment01\":\"".$attachment01."\",";
print "\"attachment02\":\"".$attachment02."\",";
print "\"attachment03\":\"".$attachment03."\",";
print "\"attachment04\":\"".$attachment04."\",";
print "\"attachment05\":\"".$attachment05."\",";
print "\"attachment06\":\"".$attachment06."\",";
print "\"attachment07\":\"".$attachment07."\",";
print "\"attachment08\":\"".$attachment08."\",";
print "\"attachment09\":\"".$attachment09."\",";
print "\"attachment10\":\"".$attachment10."\",";
print "\"mailstorepath\":\"".$mailstorepath."\",";
print "\"mailsize\":\"".$mailsize."\"";
print "}";

if($prows != $jsid){print ",";}



}

print "]}}";

#$myFile = "deemaillog.log";
#$fh = fopen($myFile, 'w') or die("can't open file");
#fwrite($fh,$rdd);
#fclose($fh);



?>
