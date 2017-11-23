#!/opt/lampp/bin/perl
use DBI;
use databaseconnect;
#use XML::DOM;
#use XML::Simple;
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

#my $parser=XML::DOM::Parser->new();

#my $doc=$parser->parsefile($in{data});

#$xml = new XML::Simple;
#$data = $xml->XMLin("mynewxml.xml");
$in{databasename}="sugarcrm";
$in{hostname}="127.0.0.1";
$in{username}="root";
$in{password}="gsm2k3k";
$in{databasetype}="mysql";

#$in{databasename}=$data->{DATABASE};
#$in{hostname}=$data->{HOSTNAME};
#$in{username}=$data->{USERNAME};
#$in{password}=$data->{PASSWORD};


my $dbcnt=new databaseconnect() or die "cannot connect to database";

my $mylink=$dbcnt->connectit($in{hostname},$in{databasetype},$in{databasename},$in{username},$in{password});
$selquery="select id,email1,email2,website,industry from accounts where website like '\%$in{'website'}\%'";
my $sth=$dbcnt->myquery($mylink,$selquery);



print  "Content-type: text/xml\n\n";
print "<?xml version=\"1.0\" encoding=\"iso-8859-1\"?>\n";
print "<rows>\n";
$i=0;

while($getdata=$sth->fetchrow_hashref)
{

#print "<row id=\"$getdata->{id}\">
 #               <cell>$getdata->{id}</cell>
 #              </row>\n";

     print "<row id=\"$getdata->{id}\">
                <cell>$getdata->{id}</cell>
                <cell>$getdata->{email1}</cell>
                <cell>$getdata->{email2}</cell>
                <cell>$getdata->{website}</cell>
                     </row>\n";


$i++;
}
print  "</rows>";




