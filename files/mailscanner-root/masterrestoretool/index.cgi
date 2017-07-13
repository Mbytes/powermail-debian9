#!/usr/bin/perl
use DBI;
require './mailboxes-lib.pl';
&ReadParse();

###### Get the Date#######
  @common_months = ('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec');
  ($common_mday,$common_mon,$common_year,$common_wday) = (localtime(time))[3,4,5,6];
  $common_year += 1900;
$common_month=$common_months[$common_mon];
  $common_today_date = "$common_months[$common_mon]  / $common_mday / $common_year";
$common_mon=$common_mon+1;
  #$common_today_date = $common_mday."/".$common_mon."/".$common_year;
if($common_mon<10)
{
$common_mon="0".$common_mon;
} 
if($common_mday<10){$common_mday="0".$common_mday;}

 $common_today_datewc = $common_year."-".$common_mon."-".$common_mday;
 $common_today_datewc = $common_year."-".$common_mon."";

$timea=time();
######geting date over ###


###Reading GET POST Request Start #################
#   local(*queryString) =@_ if @_;
#   $buffer =$ENV{"QUERY_STRING"};
#if($buffer eq "")
#{
#   read(STDIN, $buffer, $ENV{'CONTENT_LENGTH'});
#}

#   @pairs = split(/&/, $buffer);

 #  foreach $pair (@pairs) {
 #     ($name, $value) = split(/=/, $pair);
 #     $value =~ tr/+/ /;
  #    $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
  #    $value =~ s/<!--(.|\n)*-->//g;
  #    $value =~ s/\n/""/eg;
  #    $value =~ s/\r/" "/eg;
      #$value =~ s/\"/""/eg;
  #    $in{$name} = $value;
  #    $common_allgetpostdata[$common_i]="$name~~~~$value";
  #    $common_i++;

  # }

#####Reading GET POST Request Over ####
print "Content-type: text/html\n\n";
$searchbox="postmaster\@demo.technomail.xyz";
$injecttouser="postmaster\@demo.technomail.xyz";
if($in{'datefrom'} ne ""){$common_today_datewc=$in{'datefrom'};}
if($in{'dateto'} ne ""){$common_today_date=$in{'dateto'};}
if($in{'searchbox'} ne ""){$searchbox=$in{'searchbox'};}
if($in{'injecttouser'} ne ""){$injecttouser=$in{'injecttouser'};}
print <<"XDDRR";
<html><head><title>Email Archive Search Tool</title>



</head>
<body>
<form name="myform" action="index.cgi" method=post>
<input type="hidden" name="okwork" value="yes">
<center><h2>Email Archive Search Tool</h2>
<table border=1 cellspacing=1 cellpadding=3>
<tr bgcolor=grey>
<td>Account to check <input type="text" name="searchbox" value="$searchbox" size=23>(Complete Email Address)</td>
<td>Search Date (YYYY-MM-DD) / (YYYY-MM) <input type=text name=datefrom value="$common_today_datewc" size=10 ></td>
</tr>
<tr>
<td  colspan=2>Optional Search for Email/Domain communicated by user <input type=text name ="searchcom" value="$in{'searchcom'}"></td>
</tr>
<tr><td  colspan=2>Optional Search for Subject communicated by user <input type=text name ="searchsub" value="$in{'searchsub'}"></td></tr>
<tr><td  colspan=2>Optional Search for Attachment (filename) communicated by user <input type=text name ="searchatt" value="$in{'seachatt'}"></td></tr>
<tr><td  colspan=2 bgcolor=grey>Inject to User <input type=text name ="injecttouser" value="$injecttouser" size=23>(Complete Email Address)</td></tr>
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

$dbh=DBI->connect("dbi:mysql:emailarchive:localhost","emailarchive","rI7v6mLiuoAnAoTD") or die("cannot connect to database");
$sth=$dbh->prepare($selquery);
$sth->execute();
$mainsql="";
$sqlquery11="show tables";
$sth11=$dbh->prepare($sqlquery11);
$sth11->execute();
$sqlx=0;
@sqllist=();
@sqllisttable=();
    while(@gbd=$sth11->fetchrow_array()){
$jit=$gbd[0];
$mainsql=" from `".$jit."` where (emailto like '".$searchbox."' || emailfrom like '".$searchbox."') ";
if($in{'datefrom'}){$mainsql=$mainsql." and emaildate like '".$in{'datefrom'}."%'";}
if($in{'searchcom'}){$mainsql=$mainsql." and (emailto like '%".$in{'searchcom'}."%' || emailfrom like '%".$in{'searchcom'}."') ";}
if($in{'searchsub'}){$mainsql=$mainsql." and subject like '%".$in{'searchsub'}."%'";}
if($in{'searchatt'}){$mainsql=$mainsql." and (attachment01 like '%".$in{'searchatt'}."%' || ";}
if($in{'searchatt'}){$mainsql=$mainsql." attachment02 like '%".$in{'searchatt'}."%' || ";}
if($in{'searchatt'}){$mainsql=$mainsql." attachment03 like '%".$in{'searchatt'}."%' || ";}
if($in{'searchatt'}){$mainsql=$mainsql." attachment04 like '%".$in{'searchatt'}."%' || ";}
if($in{'searchatt'}){$mainsql=$mainsql." attachment05 like '%".$in{'searchatt'}."%' || ";}
if($in{'searchatt'}){$mainsql=$mainsql." attachment06 like '%".$in{'searchatt'}."%' || ";}
if($in{'searchatt'}){$mainsql=$mainsql." attachment07 like '%".$in{'searchatt'}."%' || ";}
if($in{'searchatt'}){$mainsql=$mainsql." attachment08 like '%".$in{'searchatt'}."%' || ";}
if($in{'searchatt'}){$mainsql=$mainsql." attachment09 like '%".$in{'searchatt'}."%' || ";}
if($in{'searchatt'}){$mainsql=$mainsql." attachment10 like '%".$in{'searchatt'}."%' ) ";}
#$mainsql=$mainsql." Group by messageid  ;";
$sqllist[$sqlx]=$mainsql;
$sqllisttable[$sqlx]=$jit;
$sqlx++;
#print "<br> $mainsql";
}

