#!/usr/bin/php
<?php
print "Content-type: text/html\n";

include("dbinfo.php");

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

$sqlnia= "SELECT `displayname`, `username`, `email`, `orgunit`  FROM `mosluseremailmap` where 1 ".$filtersql."  ".$orderbyx." ";

#$rr=$rr.$sqlnia;

if($end==0)
{
$end=100;
}
$sqln=$sqlnia." LIMIT ".$start.",".$end."";
$rs_count = mysql_query($sqlnia) or die(mysql_error());

$rows = mysql_num_rows($rs_count);

$rs = mysql_query($sqln) or die(mysql_error());
$e=0;
$rrrr="$sqln";


print "{\"meta\":{\"code\":1,\"exception\":[],\"success\":true,\"message\":null},\"data\":{\"totalul\":".$rows.",\"resultsul\":[";

while($dataq=mysql_fetch_array($rs))
{
//$arr[] = $data;
$e++;
$username=$dataq['username'];
$displayname=$dataq['displayname'];
$email=$dataq['email'];
$orgunit=$dataq['orgunit'];
if($f!=0)
{
print ",";
}
$f++;
print "{";
print "\"username\":\"".$username."\",";
print "\"displayname\":\"".$displayname."\",";
print "\"email\":\"".$email."\",";
#$rr=$rr.$emailid11;
//int "\"functions\":\"".$rer."\",";
print "\"orgunit\":\"".$orgunit."\"";

print "}";

}//while loop end

print "]}}";

#$myFile = "debugrashmita.log";
#$fh = fopen($myFile, 'w') or die("can't open file");
#fwrite($fh,$rrrr);
#fclose($fh);



?>



