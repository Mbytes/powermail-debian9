#!/usr/bin/perl


#$readbdate="20081222";
$readbdate=$ARGV[0];

$readlocation="/archive/mailbackup/".$readbdate."/";

use DBI;
use Date::Manip;

        #Database related variables

        $dbName  = "vpopmail";
        $dbHost  = "localhost";
        $dbUname = "vpopmail";
        $dbPass  = "SsEeCcRrEeTt";

   $dbh=DBI->connect("DBI:mysql:$dbName:$dbHost",$dbUname,$dbPass) || die("cannot connect to Database:DBI->errstr\n");

$readtempfile="/tmp/read-b-fast-".$readbdate.".list";
$cmdfindlist="/usr/bin/find ".$readlocation." > ".$readtempfile." ";
`$cmdfindlist`;
print "\n List of Email to read generated for ".$readbdate."\n";
@msglistuu=();
open(TXTA,"<$readtempfile");
$bg=0;
while(<TXTA>)
{
$a=$_;
$a =~ s/\n/""/eg;
$a =~ s/\r/""/eg;
$msglistuu[$bg]=$a;
$bg++;
}
close(TXTA);
$readoknow=1;
if($readoknow==1)
{
for($mju=0;$mju<@msglistuu;$mju++)
{
@msg=();
$readtempfile2=$msglistuu[$mju];
open(TXTAB,"<$readtempfile2");
$cgu=0;
$cgui=0;
while (<TXTAB>)
{
$msg[$cgui]=$_;
$cgui++;
if($cgui==30){last;}
#print "\n LINE MAIL $cgui : ".$_;
}
close(TXTAB);

#############################################
print "\n ------------------------------------------------- \n";
print "\nReading -> $readtempfile2";
$delthismail=0;
$bounce_mail_from="";
$got_postfix=0;
$bounce_mail_to="";
$bounce_mail_time_delivery="";
$bounce_mail_time_delivery_qmail_time="";
$bounce_mail_time_delivery_qmail_unique_id="";
$bounce_mail_subject="";
$bounce_mail_full_header="";
$bounce_mail_orginal_mail_full_header="";
$bounce_mail_technical_error="";
$bounce_mail_for_email_id="";
$check_after_did_not_reach="";
$check_after_did_not_reach2="";
$check_after_email_line=0;
$check_orginal_address_like_vsnl="";
$deliveyfailurefound="";
$dominofound="";
$mailscannerrepportfound="";
$mailscannerrepporttofound="";
$check_orginal_address_like_postix="";


for($ex=0;$ex<@msg;$ex++)
{
$lineorginal=@msg[$ex];
$linemsg=@msg[$ex];
$linemsg =~ s/\n/""/eg;
$linemsg =~ s/\r/""/eg;
$linemsg =~ s/\t/" "/eg;
#print "\n DVDTEST ".$linemsg;
$linemsgnospace=$linemsg;
$linemsgnospace =~ s/ /""/eg;
@linebreak=();
@linebreak=split/:/,$linemsg;
$keyx=$linebreak[0];
$keyxnospace=$keyx;
$keyxnospace=~ s/ /""/eg;

$valuex="";

for($bb=1;$bb<@linebreak;$bb++){if($bb==1){$valuex=$linebreak[$bb];}if($bb>1){$valuex=$valuex.":".$linebreak[$bb];}}

$valuexnospace=$valuex;
$valuexnospace=~ s/ /""/eg;

#print "\n $ex--> $keyx --> $valuex [$bb]($linemsg)";
#print "\n -->$keyx-->$valuex ";

if($bounce_mail_from eq "" && $keyx eq "From"){$bounce_mail_from=$valuex;}
if($bounce_mail_to eq "" && $keyx eq "To"){$bounce_mail_to=$valuex;}
if($bounce_mail_time_delivery eq "" && $keyx eq "Date"){$bounce_mail_time_delivery=$valuex;}
if($bounce_mail_subject eq "" && $keyx eq "Subject"){$bounce_mail_subject=$valuex;}


if($bounce_mail_time_delivery_qmail_unique_id eq "" && $keyx eq "Received")
{
($yyt1,$yyt2)=split/qmail/,$valuexnospace;
if($yyt1 eq "(")
{
($yyt1a,$yyt2a)=split/invoked/,$yyt2;
if($yyt1a ne ""){$bounce_mail_time_delivery_qmail_unique_id=$yyt1a;}

($yyt1b,$yyt2b)=split/;/,$valuex;
if($yyt2b ne ""){$bounce_mail_time_delivery_qmail_time=$yyt2b;}

#print "\n -->>> $yyt1 --> $yyt2 --> $yyt1a --> $yyt2b";

}

}



($chkabc1,$chkabc2)=split/and password not set/,$linemsg;
($chkabc1a,$chkabc2a)=split/iled after I sent the messa/,$linemsg;
($chkabc1b,$chkabc2b)=split/oes not like recipie/,$linemsg;

if($check_after_email_line == 1  && $bounce_mail_technical_error eq ""  && $chkabc2 eq "" && $chkabc2a eq "" && $chkabc2b eq "")
{
#print "\nCheck $check_after_email_line  -->$linemsg";
$check_after_email_line=0;
$bounce_mail_technical_error=$linemsg;
#print "\n--".$bounce_mail_technical_error;
}

##### for Hotmail --Delivery notification erorr not given properly.
($checki2a,$checki2b)=split/eliverytothefollowingrecipientsfaile/,$linemsgnospace;
if($checki2a eq "D"){$deliveyfailurefound=$linemsg;}


### Check on next round for kotak
$getdumplinex=$linemsgnospace;
if($check_after_did_not_reach2 ne "" && $getdumplinex ne "")
{
$check_after_did_not_reach2="";
($check_after_did_not_reach,$eexxdd)=split/ /,$linemsgnospace;
}

#### Check for --kotak like server
($checki2k,$checki3k)=split/ednotreachthefollowingrecipien/,$linemsgnospace;
if($checki2k eq "d" && $check_after_did_not_reach eq ""){$check_after_did_not_reach2=$linemsg;}


###### Check and add for Domaino direcotry
($checki3a,$checki3b)=split/DominoDirector/,$linemsgnospace;
if($checki3b eq "y"){$dominofound=$linemsg;
#print "--> $linemsg";
}

###### for check of email on first line then the erro on 2nd round
($checki1,$checki2)=split/\@/,$keyx;
($checki1a,$checki2a)=split/ /,$keyx;
if($checki1 ne "" && $checki2 ne "" && $valuex eq "" && $checki2a eq "")
{
$bounce_mail_for_email_id=$checki1.'@'.$checki2;
$check_after_email_line=1;
#print "\n--> Check 1 --> $bounce_mail_for_email_id";
}

#### For VSNL Setup 
if($keyxnospace eq "Originaladdress")
{
$bounce_mail_for_email_id=$valuex;
$check_orginal_address_like_vsnl=$valuex;
#print "\n 222 orginal-address $bounce_mail_for_email_id";
}

#### For VSNL Setup --postfix setup
if($keyxnospace eq "Original-Recipient")
{
($oouu1,$oouu2)=split/;/,$valuex;
$check_orginal_address_like_postix=$valuex;
if($oouu1 ne "" & $oouu2 ne ""){$check_orginal_address_like_postix=$oouu2;}

#print "\n 222 orginal-address $bounce_mail_for_email_id";
}

## for some mailscanner report
if($keyxnospace eq "Report"){$mailscannerrepportfound=$linemsg;}
if($keyxnospace eq "To"){$mailscannerrepporttofound=$valuex;}

if($got_postfix==1)
{
$got_postfix=0;
$bounce_mail_technical_error=$bounce_mail_technical_error." ".$linemsg;
}

($post1,$post2)=split/-Postfix/,$valuex;
if($bounce_mail_technical_error eq "" && $keyxnospace eq "Diagnostic-Code" && $post1 ne "")
{
$got_postfix=1;
}




if($bounce_mail_technical_error eq "" && $keyxnospace eq "Diagnosticcode")
{
$bounce_mail_technical_error=$valuex;
}
if($bounce_mail_technical_error eq "" && $keyxnospace eq "Diagnostic-Code")
{
$bounce_mail_technical_error=$valuex;
($eooi1,$eooi2)=split/\(/,$valuex;
($aeooi1,$aeooi2)=split/\)/,$eooi2;
if($aeooi1 ne "" && $aeooi2 ne "")
{
$bounce_mail_for_email_id=$aeooi1;
##print "\n DDDDDDD $aeooi1 --> $aeooi2";
}
#print "\n DDDDDDD $aeooi1 --> $aeooi2";


}

if($bounce_mail_technical_error eq "" && $keyx eq "Remote host said")
{$bounce_mail_technical_error=$valuex;$bounce_mail_for_email_id="";}

($toolong1,$toolong2)=split/this message has been in the queue too/,$linemsg;
if($bounce_mail_technical_error eq "" && $toolong1 ne "" && $toolong2 ne "")
{$bounce_mail_technical_error=$linemsg;}

##### Read for Email after Remote-host found --start #####
if($bounce_mail_technical_error ne "" && $keyxnospace ne "Message-ID")
{
@linebreakemail=();
@linebreakemail=split/ /,$valuex;
#print "\nFFFFFFFF $valuex";
for($bbe=0;$bbe<@linebreakemail;$bbe++)
{

($userxe1,$userxe2)=split/\@/,$linebreakemail[$bbe];
if($userxe1 ne "" && $userxe2 ne "" && $bounce_mail_for_email_id eq "")
{
$bounce_mail_for_email_id=$userxe1.'@'.$userxe2;
print "-------> $bounce_mail_for_email_id";
}

}

}

##### Read for Email after Remote-host found --start #####


}
############### Extra Patches.
if($deliveyfailurefound ne "" && $bounce_mail_technical_error eq ""){$bounce_mail_technical_error=$deliveyfailurefound;}
if($mailscannerrepportfound ne "" && $bounce_mail_technical_error eq ""){$bounce_mail_technical_error=$mailscannerrepportfound;}
if ($mailscannerrepporttofound ne "" && $mailscannerrepportfound ne "" && $bounce_mail_for_email_id eq "")
{
$bounce_mail_for_email_id=$mailscannerrepporttofound;
######print ">>>>>>> $bounce_mail_for_email_id";
}

if($dominofound ne "" && $bounce_mail_technical_error ne ""){$bounce_mail_technical_error=$bounce_mail_technical_error.$dominofound;}

if($check_orginal_address_like_vsnl ne "")
{
$bounce_mail_for_email_id=$check_orginal_address_like_vsnl;
}

if($check_orginal_address_like_postix ne "")
{
$bounce_mail_for_email_id=$check_orginal_address_like_postix;
}

if($check_after_did_not_reach ne "")
{
$bounce_mail_for_email_id=$check_after_did_not_reach;
}

$bounce_mail_for_email_id =~ s/ /""/eg;
$bounce_mail_for_email_id =~ s/</""/eg;
$bounce_mail_for_email_id =~ s/>/""/eg;

$bounce_mail_from =~ s/ /""/eg;
$bounce_mail_from =~ s/>/""/eg;
$bounce_mail_from =~ s/</""/eg;

$bounce_mail_to =~ s/ /""/eg;
$bounce_mail_to =~ s/>/""/eg;
$bounce_mail_to =~ s/</""/eg;

##########################

$dodb=1;

($excz1,$excz2)=split/ead\:/,$bounce_mail_subject;
$excz1 =~ s/ /""/eg;
if($excz1 eq "R"){$dodb=0;}

($excz1,$excz2)=split/ot Read\:/,$bounce_mail_subject;
$excz1 =~ s/ /""/eg;
if($excz1 eq "N"){$dodb=0;

print "NOT Read";
}


if($dodb==1)
{
########## ADD to Database Start here #################################33
$delthismail=1;
print "\n ****************************************************\n";
if($bounce_mail_from eq "" || $bounce_mail_to eq "" || $bounce_mail_subject eq "" || $bounce_mail_technical_error eq "" || $bounce_mail_for_email_id eq ""  || $bounce_mail_time_delivery eq "" || $bounce_mail_time_delivery_qmail_unique_id eq "" || $bounce_mail_time_delivery_qmail_time eq "")
{
$delthismail=0;
print "\n --> CHECK-DVD";
}
print "\n --> $bounce_mail_from";
print "\n --> $bounce_mail_to";
print "\n --> $bounce_mail_subject";
print "\n --> $bounce_mail_technical_error";
print "\n --> $bounce_mail_for_email_id";
$bounce_mail_time_delivery="";
$gmt_datetime=$bounce_mail_time_delivery_qmail_time;
$datexx = &ParseDate("$gmt_datetime");
$dateforsql= &UnixDate($datexx,"%Y-%m-%d %T ");
$bounce_mail_time_delivery=$dateforsql;

$bounce_mail_technical_error=~ s/\'/""/eg;

$bounce_mail_from=~ s/\'/""/eg;
$bounce_mail_to=~ s/\'/""/eg;

print "\n --> $bounce_mail_time_delivery";
print "\n --> $bounce_mail_time_delivery_qmail_time";
print "\n --> $bounce_mail_time_delivery_qmail_unique_id";

if ($bounce_mail_from ne "" && $bounce_mail_subject ne "")
{
$filesizeq= -s $readtempfile2;
($vuy1,$vuy2)=split/ailure/,$bounce_mail_subject;
if($vuy2 ne "")
{
$sqlin="INSERT INTO `bouncemailtable` (`bounce_mail_from` , `bounce_mail_to` , `bounce_mail_time_delivery_log` , `bounce_mail_time_delivery` , `bounce_mail_subject` ,  `bounce_mail_for_email_id` , `bounce_mail_normal_error` , `bounce_mail_technical_error` , `bounce_mail_qmail_process_id`,`bounce_mail_size`,`bounce_mail_ms_archive_file`)VALUES ( '".$bounce_mail_from."', '".$bounce_mail_to."', '".$bounce_mail_time_delivery."', '".$bounce_mail_time_delivery_qmail_time."', '".$bounce_mail_subject."', '".$bounce_mail_for_email_id."', '".$bounce_mail_normal_error."', '".$bounce_mail_technical_error."', '".$bounce_mail_time_delivery_qmail_unique_id."','".$filesizeq."','".$readtempfile2."');";
print "\n  $sqlin  \n";

$sru=$dbh->prepare($sqlin);
$sru->execute;
}
}



print "\n ****************************************************\n";
########## ADD to Database Ends here #################################33
}
}
}
else
{
print "No messages found";
}
