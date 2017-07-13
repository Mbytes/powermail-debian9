#!/usr/bin/php
<?php
$todaymail = date("d-m-Y_h-i-s");
$filenamemailstatus="Bounce_Mail_Reports_on_".$todaymail.".csv";
print "Content-Disposition: attachment; filename=\"$filenamemailstatus\"\n";
print "Content-type: application/x-download\n\n";
#print "Content-Transfer-Encoding: binary\n";
#print "Content-type: text/html\n\n";
#print "Content-Description: File Transfer\n\n";
#print "Content-Type: application/csv\n\n";
#print "Content-Language: en, fr, sp\n\n";
#print "Content-Description: File Transfer\n\n";
#print 'Content-disposition: attachment; filename="kl.csv"';
#print "test.php cgi script!\n";

include("dbinfo.php");
$start = (integer) (isset($_POST['start']) ? $_POST['start'] : $_GET['start']);
$end = (integer) (isset($_POST['limit']) ? $_POST['limit'] : $_GET['limit']);
$rashk="";
#$r->addHeaders(array('Expect' => ''));
#$todaymail = date("d-m-Y_h-i-s");  
#$filenamemailstatus="Remote_Mail_Status_on_".$todaymail.".csv";
//eader('Content-Type: text/plain');
  header('Expires: 0');
                header('Cache-control: private');
                header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
                header('Content-Description: File Transfer');
                header('Content-Type: application/x-download');
                header('Content-disposition: attachment; filename="'.$filenamemailstatus.'"');
$fullgetenv=getenv("QUERY_STRING");
$filter = $_REQUEST["filter"];

$sort=$_POST['sort'];

$rashk=$rashk.">>>".$sort;


$dir=$_POST["dir"];


$rashk=$rashk.">>>".$dir;

$gotjsrows=0;
$jsid=0;

$checkorderdvd="order by `emailid` DESC ";

//if($start==""){$start=0;}
//if($limit==""){$limit=50;}

$rashk=$rashk." OHHH i-> $filter\n";



$filtersql="";
$fValueArray=split('[&]', $fullgetenv);
foreach ($fValueArray as $fV){
$fV=split('=', $fV);
list($fg1,$fg2)=split("\[field",$fV[0]);
if($fg2 != "")
{
list($fgid1,$fgid2)=split("filter",$fg1);
$afValueArray=split('[&]', $fullgetenv);
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

#$stringDatau=$stringDatau."\n".$a."-".$xfield."--".$xtype."--".$xvalue."---".$xcomparison."---$filtersql\n";
}
#$stringDatau=$stringDatau.$filtersql;
}

$orderbyx="";
$rashk=$rashk."  \n sort1 $sort $dir      ";
if($sort != "" && $dir != "")
{
$scell=$sort;
$orderbyx="order by `".$scell."` $dir ";

$rashk=$rashk.$sort.">>>".$dir;

}

if($orderbyx =="")
{
//$orderbyx="  ORDER BY `emailid` DESC";
}



//$rk="SELECT * FROM mailstatus";
$rk= "SELECT `bounce_mail_from` , `bounce_mail_to` , `bounce_mail_time_delivery_log` , `bounce_mail_time_delivery` , `bounce_mail_subject` , `bounce_mail_for_email_id` , `bounce_mail_normal_error`, `bounce_mail_technical_error`,`bounce_mail_qmail_process_id`,`bounce_mail_ms_archive_file`,`bounce_mail_size` FROM `bouncemailtable` where 1 ".$filtersql."  ".$orderbyx." ";
$result = mysql_query($rk) or die(mysql_error());
$rrhh=mysql_num_rows($result);
$csv = '';
$rnum=1;
//k=1;
//rk=$rk++;

//$fileName = "test.csv";
print "Sr,Mail From,Mail To,Time Delivery Log,Time Delivery,Mail Subject,Mail For Email ID,Normal Error,Technical Error,Qmail Process ID,MS Archive Mail File,Mail Size";
print "\n";
while($data = mysql_fetch_array($result))
{
//dmail=$data['id'];
$bounce_mail_fromcsv=$data['bounce_mail_from'];
$bounce_mail_tocsv=$data['bounce_mail_to'];
$bounce_mail_time_delivery_logcsv=$data['bounce_mail_time_delivery_log'];
$bounce_mail_time_deliverycsv=$data['bounce_mail_time_delivery'];
//emailid11=$data['emailid'];
//mailid1=$emailid11."@technoinfotech.com";

$bounce_mail_subjectrcsv=$data['bounce_mail_subject'];
$bounce_mail_for_email_idcsv=$data['bounce_mail_for_email_id'];
$bounce_mail_normal_errorcsv=$data['bounce_mail_normal_error'];
$bounce_mail_technical_errorcsv=$data['bounce_mail_technical_error'];
$bounce_mail_qmail_process_idrcsv=$data['bounce_mail_qmail_process_id'];
$bounce_mail_ms_archive_filecsv=$data['bounce_mail_ms_archive_file'];
$bounce_mail_sizecsv=$data['bounce_mail_size'];

if($f!=0)
{
//print "\n";
//print "\n";
}
$f++;
print '"'.$rnum++.'",';
print '"'.$bounce_mail_fromcsv.'",';
print '"'.$bounce_mail_tocsv.'",';
print '"'.$bounce_mail_time_delivery_logcsv.'",';
print '"'.$bounce_mail_time_deliverycsv.'",';
print '"'.$bounce_mail_subjectrcsv.'",';
print '"'.$bounce_mail_for_email_idcsv.'",';
print '"'.$bounce_mail_normal_errorcsv.'",';
print '"'.$bounce_mail_technical_errorcsv.'",';
print '"'.$bounce_mail_qmail_process_idrcsv.'",';
print '"'.$bounce_mail_ms_archive_filecsv.'",';

print '"'.$bounce_mail_sizecsv.'"';
print "\n";

}//while loop end

//print "]}}";

//ho $csv;  
?>
