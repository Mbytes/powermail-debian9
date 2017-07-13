#!/usr/bin/perl

require './mailboxes-lib.pl';
&ReadParse();


#print "Content-type: text/plain\n\n";
print "Content-type: text/html\n\n";
$tosmsnumbers="";
$mysmstext="";

$myfile="".$in{'mailstorepath'};
$myfile2="/tmp/tmparcmail-".time()."";
$cmdx="/bin/cp -f \"".$myfile.".gz\" \"".$myfile2.".gz\" ; gzip -d ".$myfile2.".gz ";
`$cmdx`;
#print "\n $cmdx\n";
#$tosmsnumbers="9820336889";
#$mysmstext="Hello World";
if($in{'typeofsend'} ne "")
{
##$sendnowx="sendEmail -f ".$in{'afromaddress'}." -t ".$in{'atoaddress'}." -s 192.168.100.175:25 -o message-format=raw -o message-file=$in{'f'}";
#$serversmtp="192.168.100.252";
$serversmtp="127.0.0.1";
$sendnowx="sendEmail -f ".$in{'atoaddress'}." -t ".$in{'atoaddress'}." -s ".$serversmtp.":25 -o message-format=raw -o tls=no -o message-file=$myfile2";
#print "\n$sendnowx\n";
$exq=`$sendnowx`;
print "<hr><font color=green>$exq to ".$in{'atoaddress'}."</font><hr>";
}


#print $myfile. "-->".$myfile2;
#print "$cmdx ";
$r=0;
$xdata="";
open(OUTOA, "<$myfile2");
while(<OUTOA>)
{
$xdata=$xdata.$_;
#print $_;
}
close(OUTOA);

use MIME::Parser;
use DBI;
use URI::Escape;
use Mail::Address;

#print "<hr><pre>";
#print $xdata;
#print "</pre><hr>";
$xdata=~ s/\r/""/eg;
my $debugtrace=1;
my @listattach=();
my @listattachpath=();
my $lista=0;
my $parser = new MIME::Parser;
$parser->output_under("/tmp");
my $entity = $parser->parse_data($xdata);
foreach my $fileaz ($parser->filer->purgeable) {
    # Strip trailing spaces from filenames:
my $fullfile= $fileaz ;
    $fileaz =~ /(\S*)\s*$/;
    $fileaz = $1;
my @cutx=();
@cutx=split/\//,$fileaz;
my ($cutx1,$cutx2)=split/\./,$cutx[3];
my ($cutx3,$cutx4)=split/\-/,$cutx1;
my $di=@cutx;

#print  "\n<hr>-----ATTACHMENT -> $fileaz --> ".$cutx[1]." --> UU".$cutx[3]." --> ".$cutx1." --> ".$cutx2." --> ".$cutx3." --> ".$cutx4."  ---------DDD".$fullfile."XX".$di."\n";
if($cutx3 eq "msg")
{

if( $cutx2 eq "txt")
{
$fileaztxt=$fileaz;
#print "$fileaztxt";
}
$emailbodya="";
if($emailbodya eq "" && $cutx2 eq "html")
{
open(OUTOAL, "<$fileaz");
while(<OUTOAL>)
{
$emailbodya=$emailbodya.$_;
#print $_;
}
close(OUTOAL);

}

if($emailbodya eq "" )
{
$emailbodya=$emailbodya."<pre>";
open(OUTOALA, "<$fileaztxt");
while(<OUTOALA>)
{
$emailbodya=$emailbodya.$_;
#print $_;
}
close(OUTOALA);
$emailbodya=$emailbodya."</pre>";


}


}

if(($cutx2 ne "txt" || $cutx2 ne "html") && $cutx3 ne "msg")
{
if($cutx[3] eq "")
{
#print $fullfile;
my @cutxu=();
@cutxu=split/\//,$fullfile;
#print "-->UU".$cutx[3]."UU";
$cutx[3]=$cutxu[3];
}
$listattach[$lista]=$cutx[3];
$listattachpath[$lista]=$fileaz;
$lista++;
}
}

###
(my $dheaders, my $dbody) = split (/\n\n/, $xdata, 2);

