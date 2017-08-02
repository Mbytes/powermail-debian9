#!/usr/bin/perl                                                            
use DBI;                                                                   
#############
my $mydomain= $ARGV[0];
# CONFIG VARIABLES
my $tablename = $mydomain;
$tablename=~ s/\./_/eg;

if($tablename eq "")
{
print "\nPlease give domain name to get size of trash\n";
exit;
}

open(OUTOAZ,"</home/vpopmail/etc/vpopmail.mysql");
while(<OUTOAZ>)
{
$aj=$_;
$aj=~ s/\n/""/eg;
$aj=~ s/\r/""/eg;
($mysqlhost,$mysqlport,$mysqlusername,$mysqlpass,$mysqldb)=split/\|/,$aj;
#print "--> $mysqlhost,$mysqlport,$mysqlusername,$mysqlpass,$mysqldb";
}
close(OUTOAZ);
my $dbh = DBI->connect("dbi:mysql:server=".$mysqlhost.";database=".$mysqldb.";host=".$mysqlhost."",$mysqlusername,$mysqlpass);
die "\n Unable for connect to Windows MSSQL server $DBI::errstr \n" unless $dbh;


$sqlin="SELECT pw_name,pw_passwd,pw_uid,pw_gid,pw_gecos,pw_dir,pw_shell,pw_clear_passwd FROM `".$tablename."`  order by pw_name";
print " -- $sqlin";
$table_data = $dbh->prepare($sqlin);
$table_data->execute;
$vno=0;
$maildirpath="";
$msize="";
$mpass="";
$ltimeshow="";
$lastfrom="";
while(($pw_name,$pw_passwd,$pw_uid,$pw_gid,$pw_gecos,$pw_dir,$pw_shell,$pw_clear_passwd,$ltime,$remote_ip)=$table_data->fetchrow_array)
{
$vno++;
$cmdx="mkdir ".$pw_dir."/Maildir/.Trash 2>/dev/null ; chown vpopmail:vchkpw ".$pw_dir."/Maildir/.Trash 2>/dev/null";
#print "\n $cmdx \n";
$outx=`$cmdx`;
print " $vno : ".$pw_name."\@".$mydomain;
$cmdx="du -hs ".$pw_dir."/Maildir/.Trash | sed 's/[\\t]/|/g' | cut -d \"|\" -f 1";
$outx=`$cmdx`;
print " : $outx";
#print "$cmdx\n";

####/usr/bin/find /home/vpopmail/domains/..../Maildir/.Trash/cur/ -type f -mtime +2 -exec rm {} \;

}