print "<table border=1 >";
print "<tr>";
print "<td>Sr.</td>";
print "<td>Found in Table(Date)</td>";
print "<td>Email Count</td>";
print "<td>Email Size (Bytes)</td>";
print "<td>Compress Email Size (Bytes)</td>";
print "<td>View in Grid\/List Before Inject</td>";
 print "<td>Inject</td>";
print "</tr>";
$rf=0;
for($sqlx=0;$sqlx<@sqllist;$sqlx++)
{
#print "<hr>".$sqllist[$sqlx];
$checksql="select mailsize ".$sqllist[$sqlx]." Group by messageid";
#print "<hr>$sqlx --> $checksql";
$sth11=$dbh->prepare($checksql);
$sth11->execute();
$jit=0;
$mailsize=0;
    while(@gbd=$sth11->fetchrow_array()){
$jit++;
$mailsize=$mailsize+$gbd[0];
}


##print "<hr>".$sqllist[$sqlx];
$checksqlz="select mailsizegzip ".$sqllist[$sqlx]." Group by messageid";
#print "<hr>$sqlx --> $checksql";
$sth11z=$dbh->prepare($checksqlz);
$sth11z->execute();
$mailsizegzip=0;
    while(@gbd=$sth11z->fetchrow_array()){
$mailsizegzip=$mailsizegzip+$gbd[0];
}



if($jit!=0){
print "<tr>";
$rf++;
print "<td>".$rf."</td>";
print "<td>".$sqllisttable[$sqlx]."</td>";
print "<td>".$jit."</td>";
$mailsizex=$mailsize;
if($mailsize<1024){$mailsizex=$mailsize;}
if($mailsize>1024 && $mailsize<(1024*1024)){$mailsize=$mailsize/1024;$mailsize=sprintf("%.2f",$mailsize);$mailsizex=$mailsize."K";}
if($mailsize>(1024*1024) && $mailsize<(1024*1024*1024)){$mailsize=$mailsize/(1024*1024);$mailsize=sprintf("%.2f",$mailsize);$mailsizex=$mailsize."M";}
print "<td>".$mailsizex."</td>";
$mailsizex=$mailsizegzip;
if($mailsizegzip<1024){$mailsizex=$mailsize;}
if($mailsizegzip>1024 && $mailsizegzip<(1024*1024)){$mailsizegzip=$mailsizegzip/1024;$mailsizegzip=sprintf("%.2f",$mailsizegzip);$mailsizex=$mailsizegzip."K";}
if($mailsizegzip>(1024*1024) && $mailsizegzip<(1024*1024*1024)){$mailsizegzip=$mailsizegzip/(1024*1024);$mailsizegzip=sprintf("%.2f",$mailsizegzip);$mailsizex=$mailsizegzip."M";}

print "<td>".$mailsizex."</td>";
$str=$sqllist[$sqlx];
$str =~ s/([^A-Za-z0-9])/sprintf("%%%02X", ord($1))/seg;
print "<td align=center><a href=\"viewtheninject.cgi?tableok=".$sqllisttable[$sqlx]."&sqlx=".$str."&injecttouser=".$injecttouser."&\" target=\"_blank\">View </a></td>";
print "<td align=center><a href=\"startinject.cgi?showsize=".$mailsizex."&countx=".$jit."&tableok=".$sqllisttable[$sqlx]."&sqlx=".$str."&injecttouser=".$injecttouser."&\" onclick=\"if(!confirm('Are you Sure?')){return false;}\" target=\"_blank\">Inject to ".$injecttouser."</a></td>";
print "</tr>";
#print "<hr>Email Count -> $jit in table ".$sqllisttable[$sqlx];
#print "<hr>$sqlx --> $checksql";
}
}
print "</table>";
print "<hr>ALL Search Done..........................<hr>";

### Search now  -end
}


print "</body></html>";
