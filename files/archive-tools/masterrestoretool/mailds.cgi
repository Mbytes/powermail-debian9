#!/usr/bin/perl
print "Content-type: text/html \n\n"; #HTTP HEADER
use Mysql;
use CGI;
$f=0;
$platform = "mysql";
$database = "consolemaster";
$tablename = "mailstatus";
$host = "localhost";
$user = "root";
$pw = "techno02srv";
$connect = Mysql->connect($host, $database, $user, $pw);
$q=new CGI;
$f= 0;
$start =$q->param(start);  
$end = $q->param(limit);
my $firstoperation = " SELECT `msgfilename`,`mailondate`,`from`,`to`,`subject`,`size`,`asondate` FROM `mailstatus`";
$sqlnm=$firstoperatiion." LIMIT ".$start.",".$end."";
#$query = $connect->query($sqlnm); 
#$rs_count = $db->query($firstoperation) or die("Error in SQL\n");
#$rs = $query or die("Error in SQL\n");
$execute = $connect->query($firstoperation);
$rownumber = $execute->numrows;
print $rownumber;
$e=0;
print "{\"meta\":{\"code\":1,\"exception\":[],\"success\":true,\"message\":null},\"data\":{\"total\":".$rows.",\"results\":[";
while(@row = $execute->fetchrow($rs))
{
$e++;
print "{";
$msgfilename=$row[0];
print "\"msgfilename\":\"".$msgfilename."\",";
$msgfilename =~ s/\+/ /g;
$mailondate=$row[1];
print "\"mailondate\":\"".$mailondate."\",";
$mailondate =~ s/\+/ /g;
$from=$row[2];
print "\"from\":\"".$from."\",";
$from =~ s/\+/ /g;
$to=$row[3];
print "\"to\":\"".$to."\",";
$to =~ s/\+/ /g;
$size=$row[4];
print "\"size\":\"".$size."\",";
$size =~ s/\+/ /g;
$subject=$row[5];
print "\"subject\":\"".$subject."\",";
$subject =~ s/\+/ /g;
$asondate=$row[6];
print "\"asondate\":\"".$asondate."\"";
$asondate =~ s/\+/ /g;
}
print "]}}";
print"\n";
