#!/usr/bin/php
<?php
print "Content-type: text/html\n\n";
include_once("dbinfo.php");
#include_once("../userauth.php");
$f=0;
$rash="";
//$rowsa=50;

$rp="";
$start = (integer) (isset($_POST['start']) ? $_POST['start'] : $_GET['start']);
$end = (integer) (isset($_POST['limit']) ? $_POST['limit'] : $_GET['limit']);
//$vpopmaildomain=$_REQUEST['vpopmaildomain'];
$startdate=$_POST['startDate'];
$enddate=$_POST['endDate'];
if($startdate=="")
{
$startdate="2010-05-20";
}

/////////////

$sort=$_POST["sort"];
$rp=$rp.">>>".$sort;
$dir=$_POST["dir"];
$rp=$rp.">>>".$dir;


$filtersql="";
$fValueArray=split('[&]', $buffer);
foreach ($fValueArray as $fV){
$fV=split('=', $fV);
list($fg1,$fg2)=split("\[field",$fV[0]);
if($fg2 != "")
{
list($fgid1,$fgid2)=split("filter",$fg1);
$afValueArray=split('[&]', $buffer);
foreach ($afValueArray as $afV){
$afV=split('=', $afV);
list($afg1,$afg2)=split($fgid2,$afV[0]);
if($afg2 =="][field]"){$xfield=$afV[1];}
if($afg2 =="][data][type]"){$xtype=$afV[1];}
if($afg2 =="][data][value]"){$xvalue=$afV[1];}
if($afg2 =="][data][comparison]"){$xcomparison=$afV[1];}
}
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
#$filtersql=$filtersql." and `".$scell."` ".$xcomparison." '".$sqlf1.$xvalue.$sqlf2."' ";

if($xtype=="numeric" || $xtype=="list" || $xtype=="date" || $xtype=="boolean")
{
$filtersql=$filtersql." and `".$scell."` ".$xcomparison." '".$sqlf1.$xvalue.$sqlf2."' ";
}
if($xtype=="string")
{
$filtersql=$filtersql." and `".$scell."` ".$xcomparison." '"."%".$xvalue."%"."' ";
}

#$rp=$rp."-->".$filtersql;
#$stringDatau=$stringDatau."\n".$a."-".$xfield."--".$xtype."--".$xvalue."---".$xcomparison."---$filtersql\n";
}
}

/////////filter over



$orderbyx="";
$rp=$rp."  \n sort1 $sort $dir      ";
if($sort != "" && $dir != "")
{
$scell=$sort;
$orderbyx="order by `".$scell."` $dir ";

$rp=$rp.$sort.">>>".$dir;

}



if($orderbyx =="")
{
//$orderbyx="  ORDER BY `emailid` DESC";
}
$timestart="00:00:00";
$timeend="23:59:59";
$todaydate = date('Y-m-d');
list($rt1,$rt2,$rt3)=split("-",$todaydate);
$yu=(30-$rt3);
$yuyu=$rt1."-".$rt2."-".$yu;
$end_date = date('Y-m-d',strtotime('-30 days'));
if(($startdate == "") && ($enddate == ""))
{
#$defaultdatest=" AND bounce_mail_time_delivery_log >= '".$end_date." ".$timestart."' ";
#$defaultdatest=" AND bounce_mail_time_delivery_log >= '".$end_date." ".$timestart."' ";
#$defaultdateend=" AND bounce_mail_time_delivery_log <= '".$todaydate." ".$timeend."' ";
}
if ($startdate) {
#        $sqlfdate = " AND bounce_mail_time_delivery_log >= '".$startdate." ".$timestart."' ";
      //  $sqlfdate .=" LIMIT ".$start.",".$end."";
     }
if ($enddate) {
 #       $sqldateto = " AND bounce_mail_time_delivery_log <= '".$enddate." ".$timeend."' ";
    //    $sqldateto .=" LIMIT ".$start.",".$end."";
     }
//$sqlniam= "SELECT * FROM `bouncemailtable` where 1 ".$defaultdatest." ".$defaultdateend." ".$sqlfdate." ".$sqldateto."  ".$filtersql."  ".$orderbyx." ";
//$sqlnm=$sqlniam." LIMIT ".$start.",".$end."";





#$defaultdatest=" AND `emaildate` >= '".$startdate."'";
#$defaultdatest=" AND `emaildate` = '".$startdate."'";
#$defaultdateend=" AND `emaildate` <= '".$enddate."'";



$getsql="show tables";
$rbb=0;
$rsg1 = mysql_query($getsql) ;
$sqlniadeli="";
while($tech1=mysql_fetch_array($rsg1))
{
#print "--> ".$tech1[0];
if($rbb!=0)
{
#$sqlniadeli=$sqlniadeli." union ";
}
$rbb++;
#$sqlniadeli= $sqlniadeli."SELECT `id`, `adddatetime`, `adddate`, `emaildatetime`, `emaildate`, `emailfrom`, `emailfromdomain`, `emailfromfull`, `emailto`, `emailtodomain`, `emailtofull`, `subject`, `attachment01`, `attachment02`, `attachment03`, `attachment04`, `attachment05`, `attachment06`, `attachment07`, `attachment08`, `attachment09`, `attachment10`, `mailsize` , `mailstorepath` FROM `".$tech1[0]."` where 1 ".$defaultdatest." ".$defaultdateend." ".$sqlwhere." ".$sqlwheresub." ".$filtersql."  ";
}

$sqlniadeli= $sqlniadeli."SELECT `id`, `adddatetime`, `adddate`, `emaildatetime`, `emaildate`, `emailfrom`, `emailfromdomain`, `emailfromfull`, `emailto`, `emailtodomain`, `emailtofull`, `subject`, `attachment01`, `attachment02`, `attachment03`, `attachment04`, `attachment05`, `attachment06`, `attachment07`, `attachment08`, `attachment09`, `attachment10`, `mailsize` , `mailstorepath` FROM `emaildetails_".$startdate."` where 1 ".$defaultdatest." ".$defaultdateend." ".$sqlwhere." ".$sqlwheresub." ".$filtersql."  ";
if($end ==0){$end=10;}
$sqlniadeli=$sqlniadeli."  ".$orderbyx." ";
$sqlndeli=$sqlniadeli." LIMIT ".$start.",".$end."";
print "";
$rs_countg = mysql_query($sqlniadeli) or die(mysql_error());
$domainrows = mysql_num_rows($rs_countg);
$rsg = mysql_query($sqlndeli) or die(mysql_error());
$rdd=$rdd.$sqlndeli;
#print $sqlndeli;
$prows = mysql_num_rows($rsg);


$dx=mysql_error();

$myFile = "testFile.txt";
$fh = fopen($myFile, 'w') or die("can't open file");
$stringData="\n  $sqlndeli  \n $dx   \n";
fwrite($fh, $stringData);
fclose($fh);
//exit;

#print "\n $sqlndeli \n";


print "{\"meta\":{\"code\":1,\"exception\":[],\"success\":true,\"message\":null},\"data\":{\"total\":".$domainrows.",\"results\":[";


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
print "\"emailfromdomain\":\"".$emailfromdomain."\",";
#print "\"emailfromfull\":\"".$emailfromfull."\",";
print "\"emailto\":\"".$emailto."\",";
print "\"emailtodomain\":\"".$emailtodomain."\",";
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
