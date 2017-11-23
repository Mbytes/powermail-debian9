#!/opt/lampp/bin/perl
use DBI;
sub ReadParse
{
local $a = $_[0] ? $_[0] : \%in;
%$a = ( );
local $i;
local $meth = $_[1] ? $_[1] : $ENV{'REQUEST_METHOD'};
undef($in);
if ($meth eq 'POST') {
        read(STDIN, $in, $ENV{'CONTENT_LENGTH'});
        }
if ($ENV{'QUERY_STRING'}) {
        if ($in) { $in .= "&".$ENV{'QUERY_STRING'}; }
        else { $in = $ENV{'QUERY_STRING'}; }
        }
@in = split(/\&/, $in);
foreach $i (@in) {
        local ($k, $v) = split(/=/, $i, 2);
        if (!$_[2]) {
                $k =~ tr/\+/ /;
                $v =~ tr/\+/ /;
                }
        $k =~ s/%(..)/pack("c",hex($1))/ge;
        $v =~ s/%(..)/pack("c",hex($1))/ge;
        $a->{$k} = defined($a->{$k}) ? $a->{$k}."\0".$v : $v;
        }
}
&ReadParse;
$mydatabasename="sugarcrm";
$myhostname="127.0.0.1";
$mydbusername="root";
$mydbpassword="gsm2k3k";


my $dbh=DBI->connect("dbi:mysql:$mydatabasename:$myhostname",$mydbusername,$mydbpassword) or die("cannot connect to database".$DBI::errstr);

$selquery="select id,email1,email2,website,industry from accounts where website like '\%$in{'website'}\%'";
my $sth=$dbh->prepare($selquery);

$sth->execute;


print  "Content-type: text/xml\n\n";
print "<?xml version=\"1.0\" encoding=\"iso-8859-1\"?>\n";
print "<rows>\n";
$i=0;

while($getdata=$sth->fetchrow_hashref)
{

     print "<row id=\"$getdata->{id}\">
                <cell>$getdata->{id}</cell>
                <cell>$getdata->{email1}</cell>
                <cell>$getdata->{email2}</cell>
                <cell>$getdata->{website}</cell>
                     </row>\n";


$i++;
}
print  "</rows>";




