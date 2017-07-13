#!/usr/bin/perl
$filepath="ti-filter-body-data.txt";
open(SPAMCF,">/etc/mail/spamassassin/tispamcheck-auto-body-filter-data.cf");

$ex=0;
open(ERTX,"<$filepath");
while(<ERTX>)
{

$bodyline=$_;
$bodylinetest=$_;
$bodyline =~ s/[\n|\r]//g;
$bodylinetest =~ s/[\n|\r]//g;
$bodylinetest =~ s/ //g;

$bodyline =~ s/'/\\'/g;
$bodyline =~ s/!/\\!/g;

$bodyline =~ s/\./\\./g;

$bodyline =~ s/\~/\\~/g;
$bodyline =~ s/\#/\\#/g;
$bodyline =~ s/\$/\\\$/g;
$bodyline =~ s/\%/\\%/g;
$bodyline =~ s/\^/\\^/g;
$bodyline =~ s/\&/\\&/g;
$bodyline =~ s/\*/\\*/g;
$bodyline =~ s/\(/\\(/g;
$bodyline =~ s/\)/\\)/g;
$bodyline =~ s/\_/\\_/g;
$bodyline =~ s/\+/\\+/g;
$bodyline =~ s/\|/\\|/g;
$bodyline =~ s/\:/\\:/g;
$bodyline =~ s/\;/\\;/g;
$bodyline =~ s/\`/\\`/g;
$bodyline =~ s/\"/\\"/g;
$bodyline =~ s/\,/\\,/g;
$bodyline =~ s/\{/\\{/g;
$bodyline =~ s/\[/\\[/g;
$bodyline =~ s/\}/\\}/g;
$bodyline =~ s/\@/\\@/g;
$bodyline =~ s/\]/\\]/g;
$bodyline =~ s/\</\\</g;
$bodyline =~ s/\>/\\>/g;
$bodyline =~ s/\?/\\?/g;
#$bodyline =~ s/\@/\\@/g;

if($bodylinetest ne "")
{
$ex++;
$spamline="rawbody TechnoMail_Body".$ex." /\\b".$bodyline."\\b/i";
print SPAMCF $spamline;
print SPAMCF "\n";

$spamline="describe TechnoMail_Body".$ex." body has content [".$bodyline."] which look like spam";
print SPAMCF $spamline;
print SPAMCF "\n";

$spamline="score TechnoMail_Body".$ex." 15.1";
print SPAMCF $spamline;
print SPAMCF "\n\n";
}


}
close(ERTX);
close(SPAMCF);


