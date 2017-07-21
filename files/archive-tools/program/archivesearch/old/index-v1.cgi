#!/usr/bin/perl
use DBI;
use WebminCore;
  init_config();
&ReadParse();
print ui_print_header(undef, 'TechnoArchive Advance Email Search', '');

$searchbox="postmaster\@technoinfotech.com";
$forwardto="postmaster\@technoinfotech.com";
$searchdate=`date '+%Y-%m'`;
if($in{'datefrom'} ne ""){$searchdate=$in{'datefrom'};}
if($in{'searchbox'} ne ""){$searchbox=$in{'searchbox'};}
if($in{'forwardto'} ne ""){$forwardto=$in{'forwardto'};}
print <<"XDDRR";
</head>
<body>
<form name="myform" action="index.cgi" method=post>
<input type="hidden" name="okwork" value="yes">
<table border=1 cellspacing=3 cellpadding=3>
<tr><td>Search Date (YYYY-MM-DD) / (YYYY-MM) </td><td><input type=text name=datefrom value="$searchdate" size=10 required></td></tr>
<tr ><td>Email Address to check (use * for wildcard)</td><td><input type="text" name="searchbox" value="$searchbox"  size=50></td></tr>
<tr><td  >Optional Search for Email/Domain communicated by user </td><td><input type=text name ="searchcom" value="$in{'searchcom'}" size=50></td></tr>
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





print &ui_print_footer("/", $text{'index'});

