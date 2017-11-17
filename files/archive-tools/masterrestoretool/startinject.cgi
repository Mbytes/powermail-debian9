#!/usr/bin/perl
use DBI;
require './mailboxes-lib.pl';
&ReadParse();
#####Reading GET POST Request Over ####
print "Content-type: text/html\n\n";

print "<html><head><title>Email Injecting of $in{'tableok'}....to $in{'injecttouser'}\@sampledomain.com</title></head><body>";
print "<center> <b><font color=red >Injecting ".$in{'countx'}." Emails of ".$in{'showsize'}." Size for Tables/Date ($in{'tableok'}) to user $in{'injecttouser'}\@sampledomain.com <Br>PLEASE WAIT... DO NOT RELOAD it would Inject Emails Again!!!!</b></font><br><br><br></center>";


$dbh=DBI->connect("dbi:mysql:emaildatabase:localhost","root","iball2010") or die("cannot connect to database");
$selquery="select mailstorepath ".$in{'sqlx'}." Group by messageid ";
#print "$selquery --";
$sth=$dbh->prepare($selquery);
$sth->execute();
$donei=0;
  while(@gbd=$sth->fetchrow_array()){
$jit=$gbd[0];
$donei++;
#$serversmtp="192.168.100.252";
$serversmtp="192.168.100.175";
$myfile2="/tmp/tmparcmailinject-".time()."-".$donei;
$cmdx="/bin/cp -f \"".$jit.".gz\" \"".$myfile2.".gz\" ; gzip -d ".$myfile2.".gz ";
`$cmdx`;
$sendnowx="sendEmail -f ".$in{'injecttouser'}."\@sampledomain.com -t ".$in{'injecttouser'}."\@sampledomain.com -s ".$serversmtp.":25 -o message-format=raw -o message-file=$myfile2";
#print "\n$sendnowx\n";
$exq=`$sendnowx`;
print "".$donei."<font color=green>$exq to ".$in{'injecttouser'}."\@sampledomain.com/font><br>";
unlink($myfile2);
#print "<hr> $jit";
}

print "<hr>All injection of emails to user $in{'injecttouser'}\@sampledomain.com DONE.<hr></body></html>";