my $procheaders = $dheaders;
$procheaders =~ s/\?=\s\n/\?=\n/g; # Lines ending with an encoded-word
                               # have an extra space at the end. Remove it.
$procheaders =~ s/\n[ |\t]//g; # Merge multi-line headers into a single line.
my $transheaders = '';
my $emaildate1="";
my $emaildate2="";
my @hlines=();
@hlines=split/\n/,$procheaders;
my $f=0;
for($f=0;$f<@hlines;$f++)
{
#print "\n XXX --> ".$hlines[$f];
my @headnew=split/:/,$hlines[$f];
my $headerkey=$headnew[0];
my $headervalue="";
my $fv=0;
my $rhh=@headnew;
#print "\n DDDCC --> ".$rhh;
for($fv=1;$fv<$rhh;$fv++)
{
if($fv!=1)
{
#print "\n EE ".$headnew[$fv];
$headervalue=$headervalue.":";
}
$headervalue=$headervalue.$headnew[$fv];

}
####### work on Header Starts here
#print  "\n<br>UUUUU  $f --> ".$headerkey." ---> ".$headervalue;
$headervalue=~ s/\n/""/eg;
$headervalue=~ s/\r/""/eg;
$headervalue=~ s/\t/""/eg;
$headervalue=~ s/\'/""/eg;
$headervalue=~ s/\"/""/eg;
$headervalue=~ s/\</"\&lt;"/eg;
$headervalue=~ s/\>/"\&gt;"/eg;
## Reading 2nd line about Fetchmail entry for foldermake
if($headerkey eq "Date"){$emaildatea=$headervalue;}
if($headerkey eq "date"){$emaildatea=$headervalue;}
if($headerkey eq "Message-ID"){$emailmessageid=$headervalue;}
if($headerkey eq "Message-Id"){$emailmessageid=$headervalue;}
if($headerkey eq "Message-id"){$emailmessageid=$headervalue;}
if($headerkey eq "message-id"){$emailmessageid=$headervalue;}
if($headerkey eq "From"){$emailfroma=$headervalue;}
if($headerkey eq "from"){$emailfroma=$headervalue;}
if($headerkey eq "to"){$emailtoa=$headervalue;}
if($headerkey eq "To"){$emailtoa=$headervalue;}
if($headerkey eq "TO"){$emailtoa=$headervalue;}
if($headerkey eq "Cc"){$emailtoa=$emailtoa.",".$headervalue;}
if($headerkey eq "CC"){$emailtoa=$emailtoa.",".$headervalue;}
if($headerkey eq "Subject"){$emailsuba=$headervalue;}
if($headerkey eq "subject"){$emailsuba=$headervalue;}




}
 
print <<"XXDDRR";
<form name="sendx" action="getmailcontentfirst.cgi" metohd=get>
<input type="hidden" name="afromaddress" value="">
Restore to Email address <input type="text" name="atoaddress" value="$in{'injecttouser'}">
<input type="hidden" name="idte" value="">
<input type="hidden" name="injecttouser" value="$in{'injecttouser'}">
<input type="hidden" name="typeofsend" value="inject">
<input type="hidden" name="mailstorepath" value="$in{'mailstorepath'}">
<input type="button" name="" value="Click here to Restore Email Back " onclick="if(confirm('Are you sure you want to restore the email?')){document.sendx.submit();}return false;">
</form>


XXDDRR

print "From : $emailfroma ";
print "<br>To : $emailtoa ";
print "<br>Date : $emaildatea ";

print "<br>Subject : $emailsuba ";
print "<hr>";

$ex=@listattach;

if($ex!=0)
{
print "Attachment(s):";
for($e=0;$e<@listattach;$e++)
{
#$listattach[$e]=~ s/\^/"%5E"/eg;
$listattach[$e]=~ s/%5E/"^"/eg;

print "<br><a href=\"getmailcontentdata.cgi?f=".$listattach[$e]."&f3=".$myfile."&f2=".$listattachpath[$e]."\">".$listattach[$e]."</a>";
}
print "<hr>";
}

print $emailbodya;


unlink($myfile2);




