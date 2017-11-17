#!/usr/bin/perl
print "Content-type: text/html \n\n"; #HTTP HEADER
use Mysql;
$platform = "mysql";
$database = "consolemaster";
$tablename = "mailstatus";
$host = "localhost";
$user = "root";
$pw = "techno02srv";
$connect = Mysql->connect($host, $database, $user, $pw);
#$start = (integer) (isset($_POST['start']) ? $_POST['start'] : $_GET['start']);
#$end = (integer) (isset($_POST['limit']) ? $_POST['limit'] : $_GET['limit']);
my $firstoperation = " SELECT `msgfilename`,`mailondate`,`from`,`to`,`subject`,`size`,`asondate` FROM `mailstatus` WHERE msgfilename = '11/9306593'";
#$sqlnm=$firstoperatiion." LIMIT ".$start.",".$end."";
#$rs_count = query($firstoperation) or die(mysql_error());
#$rs = mysql_query($sqlnm) or die(mysql_error());
$execute = $connect->query($firstoperation);
$rownumber = $execute->numrows($rs);
print $rownumber;

print "{\"meta\":{\"code\":1,\"exception\":[],\"success\":true,\"message\":null},\"data\":{\"total\":".$rows.",\"results\":[";
while(@row = $execute->fetchrow())
{
if($f!=0)
{
print ",";
}
$f++;
print "{";
print "\"msgfilename\":\"".$row[0]."\",";
print "\"mailondate\":\"".$row[1]."\",";
print "\"from\":\"".$row[2]."\",";
print "\"to\":\"".$row[3]."\",";
print "\"size\":\"".$row[5]."\",";
print "\"subject\":\"".$row[4]."\",";
print "\"asondate\":\"".$row[6]."\"";
print "}";
print "\n";
}

print "]}}";
print "\n";
