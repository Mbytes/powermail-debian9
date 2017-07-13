#!/usr/bin/perl
# index.cgi
# Display all users on the system
use databaseconnect;
require './mailboxes-lib.pl';


# Show main page header
&ui_print_header(undef, "Detail Mail Reports", "", undef, 0, 0, 0,
		 undef, undef, undef,undef);
print <<"EOF";

<script language=\"javascript\">
/*
function LTrimAll(str){if(str==null){return str;}for(var i=0;str.charAt(i)==\"\" || 
str.charAt(i)==\"\n\" || str.charAt(i)==\"\t\";i++);return str.substring(i,str.length);}
function RTrimAll(str){if(str==null){return str;}for(var i=str.length-1;str.charAt(i)==\" \" || str.charAt(i)==\"\n\" || str.charAt(i)==\"\t\";i--);return str.substring(0,i+1);}
function TrimAll(str){return LTrimAll(RTrimAll(str));}
*/
function checksel()
{
error="no";
found="no";
for (var i = 0; i < document.frm_Lo.elements.length; i++) {
    if(document.frm_Lo.elements[i].type == 'checkbox'){
      if(document.frm_Lo.elements[i].checked ==true)
      {
        found="yes";
      }  
    }
  }
if(found == "no")
{
alert('please select atleast one field to display');
return false;
}
if(document.frm_Lo.frmFromDay.value != "" && document.frm_Lo.frmFromMonth.value != "" && document.frm_Lo.frmFromYear.value
 != "" && document.frm_Lo.frmToDay.value != "" &&  document.frm_Lo.frmToMonth.value != "" &&  document.frm_Lo.frmToYear.value != "")
{
/*
document.frm_Lo.frmFromDay.value=TrimAll(document.frm_Lo.frmFromDay.value);
if(document.frm_Lo.frmFromDay.value <0 || document.frm_Lo.frmFromDay.value>9)
{
error="yes";


}
document.frm_Lo.frmToDay.value=TrimAll(document.frm_Lo.frmToDay.value);
if(document.frm_Lo.frmToDay.value <0 || document.frm_Lo.frmToDay.value>9)
{
error="yes";


}
document.frm_Lo.frmFromMonth.value=TrimAll(document.frm_Lo.frmFromMonth.value);
if(document.frm_Lo.frmFromMonth.value <0 || document.frm_Lo.frmFromMonth.value>9)
{
error="yes";


}
document.frm_Lo.frmToMonth.value=TrimAll(document.frm_Lo.frmToMonth.value);
if(document.frm_Lo.frmToMonth.value <0 || document.frm_Lo.frmToMonth.value>9)
{
error="yes";


}

document.frm_Lo.frmFromYear.value=TrimAll(document.frm_Lo.frmFromYear.value);
if(document.frm_Lo.frmFromYear.value<0 || document.frm_Lo.frmFromYear.value>9)
{
error="yes";

}
document.frm_Lo.frmToYear.value=TrimAll(document.frm_Lo.frmToYear.value);
if(document.frm_Lo.frmToYear.value<0 || document.frm_Lo.frmToYear.value>9)
{
error="yes";

}
*/
if(document.frm_Lo.frmFromDay.value>31)
{
error="yes";

}
if(document.frm_Lo.frmFromDay.value <=0)
{
error="yes";
}
if(document.frm_Lo.frmToDay.value > 31 || document.frm_Lo.frmToDay.value <=0)
{
error="yes";

}
if(document.frm_Lo.frmFromMonth.value > 12 || document.frm_Lo.frmFromMonth.value <=0)
{
error="yes";

}
if(error=="yes")
{
alert('please enter proper from and to dates');
return false;
}

}
else
{
alert('please enter proper fron and to dates');
return false;
}
}

