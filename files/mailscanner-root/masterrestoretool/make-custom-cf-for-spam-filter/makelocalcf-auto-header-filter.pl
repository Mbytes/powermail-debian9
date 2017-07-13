#!/usr/bin/perl
$filepath="ti-filter-header-data.txt";

open(SPAMCF,">/etc/mail/spamassassin/tispamcheck-auto-header-filter-data.cf");

$ex=0;
open(ERTX,"<$filepath");
while(<ERTX>)
{

$headerline=$_;
$headerlinetest=$_;
$headerline =~ s/[\n|\r]//g;
$headerlinetest =~ s/[\n|\r]//g;
$headerlinetest =~ s/ //g;

$headerline =~ s/'/\\'/g;
$headerline =~ s/!/\\!/g;
$headerline =~ s/\./\\./g;
$headerline =~ s/\@/\\@/g;
$headerline =~ s/\~/\\~/g;
$headerline =~ s/\#/\\#/g;
$headerline =~ s/\$/\\\$/g;
$headerline =~ s/\%/\\%/g;
$headerline =~ s/\^/\\^/g;
$headerline =~ s/\&/\\&/g;
$headerline =~ s/\*/\\*/g;
$headerline =~ s/\(/\\(/g;
$headerline =~ s/\)/\\)/g;
$headerline =~ s/\_/\\_/g;
$headerline =~ s/\+/\\+/g;
$headerline =~ s/\|/\\|/g;
$headerline =~ s/\:/\\:/g;
$headerline =~ s/\;/\\;/g;
$headerline =~ s/\`/\\`/g;
$headerline =~ s/\"/\\"/g;
$headerline =~ s/\,/\\,/g;
$headerline =~ s/\{/\\{/g;
$headerline =~ s/\[/\\[/g;
$headerline =~ s/\}/\\}/g;
$headerline =~ s/\]/\\]/g;
$headerline =~ s/\</\\</g;
$headerline =~ s/\>/\\>/g;
$headerline =~ s/\?/\\?/g;
#$headerline =~ s/\@/\\@/g;


if($headerlinetest ne "")
{
$ex++;
$spamline="header TechnoMail_Header".$ex." ALL =~/".$headerline."/i";
print SPAMCF $spamline;
print SPAMCF "\n";

$spamline="describe TechnoMail_Header".$ex." header has content [".$headerline."] which look like spam";
print SPAMCF $spamline;
print SPAMCF "\n";

$spamline="score TechnoMail_Header".$ex." 15.1";
print SPAMCF $spamline;
print SPAMCF "\n\n";
}


}
close(ERTX);
close(SPAMCF);



