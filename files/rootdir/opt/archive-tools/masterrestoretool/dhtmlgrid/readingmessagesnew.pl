#!/opt/lampp/bin/perl
use DBI;
use XML::DOM;
use LWP::UserAgent;
use HTTP::Request qw(GET POST);
use HTTP::Headers;
$myusername="technostocks";
$mypassword="mlpnrt56";
$mysize="100";
$mytonumber="919845993144";
$mytoflag="1";
$mytssl="TSSL";
$mydatabasename="technosmsservice";
$myhostname="127.0.0.1";
$mydbusername="root";
$mydbpassword="gsm2k3k";


my $dbh=DBI->connect("dbi:mysql:$mydatabasename:$myhostname",$mydbusername,$mydbpassword) or die("cannot connect to database".$DBI::errstr);
$timestamp=time;
$xmlsavepath="temp/recievedmessages".$timestamp.".xml";


$http_response='';

    $strRequest = "data=<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>";
    $strRequest = $strRequest . "<!DOCTYPE Messaging SYSTEM \"http://127.0.0.1/dtd/Request.dtd\" >";
    $strRequest = $strRequest . "<REQUEST><USER>$myusername</USER>";
    $strRequest = $strRequest . "<PASSWORD>$mypassword</PASSWORD><INITIAL>$mytssl</INITIAL>";
    $strRequest = $strRequest . "<SIZE>$mysize</SIZE>";
    $strRequest = $strRequest . "<CONDITION TONUMBER=\"$mytonumber\" />";
    $strRequest = $strRequest . "<FLAG>$mytoflag</FLAG></REQUEST>&action=send";






$path="/psms/servlet/psms.MOService";




$host="http://www.myvaluefirst.com/psms/servlet/psms.MOService";

#print $strRequest;

my $ua = LWP::UserAgent->new(timeout => 10);
my $h = HTTP::Headers->new;
$h->content_type('application/x-www-form-urlencoded');
my $request = HTTP::Request->new('POST',$host,$h,$strRequest);
my $res = $ua->request($request);
my $content = $res->content;
print "content = $content\n";






open(FILENAME,">$xmlsavepath");

print FILENAME $content;

close(FILENAME);




my $parser=XML::DOM::Parser->new();

my $doc=$parser->parsefile($xmlsavepath);



$email=$doc->getElementsByTagName('MESSAGING');

$count=$doc->getElementsByTagName('SMS')->getLength;
if($count!=0)
{
$smstono=$doc->getElementsByTagName('TO')->item(0)->getAttribute('NUMBER');

my @smsnos,@smsmessages,$smsredate;
for($j=0;$j<$count;$j++)
{

$smsnos[$j]=$doc->getElementsByTagName('SMS')->item($j)->getAttribute('FROM');
$smsredate[$j]=$doc->getElementsByTagName('SMS')->item($j)->getAttribute('RECDATE');
$smsmessages[$j]=$doc->getElementsByTagName('SMS')->item($j)->getFirstChild->getNodeValue;

}
$selquery="select max(script_recieveid) from recievedmessagedetails";
my $sth=$dbh->prepare($selquery);

$sth->execute;
@getrow=$sth->fetchrow_array();





if($getrow[0]==0)
{



$myscript_recievedid=$countmsg + 1;


}
else
{

$myscript_recievedid=$getrow[0] + 1;


}


$countmsg=@smsmessages;

for($m=0;$m<$countmsg;$m++)
{


$selquery="select * from recievedmessagedetails where to_number='$smstono' and from_number='$smsnos[$m]' and rec_date ='$smsredate[$m]'";
my $sth=$dbh->prepare($selquery);

$sth->execute;
$rws=$sth->rows;
if($rws==0)
{

$myquery="insert into recievedmessagedetails(to_number,script_recieveid,from_number,msg_text,rec_date) values('$mytonumber',$myscript_recievedid,'$smsnos[$m]','$smsmessages[$m]','$smsredate[$m]')";

my $sth=$dbh->prepare($myquery);

$sth->execute;

}



}


}


print $count." Messages Read From the Server";