function toggleit()
{
for (var i = 0; i < document.frm_Lo.elements.length; i++) {
    if(document.frm_Lo.elements[i].type == 'checkbox'){
      document.frm_Lo.elements[i].checked =         !(document.frm_Lo.elements[i].checked);
    }
  }
}
function toggleall()
{
for (var i = 0; i < document.frm_Lo.elements.length; i++) {
    if(document.frm_Lo.elements[i].type == 'checkbox'){
      document.frm_Lo.elements[i].checked =true;
    }
  }



}
function checkit()
{
if((document.myform1.fromrec.value-document.myform1.torec.value)>0)
{
alert('please enter proper from and to values');
return false;
}

}
</script>
EOF
#print "$in{myaction}";
#$in{myaction}="buildquery";
#$myvalue=30;
if($in{myaction} eq "buildquery")
 {


foreach $myline(sort keys %in)
{
$myinput.="$myline=$in{$myline}&";

}

#print "$myinput";
if(!defined $in{skipit})
{
#print "hello";
#print @in;
$myquery="select ";
$count=0;
#sort %in;
foreach $myline(sort keys %in)
{
$cmm="";
if($in{$myline} eq "fromaddr")
{
if($count > 0)
{
$cmm=",";
}

$myquery.=$cmm."`bounce_mail_from`";
$count++;
}
if($in{$myline} eq "toaddr")
{
if($count > 0)
{
$cmm=",";
}
$myquery.=$cmm."`bounce_mail_to`";
$count++;
}
if($in{$myline} eq "qmailsubject")
{
if($count > 0)
{
$cmm=",";
}

$myquery.=$cmm."`bounce_mail_subject`";
$count++;
}
#if($in{$myline} eq "qmailattach")
#{
#if($count > 0)
#{
#$cmm=",";
#}
#$myquery.=$cmm."`qmail_attachment`";
#$count++;
#}

if($in{$myline} eq "date")
{
if($count > 0)
{
$cmm=",";
}

$myquery.=$cmm."Date_Format(bounce_mail_time_delivery_log,'\%d-\%m-\%Y')";
#$myquery.=$cmm."Date(time_end_msg_log)";
$count++;
}
if($in{$myline} eq "normalmailstatus")
{
if($count > 0)
{
$cmm=",";
}

$myquery.=$cmm."bounce_mail_normal_error";
$count++;
}
if($in{$myline} eq "techmailstatus")
{
if($count > 0)
{
$cmm=",";
}

$myquery.=$cmm."bounce_mail_technical_error";
$count++;
}
if($in{$myline} eq "archivefilename")
{
if($count > 0)
{
$cmm=",";
}

$myquery.=$cmm."bounce_mail_ms_archive_file";
$myfilecnt=$count;
$count++;
}
if($in{$myline} eq "archivelocation")
{
if($count > 0)
{
$cmm=",";
}

$myquery.=$cmm."bounce_mail_ms_archive_file_location_on_nas_server";
$mypathcnt=$count;
$count++;
}
if($in{$myline} eq "archivedvdname")
{
if($count > 0)
{
$cmm=",";
}

$myquery.=$cmm."bounce_mail_ms_archive_dvd_name";

$count++;
}
if($in{$myline} eq "archivedvddate")
{
if($count > 0)
{
$cmm=",";
}

$myquery.=$cmm."Date(bounce_mail_ms_archive_dvd_date)";
$count++;
}
if($in{$myline} eq "archivedvdcount")
{
if($count > 0)
{
$cmm=",";
}

$myquery.=$cmm."bounce_mail_ms_archive_dvd_count";
$count++;
}





 }
$myquery.=" from bouncemail";
$whereclause=" where Date(bounce_mail_time_delivery_log) between '$in{frmFromYear}-$in{frmFromMonth}-$in{frmFromDay}' and '$in{frmToYear}-$in{frmToMonth}-$in{frmToDay}'";
if($in{frmExclude} ne "")
{
$whereclause.=" and `bounce_mail_to` not like '\%$in{frmExclude}\%'";
}
if($in{frmFromEmailId} ne "")
{

$whereclause.=" and `bounce_mail_from` like '\%$in{frmFromEmailId}\%'";
}
if($in{frmToEmailId} ne "")
{
$whereclause.=" and `bounce_mail_to` like '\%$in{frmToEmailId}\%'";
}
if($in{mysubject} ne "")
{
$whereclause.=" and `bounce_mail_subject` like '\%$in{mysubject}\%'";
}
#if($in{myattachment} ne "")
#{
#$whereclause.=" and `qmail_attachment` like '\%$in{myattachment}\%'";
#}
if($in{mynormalmail} ne "")
{
$whereclause.=" and `bounce_mail_normal_error` like '\%$in{mynormalmail}\%'";
}
if($in{mytechnicalmail} ne "")
{
$whereclause.=" and `bounce_mail_technical_error` like '\%$in{mytechnicalmail}\%'";
}

$myquery.=$whereclause;
}
else
{
print "here";
$myquery=$in{myquery};

}

$mywthlimit=$myquery;
if(!defined $in{fromrec} && !defined $in{torec})
{
$in{fromrec}=1;
$in{torec}=30;
}
else
{
$tomyrec=($in{torec} - $in{fromrec}) + 1;
if($in{fromrec}==1)
{
$frommyrec=$in{fromrec} - 1;
}
else
{
$frommyrec=$in{fromrec};

}
}
#$myquery.=" Limit $frommyrec,$tomyrec";
#print $myquery;
#$myquery=~ s/([^A-Za-z0-9])/sprintf("%%%02X", ord($1))/seg;
$in{databasename}="qmaillog";
$in{hostname}="172.16.0.241";
$in{username}="qmaillog";
$in{password}="qmail2007";
$in{databasetype}="mysql";
my $dbcnt=new databaseconnect() or die "cannot connect to database";
if($mywthlimit eq "")
{
$mywthlimit=$in{myquery};

}
my $mylink=$dbcnt->connectit($in{hostname},$in{databasetype},$in{databasename},$in{username},$in{password});
my $sth=$dbcnt->myquery($mylink,$mywthlimit);
my $rows=$sth->rows;
if(defined $in{firsttime})
{
if($in{torec} > $rows)
{
$in{torec}=$rows;
}

}
#print "rohit";
#if(!defined $in{torec})
#{
#print $in{torec};
#if($rows < 30)
#{
#print "dsouza";
#if(!defined $in{torec})
#{
#$myvalue=$rows;
#}
#else
#{
#$myvalue=$in{torec};

#}
#}
#else
#{
#$myvalue=30;

#}
#}
#print $in{skipit};
##############################################################################################################
print <<"myhtml";
<link rel="STYLESHEET" type="text/css" href="dhtmlgrid/css/dhtmlXGrid.css">
    <style>
   body {font-size:12px}
   .{font-family:arial;font-size:12px}
   h1 {cursor:hand;font-size:16px;margin-left:10px;line-height:10px}
   xmp {color:green;font-size:12px;margin:0px;font-family:courier;background-color:#e6e6fa;padding:2px}
   div.hdr{
      background-color:lightgrey;
      margin-bottom:10px;
      padding-left:10px;
   }
    .grid_hover {
        background-color:#7FFFD4;
        font-size:20px;
    }

</style>
        <script  src="dhtmlgrid/js/dhtmlXCommon.js"></script>
        <script  src="dhtmlgrid/js/dhtmlXGrid.js"></script>
        <script  src="dhtmlgrid/js/dhtmlXGridCell.js"></script>

<script>
function doOnLoad()
{

mygrid = new dhtmlXGridObject('gridbox');
//mygrid.setSkin("xp");
myhtml
$count=0;
$myquery1="";
$mywidth=0;
#print $in{skiptit}."rohit";
if(!defined $in{skipit})
{
#print "rohit is here";
#print "alert('hellohere')";

#print "here";
foreach $myline(sort keys %in)
{
$cmm="";
if($in{$myline} eq "fromaddr")
{
if($count > 0)
{
$cmm=",";
}

$myquery1.=$cmm."From Address";
$colwidth.=$cmm."250";
$colalign.=$cmm."left";
$coledit.=$cmm."ro";
$colsort.=$cmm."str";
$mywidth+=250;
$count++;
}
if($in{$myline} eq "toaddr")
{
if($count > 0)
{
$cmm=",";
}
$myquery1.=$cmm."To Address";
$colwidth.=$cmm."250";
$colalign.=$cmm."left";
$coledit.=$cmm."ro";
$colsort.=$cmm."str";
$mywidth+=250;
$count++;
}
if($in{$myline} eq "qmailsubject")
{
if($count > 0)
{
$cmm=",";
}
$myquery1.=$cmm."Subject";
$colwidth.=$cmm."250";
$colalign.=$cmm."left";
$coledit.=$cmm."ro";
$colsort.=$cmm."str";
$mywidth+=250;
$count++;
}
if($in{$myline} eq "qmailattach")
{
if($count > 0)
{
$cmm=",";
}
$myquery1.=$cmm."Attachment";
$colwidth.=$cmm."250";
$colalign.=$cmm."left";
$coledit.=$cmm."ro";
$colsort.=$cmm."str";
$mywidth+=250;
$count++;
}

if($in{$myline} eq "date")
{
if($count > 0)
{
$cmm=",";
}

$myquery1.=$cmm."Date";
$colwidth.=$cmm."120";
$colalign.=$cmm."left";
$coledit.=$cmm."ro";
$colsort.=$cmm."str";
$mywidth+=120;
$count++;
}
if($in{$myline} eq "normalmailstatus")
{
if($count > 0)
{
$cmm=",";
}

$myquery1.=$cmm."Normal mail status";
$colwidth.=$cmm."120";
$colalign.=$cmm."left";
$coledit.=$cmm."ro";
$colsort.=$cmm."str";
$mywidth+=120;
$count++;
}
if($in{$myline} eq "techmailstatus")
{
if($count > 0)
{
$cmm=",";
}

$myquery1.=$cmm."Technical mail status";
$colwidth.=$cmm."250";
$colalign.=$cmm."left";
$coledit.=$cmm."ro";
$colsort.=$cmm."str";
$mywidth+=250;
$count++;
}
if($in{$myline} eq "archivefilename")
{
if($count > 0)
{
$cmm=",";
}

$myquery1.=$cmm."Archive filename";
$colwidth.=$cmm."160";
$colalign.=$cmm."left";
$coledit.=$cmm."link";
$colsort.=$cmm."str";
$mywidth+=160;
$count++;
}
if($in{$myline} eq "archivelocation")
{
if($count > 0)
{
$cmm=",";
}

$myquery1.=$cmm."Archive location";
$colwidth.=$cmm."250";
$colalign.=$cmm."left";
$coledit.=$cmm."ro";
$colsort.=$cmm."str";
$mywidth+=250;
$count++;
}
if($in{$myline} eq "archivedvdname")
{
if($count > 0)
{
$cmm=",";
}

$myquery1.=$cmm."Archive DVD name";
$colwidth.=$cmm."160";
$colalign.=$cmm."left";
$coledit.=$cmm."ro";
$colsort.=$cmm."str";
$mywidth+=160;
$count++;
}
if($in{$myline} eq "archivedvddate")
{
if($count > 0)
{
$cmm=",";
}

$myquery1.=$cmm."Archive DVD date";
$colwidth.=$cmm."120";
$colalign.=$cmm."left";
$coledit.=$cmm."ro";
$colsort.=$cmm."str";
$mywidth+=120;
$count++;
}
if($in{$myline} eq "archivedvdcount")
{
if($count > 0)
{
$cmm=",";
}

$myquery1.=$cmm."Archive DVD count";
$colwidth.=$cmm."100";
$colalign.=$cmm."left";
$coledit.=$cmm."ro";
$colsort.=$cmm."str";
$mywidth+=100;
$count++;
}


}
}
else
{
#print "alert('hello')";

$myquery1=$in{myquery1};
$colwidth=$in{colwidth};
$colalign=$in{colalign};
$coledit=$in{coledit};
$colsort=$in{colsort};

}
#print $mywidth;
#print $myquery1;
print <<"myhtml";
/*   mygrid.setImagePath("dhtmlgrid/imgs/");
mygrid = new dhtmlXGridObject('gridbox');
   mygrid.setHeader("Sr No,$myquery1");
 mygrid.setInitWidths("35,$colwidth");
 mygrid.setColAlign("right,$colalign");
  mygrid.setColTypes("ro,$coledit");
   mygrid.setColSorting("int,$colsort");
//   mygrid.setColumnColor("white,#d5f1ff,#d5f1ff");

   mygrid.init();
 //   mygrid.enableSmartRendering(true,2000);
   mygrid.loadXML("getdatafullbounce.cgi?$myinput&myfilecnt=$myfilecnt&mypathcnt=$mypathcnt");

//myDataProcessor.init(mygrid);
*/
}
function reloadpage()
{

var nm_mask = 'msbte';
mygrid.clearAll();
   mygrid.loadXML("/opt/lampp/cgi-bin/dhtmlgrid/getdatafull.cgi?website="+nm_mask);
}
</script>

</head>

<body>
<form name=myform1 method=post action=$ENV{SCRIPT_NAME} onsubmit=\"return checkit();\">
Show mail detail Records From <input type=text size=2 name=fromrec value=$in{fromrec}>&nbsp;&nbsp;to
<input type=text size=2 name=torec value=$in{torec}>&nbsp;&nbsp;
<input type=submit value=\"Show Information\" >
<!--<input type=hidden name=skipit value=yes>//-->
<input type=hidden name=myquery value=\"$mywthlimit\">
<input type=hidden name=myquery1 value=\"$myquery1\">
<input type=hidden name=colwidth value=\"$colwidth\">
<input type=hidden name=colalign value=\"$colalign\">
<input type=hidden name=coledit value=\"$coledit\">
<input type=hidden name=colsort value=\"$colsort\">
myhtml
foreach $myline(sort keys %in)
{
if($myline ne  "fromrec" and $myline ne  "torec" and $myline ne "myquery" and $myline ne "myquery1" and 
$myline ne "colwidth" and $myline ne "colalign" and $myline ne "coledit" and $myline ne "colsort" and $myline ne "skipit" and $myline ne "firsttime")
{
print "<input type=hidden name=$myline value=\"$in{$myline}\">"."\n";
}

}




print <<"myhtml";
</form>
<table cellpadding=0 cellspacing=0 border=0 width=100%>
<tr><td>List of mail detail record (Showing $in{fromrec} to $in{torec}  of total:$rows)</td></tr>
<tr><td>
<div id="gridbox" style="width:$mywidth px;height:280px;margin-top:20px;margin-bottom:10px;"></div>
</td></tr>
</table>
<script>
mygrid = new dhtmlXGridObject('gridbox');
mygrid.setImagePath("dhtmlgrid/imgs/");
   mygrid.setHeader("Sr No,$myquery1");
 mygrid.setInitWidths("35,$colwidth");
 mygrid.setColAlign("right,$colalign");
  mygrid.setColTypes("ro,$coledit");
   mygrid.setColSorting("int,$colsort");
//   mygrid.setColumnColor("white,#d5f1ff,#d5f1ff");

   mygrid.init();
 //   mygrid.enableSmartRendering(true,2000);
   mygrid.loadXML("getdatafullbounce.cgi?$myinput&myfilecnt=$myfilecnt&mypathcnt=$mypathcnt");
</script>
</body>









myhtml

#################################################################################################################

 }

#####################
#my $now = localtime time;
if(!defined($in{myaction}))
{
my ($sec,$min,$hour,$mday,$mon,$year,
          $wday,$yday,$isdst) = localtime time;
$year +=1900;
$mon+=1;
$yesterday=$mday - 1 ;
if(length($yesterday)==1)
{
$yesterday="0".$yesterday;

}
if(length($mday)==1)
{
$mday="0".$mday;

}
if(length($mon)==1)
{
$mon="0".$mon;

}

print <<"EOF";

<body onLoad="toggleall()">
<form name="frm_Lo" id="frmLox" method="post" action="$ENV{SCRIPT_NAME}" onsubmit="return checksel()";>
<table align="center" border="1" bgcolor="#eeeeee">
<tbody><tr>
<td bgcolor="#cccccc"> <b>Show mail bounce log details.</b></td>

</tr>
<tr>
<td bgcolor="#eeeeee"> Show report from date : <input size="2" name="frmFromDay" value="$yesterday" type="text" maxlength="2">/
                              <input size="2" name="frmFromMonth" value="$mon" type="text" maxlength="2">/
                              <input size="4" name="frmFromYear" value="$year" type="text" maxlength="4">
 
till date
                              <input size="2" name="frmToDay" value="$mday" type="text" maxlength="2">/
                              <input size="2" name="frmToMonth" value="$mon" type="text" maxlength="2">/
                              <input size="4" name="frmToYear" value="$year" type="text" maxlength="4">

</td></tr>
<tr>
<td bgcolor="#cccccc">Do you want to exclude reports of any account <br>(e.g: any mail TO: mailbackup account) Exclude : <input name="frmExclude" value="mailbackup" type="30">  </td>

</tr>

<tr><td bgcolor="#eeeeee">
From Sender [Email ID or \@domain.com] : &nbsp;<input size="30" name="frmFromEmailId" value="" type="text"> &nbsp;</td></tr><tr><td bgcolor="#eeeeee">
To Receiver [Email ID or \@domain.com] : &nbsp; <input size="30" name="frmToEmailId" value="" type="text">
</td></tr>
<tr><td bgcolor="#eeeeee">
Subject : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input size="30" name="mysubject" value="" type="text">
</td></tr>
<!--<tr><td bgcolor="#eeeeee">
Attachment : &nbsp; <input size="30" name="myattachment" value="" type="text">
</td></tr>//-->
<tr><td bgcolor="#eeeeee">
Normal Mail Status : &nbsp;&nbsp;&nbsp;&nbsp;<input size="30" name="mynormalmail" value="" type="text">
</td></tr>
<tr><td bgcolor="#eeeeee">
Technical Mail Status : &nbsp;<input size="30" name="mytechnicalmail" value="" type="text">
</td></tr>
<tr><td></td></tr><tr><td></td></tr><tr><td></td></tr>
<tr>
<td bgcolor="#cccccc"><a href="javascript:void(0)" onclick="toggleit()";>Toggle All</a>&nbsp;&nbsp; <b>Show below fields in report.</b></td></tr>
<tr><td>&nbsp;&nbsp;<input type=checkbox name=mycheck1 value=fromaddr>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;From Address</td></tr>
<tr><td>&nbsp;&nbsp;<input type=checkbox name=mycheck2 value=toaddr>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;To Address</td></tr>





<tr><td>&nbsp;&nbsp;<input type=checkbox name=mycheck3 value=qmailsubject>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;Subject</td></tr>
<!--<tr><td>&nbsp;&nbsp;<input type=checkbox name=mycheck4 value=qmailattach>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;Attachement</td></tr>//-->



<tr><td>&nbsp;&nbsp;<input type=checkbox name=mycheck5 value=date>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;Date</td></tr>
<tr><td>&nbsp;&nbsp;<input type=checkbox name=mycheck6 value=normalmailstatus>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;Normal mail status</td></tr>
<tr><td>&nbsp;&nbsp;<input type=checkbox name=mycheck7 value=techmailstatus>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;Technical mail status</td></tr>
<tr><td>&nbsp;&nbsp;<input type=checkbox name=mycheck8 value=archivefilename>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;Archive filename</td></tr>
<tr><td>&nbsp;&nbsp;<input type=checkbox name=mycheck9 value=archivelocation>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;Archive location</td></tr>
<tr><td>&nbsp;&nbsp;<input type=checkbox name=mycheck91 value=archivedvdname>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;Archive dvdname</td></tr>
<tr><td>&nbsp;&nbsp;<input type=checkbox name=mycheck92 value=archivedvddate>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;Archive dvddate</td></tr>
<tr><td>&nbsp;&nbsp;<input type=checkbox name=mycheck93 value=archivedvdcount>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;Archive dvdcount</td></tr>

<tr><td align="center">
<input size="5" name="submit" value="Show Detailed Report" type="submit">
</td></tr>

<tr><td>&nbsp;</td></tr>
</tbody></table>
<input name="fromrec" value="1" type="hidden">
EOF


print <<"EOF";
<input name="torec" value="30" type="hidden">
<input name="firsttime" value="30" type="hidden">
<input name="myaction" value="buildquery" type="hidden">

</form>
<script>
toggleall();
</script>
</body>






EOF
}
####################

&ui_print_footer("/", $text{'index'});

