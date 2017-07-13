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
$vpopmaildomain=$_REQUEST['vpopmaildomain'];

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

$sqlniam= "SELECT * FROM `bouncemailtable` where 1 ".$filtersql."  ".$orderbyx." ";





$sqlnm=$sqlniam." LIMIT ".$start.",".$end."";
$rp=$rp."\n SQLa $sqlnm ";

#print "\n<hr> $sqln <hr>\n";

$rs_count = mysql_query($sqlniam) or die(mysql_error());

$rows = mysql_num_rows($rs_count);
#$rows1=" \n   ROWSTOTAL - $rows \n";

//if($start==""){$start=0;}
//if($limit==""){$limit=15;}
#$sqln=$sqln." limit 0,5";

#print " - $sqln";
//$rr=$rr."SQL".$sqln;

$rs = mysql_query($sqlnm) or die(mysql_error());

$rows2 = mysql_num_rows($rs);
$e=0;





print "{\"meta\":{\"code\":1,\"exception\":[],\"success\":true,\"message\":null},\"data\":{\"total\":".$rows.",\"results\":[";

while($data=mysql_fetch_array($rs))
{
//$arr[] = $data;
$e++;
$bounce_mail_fromrash=$data['bounce_mail_from'];
$bounce_mail_torash=$data['bounce_mail_to'];
$bounce_mail_time_delivery_logrash=$data['bounce_mail_time_delivery_log'];
$bounce_mail_time_deliveryrash=$data['bounce_mail_time_delivery'];
//emailid11=$data['emailid'];
//mailid1=$emailid11."@technoinfotech.com";

$bounce_mail_subjectrash=$data['bounce_mail_subject'];
$bounce_mail_for_email_idrash=$data['bounce_mail_for_email_id'];
$bounce_mail_normal_errorrash=$data['bounce_mail_normal_error'];
$bounce_mail_technical_errorrash=$data['bounce_mail_technical_error'];
$bounce_mail_qmail_process_idrash=$data['bounce_mail_qmail_process_id'];
$bounce_mail_ms_archive_filerash=$data['bounce_mail_ms_archive_file'];
$bounce_mail_sizerash=$data['bounce_mail_size'];
if($f!=0)
{
print ",";
}
$f++;
print "{";
//print "\"id\":\"".$f."\",";
print "\"bounce_mail_from\":\"".$bounce_mail_fromrash."\",";
//$msgfilename=str_replace($patternarray,"<br>",$msgfilename);
print "\"bounce_mail_to\":\"".$bounce_mail_torash."\",";
//$mailondate=str_replace($patternarray,"<br>",$mailondate);
print "\"bounce_mail_time_delivery_log\":\"".$bounce_mail_time_delivery_logrash."\",";
//$from=str_replace($patternarray,"<br>",$from);
print "\"bounce_mail_time_delivery\":\"".$bounce_mail_time_deliveryrash."\",";
//$to=str_replace($patternarray,"<br>",$to);
print "\"bounce_mail_subject\":\"".$bounce_mail_subjectrash."\",";
//$size=str_replace($patternarray,"<br>",$size);
print "\"bounce_mail_for_email_id\":\"".$bounce_mail_for_email_idrash."\",";

print "\"bounce_mail_normal_error\":\"".$bounce_mail_normal_errorrash."\",";
print "\"bounce_mail_technical_error\":\"".$bounce_mail_technical_errorrash."\",";
print "\"bounce_mail_qmail_process_id\":\"".$bounce_mail_qmail_process_idrash."\",";
print "\"bounce_mail_ms_archive_file\":\"".$bounce_mail_ms_archive_filerash."\",";
//$subject=str_replace($patternarray,"<br>",$subject);
print "\"bounce_mail_size\":\"".$bounce_mail_sizerash."\"";
//$asondate=str_replace($patternarray,"<br>",$asondate);
print "}";

}//while loop end

print "]}}";

$rp=$rp."\n ENDOK2";
/*$myFile = "debugrashmita.log";
$fh = fopen($myFile, 'w') or die("can't open file");
fwrite($fh,$rp);
fclose($fh);*/


?> 
