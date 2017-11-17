#!/usr/bin/perl

require './mailboxes-lib.pl';
&ReadParse();

#print "Content-type: text/plain\n\n";
#print "Content-type: text/html\n\n";
print "Content-type: application/x-download\n";
print "Content-Disposition: attachment; filename=\"".$in{'f'}."\"\n\n";
$tosmsnumbers="";
$mysmstext="";

#$tosmsnumbers="9820336889";
#$mysmstext="Hello World";
$myfilecheck="".$in{'f'};
$myfile="".$in{'f3'};
#print $myfile."--".$myfilecheck;
$r=0;
$xdata="";
open(OUTOA, "<$myfile");
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

#print  "\n<hr>-----ATTACHMENT -> $fileaz --> ".$cutx[1]." --> ".$cutx[3]." --> ".$cutx1." --> ".$cutx2." --> ".$cutx3." --> ".$cutx4."  ---------\n";

if($cutx[3] eq "")
{
#print $fullfile;
my @cutxu=();
@cutxu=split/\//,$fullfile;
#print "-->UU".$cutx[3]."UU";
$cutx[3]=$cutxu[3];
}
$myfilecheck=~ s/\^/"%5E"/eg;
#print  "\n<hr>-----ATTACHMENT -> $fileaz --> ".$cutx[1]." --> ".$cutx[3]." --> ".$cutx1." --> ".$cutx2." --> ".$cutx3." --> ".$cutx4."  --------- $fullfile -- $myfilecheck\n";
#$myfilecheck=~ s/\^/""/eg;

if($cutx[3] eq $myfilecheck)
{

#print "work for $fileaz";
open(OUTOALA, "<$fullfile");
while(<OUTOALA>)
{
print $_;
}
close(OUTOALA);

}

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
 







