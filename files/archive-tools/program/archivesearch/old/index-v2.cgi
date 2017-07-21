#!/usr/bin/perl

## folder with trail slash 
$technoarchivefolder="/mnt/4tbbackup/technoarchive/";


$showresult=10;


use DBI;
use Number::Bytes::Human qw(format_bytes);
use WebminCore;
  init_config();
&ReadParse();
print ui_print_header(undef, 'TechnoArchive Advance Email Search', '');

#$searchfrom="postmaster\@technoinfotech.com";
#$forwardto="postmaster\@technoinfotech.com";
$searchdate=`date '+%Y-%m'`;
@common_months = ('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec');

if($in{'datefrom'} ne ""){$searchdate=$in{'datefrom'};}
if($in{'searchfrom'} ne ""){$searchfrom=$in{'searchfrom'};}
if($in{'forwardto'} ne ""){$forwardto=$in{'forwardto'};}
$searchto=$in{'searchto'};
$searchsub=$in{'searchsub'};
$searchatt=$in{'searchatt'};
$forwardto=$in{'forwardto'};

print <<"XDDRR";
</head>
<body>
<form name="myform" action="index.cgi" method=post>
<input type="hidden" name="okwork" value="yes">
<table border=1 cellspacing=3 cellpadding=3>
<tr><td>Search Date (YYYY-MM-DD) / (YYYY-MM) </td><td><input type=text name=datefrom value="$searchdate" size=10 required></td></tr>
<tr ><td>From Email Address  (use * for wildcard)</td><td><input type="text" name="searchfrom" value="$searchfrom"  size=50></td></tr>
<tr><td  >To/Cc/Bcc Email Address (use * for wildcard)  </td><td><input type=text name ="searchto" value="$in{'searchto'}" size=50></td></tr>
<tr><td  >Optional Search for Subject communicated by user </td><td><input type=text name ="searchsub" value="$in{'searchsub'}" size=50></td></tr>
<tr><td  >Optional Search for Content in Body/Attachment  </td><td><input type=text name ="searchatt" value="$in{'seachatt'}" size=50></td></tr>
<tr><td  >Restore/Forward to User (Complete Email Address)</td><td><input type=text name ="forwardto" value="$forwardto" size=50></td></tr>
<tr><td colspan=2>
<input type=button  name="oksearch" value="Search and Show  Data Before inject (would take few Min)" onclick="okf();return false;">
</td></tr>
</table>
</form>
<script>
function okf()
{
document.myform.submit();
}
</script>
XDDRR

if($in{'okwork'} ne "")
{
print "<hr>";
print "<div id=oknow name=oknow>Searching..working..</div>";
##### search now --end
($yearx,$monx,$datex) = split(/-/, $searchdate);
#print " --> $yearx  --> $monx --> $datex <--";
$foldercheck=$yearx."_".$monx;
$qx1="";$qx2="";$qx3="";$qx4="";$qx5="";$qx="";$searchfrom =~ s/ /""/eg;
if($searchfrom ne ""){$qx1 = "author:".$searchfrom."  ";$qx=$qx.$qx1;}
if($searchto ne ""){$qx2 = "rcpt:".$searchto."  "; if($qx1 ne ""){ $qx=$qx." AND " } $qx=$qx.$qx2;}
if($searchsub ne ""){$qx3 = "subject:".$searchsub."  "; if($qx2 ne ""){ $qx=$qx." AND " } $qx=$qx.$qx3;}
if($searchatt ne ""){$qx4 = "".$searchatt."  "; if($qx3 ne ""){ $qx=$qx." AND " } $qx=$qx.$qx4;}
@cmdout=();
$cmdx="recollq -m -n ".$showresult."  -c  ".$technoarchivefolder."/".$foldercheck."/indexdata/ -q \"(".$qx.")\" ";
print "\n $cmdx";
@cmdout=`$cmdx`;
$resultbox=$cmdout[1];
$xmailfrom=();
$xmailsubj=();
$xmailtime=();
$xmailgzip=();
$xmailabst=();
$xmailfile=();
$m=0;
$ex=0;
print "<br>$resultbox <hr>";
for($e=2;$e<@cmdout;$e++)
{
($s1,$s2)=split/ = /,$cmdout[$e];
#print "<br>\n$e [$m] -->".$cmdout[$e]." --> ".$s1;
if($s1 eq "abstract"){$xmailabst[$m]=$s2;}
if($s1 eq "author"){$xmailfrom[$m]=$s2;}
if($s1 eq "caption"){$xmailsubj[$m]=$s2;}
if($s1 eq "dmtime"){$xmailtime[$m]=$s2;}
if($s1 eq "pcbytes"){$xmailgzip[$m]=$s2;}
if($s1 eq "url"){$xmailfile[$m]=$s2;}

$ex++;
if($s1 eq "url"){$ex=0;$m++;}
### for cmdout over
}


for($m=0;$m<@xmailfrom;$m++)
{
## list to display started
$xmailfrom[$m]=~ s/\</"&lt;"/eg;
print "<hr>";
print "<a href =\"viewmail.cgi?filel=".$xmailfile[$m]."\">";
print "".$xmailfrom[$m]." : <b>";
print $xmailsubj[$m]."\n</b></a>";
($common_mday,$common_mon,$common_year,$common_wday) = (localtime($xmailtime[$m]))[3,4,5,6];
  $common_year += 1900;
$common_month=$common_months[$common_mon];
  $cdate = $xmailtime[$m];
$cdate=$common_mday."/".$common_month."/".$common_year;
print $cdate." ";
#print $xmailgzip[$m]." -- ";
print " :<i> Compressed-Size: ";
print format_bytes($xmailgzip[$m]);
print "</i>";
#print "<br><b><font color=black>".$xmailfrom[$m]."</font></b>";

print "<br><i>".$xmailabst[$m]."</i>";


## list to disaply over
}



### search result over 
}

print &ui_print_footer("/", $text{'index'});

