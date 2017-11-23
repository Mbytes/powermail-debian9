#!/usr/bin/perl
print "Content-type: text/html \n\n"; #HTTP HEADER
use strict;
use DBI;
use DBD::mysql;
my $mydebugok="";
 $mydebugok=$ARGV[0];
my $platform = "mysql";
my $databasename = "mailreports";
my $hostname = "localhost";
my $tablename = "mailstatus";
my $user = "root";
my $pw = "moti2012";
my $from2;
my $to2;
my $sub;
my $sub1;
my $dg;
my $dff;
my $filesized;
my $filename;
my $linex;
my @linexarray;
my $linexi;
my $newlinuxdata;
my $addokchar;
my $ordx;
#DATA SOURCE NAME
my $dsn = "dbi:mysql:$databasename:localhost";
# PERL DBI CONNECT (RENAMED HANDLE)
my $dbstore = DBI->connect($dsn, $user, $pw) or die "Unable to connect: $DBI::errstr\n";
if($mydebugok ne ""){print "DB connected\n";}
#################### TRUNCATE TABLE QUERY START ################################
my $sonaltruncate = "TRUNCATE TABLE `mailstatus`";
my $truncate_handle = $dbstore->prepare($sonaltruncate);
$truncate_handle->execute()or die "Couldn't execute statement:".$truncate_handle->errstr;
##################### TRUNCATE TABLE QUERY END #################################
if($mydebugok ne ""){print "Removed old data connected\n";}

################### FIND FILE COMMAND ##########################################
#my $filereadsize="/var/www/cgi-bin/consolemaster/tmp/size".time().".txt";
my $filereadsize="/usr/local/webadmin/mailreports/tmp/size".time().".txt";
#my $find ="/usr/bin/find /var/qmail/queue/mess -type f -size +1k > ".$filereadsize;
my $find ="/usr/bin/find /var/qmail/queue/mess -type f  > ".$filereadsize;
system ("$find");
if($mydebugok ne ""){print "Find Finished\n";}
my $f = $filereadsize;
my $n = "0";
open (TXTT,"$f");
my @TXTT=<TXTT>;
my $tttx=0;
foreach my $txtt (@TXTT)
{
$txtt=~ tr/\n//d;
$txtt=~ tr/\r//d;
$txtt=~ tr/\t//d;
################################# FILESIZE #####################################
$filesized = -s($txtt);
$filesized=~ tr/\n//d;
$filesized=~ tr/\r//d;
$filesized=~ tr/\t//d;
$filesized=~ tr/ //d;
################################# FILENAME #####################################
(my $f1,my $f2,my $f3,my $f4,my $f5,my $f6,my $f7)=split("/",$txtt);
my $filename = join('/',$f6,$f7);
$filename=~ tr/\n//d;
$filename=~ tr/\r//d;
$filename=~ tr/\t//d;
################################ SUBJECT AND DATE #############################
$from2="";
$to2="";
$sub1="";
$dff="";

open(TXT,"$txtt");
while(my $sumline=<TXT>){
if(grep(/Subject/g,$sumline))
{
($sub,$sub1)=split(':',$sumline);
$sub1=~ tr/\n//d;
$sub1=~ tr/\r//d;
$sub1=~ tr/\t//d;
}
if(grep(/qmail/g,$sumline))
{
(my $dd1,my $dd2)=split(";",$sumline);
(my $d1,my $d2,my $d3,my $d4,my $d5)=split(" ",$dd2);
(my $h,my $m,my $s)=split(":",$d4);
my $s_monname="$d2";
my $s_dayname="$d1";
my %monthnum = qw( Jan 01 Feb 02 Mar 03 Apr 04 May 05 Jun 06 Jul 07 Aug 08 Sep 09 Oct 10 Nov 11 Dec 12 );
my %daynum = qw( 1 01 2 02 3 03 4 04 5 05 6 06 7 07 8 08 9 09 10 10 11 11 12 12 13 13  14 14 15 15 16 16 17 17 18 18 19 19 20 20 21 21 22 22 23 23  24 24 25 25 26 26 27 27 28 28 29 29 30 30 31 31 );
my $mytime1 = $d3;
my $mytime2 = $monthnum{$s_monname};
my $mytime3 = $daynum{$s_dayname};
my $mytime4 = $h;
my $mytime5 = $m;
my $mytime6 = $s;
my $dfg = $mytime1."-".$mytime2."-".$mytime3." ".$mytime4.":".$mytime5.":".$mytime6;
($dff,$dg)=split("--",$dfg);
$dff =~ tr/\n//d;
$dff =~ tr/\r//d;
$dff =~ tr/\t//d;
}
############################################ FIND FROM ##################################################
my $ff="/var/qmail/queue/info/$filename";
open(FILEFROM,"<$ff");
while(<FILEFROM>)
{
$from2=$_;
$from2=~ s/^F//;
$from2=~tr/\n//d;
$from2=~tr/\r//d;
$from2=~tr/[0-9][a-z][A-Z][(\@\_\-\.)]\n//cd;
if($from2 eq '')
{
$from2="bounce";
last;
}
else
{
last;
}
}
close FILEFROM;
###################################### FIND TO #################################
my $tyt="/var/qmail/queue/remote/$filename";
open(OUTOA,"<$tyt");
while(<OUTOA>)
{
 
$linex=$_;@linexarray=();$linexi=0;
@linexarray=split//,$linex;$newlinuxdata="";$addokchar=1;
for($linexi=1;$linexi<@linexarray-1;$linexi++){
if($addokchar==3){$addokchar=1;}if($addokchar==2){$addokchar=3;}
$ordx=ord($linexarray[$linexi]);
if($ordx == 0){$newlinuxdata=$newlinuxdata.",";$addokchar=2;}
if($addokchar==1){$newlinuxdata=$newlinuxdata.$linexarray[$linexi];}}
$to2=$newlinuxdata;
last;
}
close(OUTOA);
if($from2 ne "" &&  $to2 ne "" && $filesized ne "" && $sub1 ne "" && $dff ne "")
{
last;
close (TXT);
}
}
######################### INSERT QUERY START ###################################
$sub1=~tr/\'//d;
my $sonalinsert = "INSERT INTO `mailstatus` (`vpopmaildomain`,`msgfilename`,`from`,`to`,`size`,`subject`,`asondate`,`mailondate`) VALUES ('-','$filename','$from2','$to2','$filesized','$sub1',Now(),'$dff')";
my $insert_handle = $dbstore->prepare($sonalinsert);
#$insert_handle->execute()or die "Couldn't execute statement:".$insert_handle->errstr;
$insert_handle->execute();

############################ INSERT QUERY END ##################################
$n++;
}
close (TXTT);
print "There are ($n) lines in the file '$f'.<br>\n";






