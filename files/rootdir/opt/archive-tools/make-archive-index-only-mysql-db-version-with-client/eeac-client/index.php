<?php
ob_start();
session_name('groupoffice');

session_start(); 
include_once("customerdb.php");
$loginok=0;
$globalwebmailuser=$_SESSION['GO_SESSION']['username'];

#print "--> $globalwebmailuser";

if($_GET['logout'] =="yes")
{
session_destroy();
header("location:/groupoffice/index.php");
exit;
}


#### Check Session -- start
$fun=$_GET['fun'];
if($fun ==""){$fun=$_POST['fun'];}
if($fun ==""){$fun=$_GET['fun'];}

if(isset($_SESSION['eeacemail']) && isset($_SESSION['eeadomain']) && isset($_SESSION['eeadomainid']))
{
$loginok=1;
$eeacemail=$_SESSION['eeacemail'];
list($eeacuser,$eeacdomain)=explode("@",$eeacemail);
$eeadomainid=$_SESSION['eeadomainid'];
}

if($globalwebmailuser!="")
{
$loginok=1;
$eeacemail=$globalwebmailuser;
list($eeacuser,$eeacdomain)=explode("@",$eeacemail);
$eeadomainid=0;

}

### Chekc Session end

if($loginok==0 && $_POST['loginnow']=="yes")
{
$eeacemail=$_POST['eeacemail'];
$eeacpassword=$_POST['eeacpassword'];
list($eeacuser,$eeacdomain)=explode("@",$eeacemail);
$emsg="In correct email/password.<br>please try again.";
if($eeacdomain == ""){$errormsg=$emsg;}
if($eeacdomain != "")
{
$domainthere=0;
$di=0;
for($e=0;$e<count($cdomainname);$e++)
{
#print "--> $e ".$cdomainname[$e];
if($cdomainname[$e]==$eeacdomain){$domainthere=1;$di=$e;}
}

if($domainthere==0){$errormsg=$emsg."";}
if($domainthere==1){
#print "got domain --> $eeacpassword ".$cdomainimapip[$di]." --> ".$eeacemail." -->".$eeacpassword;
$imapok=1;
####$curimap=imap_open("{".$cdomainimapip[$di].":143/novalidate-cert/notls}INBOX",$eeacemail,$eeacpassword,OP_HALFOPEN,0) or die ("Failed with error: ".print_r(imap_errors()));
$curimap=imap_open("{".$cdomainimapip[$di].":143/novalidate-cert/notls}INBOX",$eeacemail,$eeacpassword,OP_HALFOPEN,0) or $imapok=0;
if($imapok==1){$loginok=1;}
if($imapok==0){$errormsg=$emsg;}
}

## if domain ok login check over
}

## login ok activty start
if($loginok==1)
{
$_SESSION['eeacemail']=$eeacemail;
$_SESSION['eeadomain']=$eeacdomain;
$_SESSION['eeadomainid']=$di;
$eeadomainid=$di;
}
### logkn ok activity --over

}
#### Login check over


#### Login page Show start
if($loginok==0)
{
header("location:/groupoffice/index.php");
exit;
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>TechnGroup Enterprise Email-Archive .</title>

<link href="login-box.css" rel="stylesheet" type="text/css" />
<script>
function dologin()
{
var dook=1;
if(document.myform.eeacemail.value==""){dook=0;}
if(document.myform.eeacpassword.value==""){dook=0;}
if(dook==0)
{
alert("Please enter email and password correctly.");
}
else
{
document.myform.submit();
}
}
</script>
</head>
<body>
<form name="myform" id="myform" action="index.php" method="post">
<input type="hidden" name="loginnow" value="yes">
<centeR>
<font color=red><?php
echo $errormsg
?></font>
<div style="padding: 100px 0 0 0px;">
<div id="login-box">
<center>
<img src="logo05b.png">
<H2>
EE AC Login</H2>
TechnoGroup's Enterprise Email-Archive Login.
<br />
<br />
<div id="login-box-name" style="margin-top:20px;">Email:</div><div id="login-box-field" style="margin-top:20px;"><input name="eeacemail" class="form-login" title="Email/Username" value="<?php echo $eeacemail; ?>" size="30" maxlength="2048" /></div>
<div id="login-box-name">Password:</div><div id="login-box-field"><input name="eeacpassword" type="password" class="form-login" title="Password" value="" size="30" maxlength="2048" /></div>
<br />
<!-- <span class="login-box-options"><input type="checkbox" name="1" value="1"> Remember Me <a href="#" style="margin-left:30px;">Forgot password?</a></span> -->
<br />
<br />
<a href="#" onClick="dologin();return false;"><img src="images/login-btn.png" width="103" height="42" style="margin-left:90px;" /></a>
</div>
</div>
</centeR>
</form>
<?php
}
### if of login ok --over

## show after login  page 
if($loginok==1)
{

if($fun ==""){$fun="dashboard";}
mysql_connect($cdomainnamedbip[$eeadomainid], $cdomainnamedbuser[$eeadomainid], $cdomainnamedbpass[$eeadomainid]) or die(mysql_error());
mysql_select_db("".$cdomainnamedbname[$eeadomainid]."") or die(mysql_error());


?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<!-- <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" /> -->
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<title>EEAC - TechnGroup Enterprise Email-Archive.</title>

<style type="text/css">
                @import url("css/style.css");
                @import url('css/style_text.css');
                @import url('css/c-grey.css'); /* COLOR FILE CAN CHANGE TO c-blue.ccs, c-grey.ccs, c-orange.ccs, c-purple.ccs or c-red.ccs */
                @import url('css/datepicker.css');
                @import url('css/form.css');
                @import url('css/menu.css');
                @import url('css/messages.css');
                @import url('css/statics.css');
                @import url('css/tabs.css');
                @import url('css/wysiwyg.css');
                @import url('css/wysiwyg.modal.css');
                @import url('css/wysiwyg-editor.css');
        </style>

        <script type="text/javascript" src="js/jquery-1.6.1.min.js"></script>

        <!--[if lte IE 8]>
                <script type="text/javascript" src="js/excanvas.min.js"></script>
        <![endif]-->


</head>
<body>
<div class="wrapper"> 
	<div class="container"> 
 
		<!--[if !IE]> START TOP <![endif]-->  
		<div class="top"> 
			<div class="split"><h1>TechnGroup Enterprise Email-Archive</h1></div> 
			<div class="split"> 
		<div class="logout"><img src="images/icon-logout.gif" align="left" alt="" /> <a href="#" onclick="window.close();return false;">Close</a></div>
				<div><img src="images/icon-welcome.gif" align="left" alt="Welcome" /> Welcome <?php echo $eeacemail; ?></div> 
			</div> 
		</div> 
		<!--[if !IE]> END TOP <![endif]-->  
		
		<!--[if !IE]> START MENU <![endif]-->  
		<div class="menu"> 
			<ul> 
			<!--	<li class="current"><a href="?fun=dashboard">Dashboard</a></li> 
				<li class="break"></li> 
				<li><a href="?fun=emailsend">Email Send</a></li> 
				<li class="break"></li> 
				<li><a href="?fun=emailreceived">Email Received</a></li> 
				<li class="break"></li> -->
				<li><a href="?fun=advanceemailsearch">Advance Email Search</a></li> 
				<li class="break"></li> 
			</ul> 
		</div> 
		
<div class="holder">
<!-- HTML BODY for Work START here --> 

<?php
$searchmaintype=$_POST['searchmaintype'];
$searchdate=$_POST['searchdate'];
$searchcomtype=$_POST['searchcomtype'];
$searchcom=$_POST['searchcom'];
$searchsub=$_POST['searchsub'];
$searchsubtype=$_POST['searchsubtype'];

if($searchmaintype == ""){$searchmaintype=$_GET['searchmaintype'];}
if($searchdate == ""){$searchdate=$_GET['searchdate'];}
if($searchcomtype == ""){$searchcomtype=$_GET['searchcomtype'];}
if($searchcom == ""){$searchcom=$_GET['searchcom'];}
if($searchsub == ""){$searchsub=$_GET['searchsub'];}
if($searchsubtype == ""){$searchsubtype=$_GET['searchsubtype'];}


if($searchmaintype =="fromto"){$searchmaintypefromto="selected";}
if($searchmaintype =="to"){$searchmaintypeto="selected";}
if($searchmaintype =="from"){$searchmaintypefrom="selected";}
if($searchdate ==""){$searchdate=date("Y")."-".date("m");}
if($searchcomtype=="like"){$searchcomtypelike="selected"; $searchcomtype2="like";}
if($searchcomtype=="notlike"){$searchcomtypenotlike="selected";$searchcomtype2="not like";}
if($searchsubtype=="like"){$searchsubtypelike="selected"; $searchsubtype2="like";}
if($searchsubtype=="notlike"){$searchsubtypenotlike="selected";$searchsubtype2="not like";}
$noofrec=$_POST['noofrec'];
if($noofrec==""){$noofrec=$_GET['noofrec'];}
if($noofrec=="50"){$nofrec50="selected";}
if($noofrec=="75"){$nofrec75="selected";}
if($noofrec=="100"){$nofrec100="selected";}
########## restore Email work here -start ######
if($fun=="restoreemail")
{

print "<br><center><h3>Restoring emails...";
#phpinfo();
$doner=0;
for($cv=0;$cv<101;$cv++)
{
$chkkey="chkid_".$cv;
$chkvalue=$_POST[$chkkey];
if($chkvalue!="")
{

#print "<br>$cv --> ".$chkkey."-->".$chkvalue;
list($table1,$table2)=explode("__",$chkvalue);
$mailstorepath="";
$msql="select id, mailstorepath from `".$table1."` where  id='".$table2."'";
#print " --> $msql";
$arsg = mysql_query($msql) or die(mysql_error());
while($atey=mysql_fetch_array($arsg))
{
$mailstorepath=$atey[1];
}
###################################################

$mailza=Array();
$mailzi=0;
$mailza=split("/",$mailstorepath);
$newmailstorepath="";
#print " $mailstorepath --> ".$mailza[1]. "--> ".$mailza[2];
if($mailza[1]=="linuxdata" )
{
$fileok=0;
$filenamemx=$mailstorepath;
$filenamemx=$filenamemx.".gz";
if ($fileok ==0 && file_exists($filenamemx)){$fileok=1;}
#print "\n $fileok --> $filenamemx";

### check for burndbvd --start
if($fileok==0)
{
$burnhandle = opendir('/linuxdata/mail-store-path/newdata/burndvd/');
 while (false !== ($burnfile = readdir($burnhandle))) {
        if ($burnfile != "." && $burnfile != "..") {
#            echo "<br>$burnfile -- \n";
$filenamemx="/linuxdata/mail-store-path/newdata/burndvd/".$burnfile."";
for($c=4;$c<count($mailza);$c++)
{
$filenamemx=$filenamemx."/".$mailza[$c];
}
$filenamemx2=$filenamemx.".gz";
if ($fileok ==0 && file_exists($filenamemx2)){$fileok=1; $mailstorepath=$filenamemx;}
#print "\n $fileok --> $filenamemx";
#if($fileok==1){$mailstorepath=$filenamemx;}
}}closedir($burnhandle);
}
### check for burndbvd --end

### check for tobeburn --start
if($fileok==0)
{
$burnhandle = opendir('/linuxdata/mail-store-path/newdata/tobeburn/');
 while (false !== ($burnfile = readdir($burnhandle))) {
        if ($burnfile != "." && $burnfile != "..") {
#            echo "<br>$burnfile -- \n";
$filenamemx="/linuxdata/mail-store-path/newdata/tobeburn/".$burnfile."";
for($c=4;$c<count($mailza);$c++)
{
$filenamemx=$filenamemx."/".$mailza[$c];
}
$filenamemx2=$filenamemx.".gz";
if ($fileok ==0 && file_exists($filenamemx2)){$fileok=1;$mailstorepath=$filenamemx;}
}}closedir($burnhandle);
}
### check for tobeburn --end



}




if($mailza[1]=="mnt" )
{
$newmailstorepath="/linuxdata/mail-store-path/before2011";
#print " uu changex";
for($mailzi=4;$mailzi<count($mailza);$mailzi++)
{
$newmailstorepath=$newmailstorepath."/".$mailza[$mailzi];
}
#print "$newmailstorepath";
$mailstorepath=$newmailstorepath;
}






###################################################

if($mailstorepath!="")
{
#print "<br>$mailstorepath";
$filex=Array();
$filex=explode("/",$mailstorepath);
$filexi=count($filex)-1;
$cmdx="/bin/cp -f ".$mailstorepath.".gz /tmp/";
$eex=`$cmdx`;
$cmdx2="/bin/gzip -d /tmp/".$filex[$filexi].".gz";
$eex=`$cmdx2`;
#print "<br> $cmdx2 --> ";

$mailcontentff = file_get_contents("/tmp/".$filex[$filexi]);
#$mailcontentff=str_replace("Delivered-To: fullbackup@archive.technomail.in","Delivered-To: fullbackup".time()."@archive.technomail.in",$mailcontentff);
#$mailcontentff=str_replace("Delivered-To: fullbackup@archive.tssl.in","Delivered-To: fullbackup".time()."@archive.tssl.in",$mailcontentff);
$mailcontentff=str_replace("Delivered-To:","oldx-delivered-To:",$mailcontentff);

$exsss=file_put_contents("/tmp/".$filex[$filexi], $mailcontentff);





$sendnowx="/bin/sendEmail -o tls=no -f ".$eeacemail." -t ".$eeacemail." -s ".$cdomainsmtpip[$eeadomainid].":25 -o message-format=raw -o message-file=/tmp/".$filex[$filexi];
$abcx=`$sendnowx`;
#print "<br> $sendnowx";
$doner++;
}


}
}

print "Selected $doner  Email restored successfully.<br><br>Please Check your INBOX for new Email.";

}
########## restore Email work here -end ######
##### only view start
if($fun=="viewemail")
{
$table1=$_GET['et'];
$table2=$_GET['eid'];

$table1=str_replace(" ","",$table1);
$table2=str_replace(" ","",$table2);
#print "aa view ";
$msql="select id, mailstorepath from `".$table1."` where  id='".$table2."'";
#print " --> $msql";
$arsg = mysql_query($msql) or die(mysql_error());
while($atey=mysql_fetch_array($arsg))
{
$mailstorepath=$atey[1];
}

#######
$mailza=Array();
$mailzi=0;
$mailza=split("/",$mailstorepath);
$newmailstorepath="";
## DVDX
#print " $mailstorepath --> ".$mailza[1]. "--> ".$mailza[2];


if($mailza[1]=="linuxdata" )
{
$fileok=0;
$filenamemx=$mailstorepath;
$filenamemx=$filenamemx.".gz";
if ($fileok ==0 && file_exists($filenamemx)){$fileok=1;}
#print "\n $fileok --> $filenamemx";

### check for burndbvd --start
if($fileok==0)
{
$burnhandle = opendir('/linuxdata/mail-store-path/newdata/burndvd/');
 while (false !== ($burnfile = readdir($burnhandle))) {
        if ($burnfile != "." && $burnfile != "..") {
#            echo "<br>$burnfile -- \n";
$filenamemx="/linuxdata/mail-store-path/newdata/burndvd/".$burnfile."";
for($c=4;$c<count($mailza);$c++)
{
$filenamemx=$filenamemx."/".$mailza[$c];
}
$filenamemx2=$filenamemx.".gz";
if ($fileok ==0 && file_exists($filenamemx2)){$fileok=1; $mailstorepath=$filenamemx;}
#print "\n $fileok --> $filenamemx";
#if($fileok==1){$mailstorepath=$filenamemx;}
}}closedir($burnhandle);
}
### check for burndbvd --end

### check for tobeburn --start
if($fileok==0)
{
$burnhandle = opendir('/linuxdata/mail-store-path/newdata/tobeburn/');
 while (false !== ($burnfile = readdir($burnhandle))) {
        if ($burnfile != "." && $burnfile != "..") {
#            echo "<br>$burnfile -- \n";
$filenamemx="/linuxdata/mail-store-path/newdata/tobeburn/".$burnfile."";
for($c=4;$c<count($mailza);$c++)
{
$filenamemx=$filenamemx."/".$mailza[$c];
}
$filenamemx2=$filenamemx.".gz";
if ($fileok ==0 && file_exists($filenamemx2)){$fileok=1;$mailstorepath=$filenamemx;}
}}closedir($burnhandle);
}
### check for tobeburn --end



}




if($mailza[1]=="mnt" )
{
$newmailstorepath="/linuxdata/mail-store-path/before2011";
#print " uu changex";
for($mailzi=4;$mailzi<count($mailza);$mailzi++)
{
$newmailstorepath=$newmailstorepath."/".$mailza[$mailzi];
}
#print "$newmailstorepath";
$mailstorepath=$newmailstorepath;
}






#######
if($mailstorepath!="")
{
#print "<br>$mailstorepath";
$filex=Array();
$filex=explode("/",$mailstorepath);
$filexi=count($filex)-1;
$cmdx="/bin/cp -f ".$mailstorepath.".gz /tmp/";
$eex=`$cmdx`;
$cmdx2="/bin/gzip -d /tmp/".$filex[$filexi].".gz";
$eex=`$cmdx2`;
$readfilex="/tmp/".$filex[$filexi];
#print "<br> $readfilex --> ";
$mailinfo = file_get_contents($readfilex);
require_once('MimeMailParser.class.php');

$path = $readfilex;
$Parser = new MimeMailParser();
$Parser->setPath($path);

$to = $Parser->getHeader('to');
$from = $Parser->getHeader('from');
$subject = $Parser->getHeader('subject');
$date = $Parser->getHeader('date');
$text = $Parser->getMessageBody('text');
$html = $Parser->getMessageBody('html');
$attachments = $Parser->getAttachments();
$from=htmlentities($from);
$to=htmlentities($to);
$text=htmlentities($text);
$chkbox=$table1."__".$table2;
?>
<form method=post action=index.php name=mybox>
<input type="hidden" name="fun" value="restoreemail">
<input type="hidden" name="chkid_1" value="<?=$chkbox?>">


</form>
<div class="pages-bottom">
<div class="actionbox"><button type="usubmit" onClick="if(confirm('Are you sure you want to restore this email?')){document.mybox.submit();}return false;" ><span>Restore this email to my Inbox for complete mail.</span></button></div>
</div>

<?

print "From: ".$from."<br>";
print "To: ".$to."<br>";
print "Date: ".$date."<br>";
print "Subject: ".$subject."<br>";
$ezs=0;
foreach($attachments as $attachment) { // get the attachment name
$filename = $attachment->filename; // write the file to the directory you 
if($ezs==0){print "<br>Attachment (Restore to access file):<br> ";}
if($ezs!=0){print ",<br>";}
$ezs++;
print $filename;
}

print "<hr>";
if($html == "")
{
print "<pre>".$text."</pre>";
}
else
{
print $html;
}
#### viewx show over
}


}

### only view end

if($fun!="searchresult"  && $fun!="viewemail" && $fun!="restoreemail")
{
#print "FUN: - $fun";
?>
<div class="box"> 
<div class="title"> 
<h2>Search</h2> 
<img src="images/title-hide.gif" class="toggle" alt="" />  
</div> 
<div class="content messages"> 
<form name="searchnow" action="index.php" method=pos>
<input type="hidden" name="fun" value="searchresult">
Search for Email Communication <select name="searchmaintype">
<option value="fromto" <?=$searchmaintypefromto?>>From/To <?=$eeacemail?></option>
<option value="from" <?=$searchmaintypefrom?>>From <?=$eeacemail?></option>
<option value="to" <?=$searchmaintypeto?>>To <?=$eeacemail?></option>
</select>
<br>Search in (Year/Month/Date) Enter (YYYY for Year or YYYY-MM for Month or YYYY-MM-DD for Day)
<input type=text name="searchdate"  value="<?=$searchdate?>">
<br>
Communicated <select name="searchcomtype">
<option value="like" <?=$searchcomtypelike?>>with</option>
<option value="notlike" <?=$searchcomtypenotlike?>>not with</option>
</select>
Email/Domain <input type="text" name="searchcom" value="<?=$searchcom?>">
<br>Containing Subject <select name="searchsubtype">
<option value="like" <?=$searchsubtypelike?>>Like</option>
<option value="notlike" <?=$searchsubtypenotlike?>>Not Like</option>
</select> : <input type="text" name="searchsub" value="<?=$searchsub?>">
<br>Show No of Records : <select name="noofrec"> 
<option value="50" <?=$nofrec50?>>50 Records per Page</option>
<option value="75" <?=$nofrec75?>>75 Records per Page</option>
</select>
<br><input type="submit" name="usubmit" value="Search" style="color:white; font-size:11px; font-weight : bold; background-color:green" onclick="document.searchnow.usubmit.value='Please wait..';document.searchnow.usubmit.disabled=true;document.searchnow.submit();">
<br></form>
<br></div></div>

<?php

}

#### search header -end
##### work for searchresult --start
$startpage=0;
if($_POST['startpage']!=""){$startpage=$_POST['startpage'];}
if($fun=="searchresult")
{

$eeacemailold=$eeacuser.'@technogroup.co.in';

#print "FUN: - $fun --> $searchmaintype -- $searchdate";
$searchdate=str_replace(" ","",$searchdate);
$searchdate2=$searchdate;
$searchdate2=str_replace("-","_",$searchdate2);
$getsql="show tables";
$rsg1 = mysql_query($getsql) ;
$tableok=0;
$mainsqlx="";
while($tech1=mysql_fetch_array($rsg1))
{
list($a1,$a2,$a3,$a4)=explode("_",$tech1[0]);
$gdate=0;
if($a1 =="details")
{
$a2=$a2."_".$a3."_".$a4;
list($a5,$a6)=explode($searchdate2,$a2);
if($a6 !="" ){$gdate=1;}
if($a2 == $searchdate2){$gdate=1;}
if($gdate==1)
{
if($tableok!=0){$mainsqlx=$mainsqlx."\n union \n";}
$tableok++;
###### make SQL here start
 
$mainsqlx=$mainsqlx."select id, emailfromfull, emailto, subject, emaildate, '".$tech1[0]."' as tablehere from `".$tech1[0]."` where  ";
if($searchmaintype =="fromto"){$mainsqlx=$mainsqlx."(`emailfrom` like '".$eeacemail."' || `emailto` like '".$eeacemail."'  || `emailfrom` like '".$eeacemailold."' || `emailto` like '".$eeacemailold."')";}
if($searchmaintype =="from"){$mainsqlx=$mainsqlx."(`emailfrom` like '".$eeacemail."' || `emailfrom` like '".$eeacemailold."') ";}
if($searchmaintype =="to"){$mainsqlx=$mainsqlx."(`emailto` like '".$eeacemail."' || `emailto` like '".$eeacemailto."')";}
if($searchcom!="" && $searchcomtype=="like" ){$mainsqlx=$mainsqlx." and (emailto like '%".$searchcom."%' || emailfrom like '%".$searchcom."%' || emailfromfull like '%".$searchcom."%' )";}
#if($searchcom!="" && $searchcomtype=="like" ){$mainsqlx=$mainsqlx." and (emailto like '%".$searchcom."%')";}
if($searchcom!="" && $searchcomtype=="notlike" ){$mainsqlx=$mainsqlx." and (emailto not like '%".$searchcom."%' || emailfrom not like '%".$searchcom."%')";}
if($searchsub!="" && $searchsubtype=="like" ){$mainsqlx=$mainsqlx." and subject like '%".$searchsub."%'";}
if($searchsub!="" && $searchsubtype=="notlike" ){$mainsqlx=$mainsqlx." and subject not like '%".$searchsub."%'";}
$mainsqlx=$mainsqlx."";
$mainsqlx=$mainsqlx."";
$mainsqlx=$mainsqlx."";
###### make SQL here end 
#print "<br> $searchdate2 --> $a2 --> ".$tech1[0]."--> ".$gdate;
}
}
}
$totalrecord=0;
$tpage=0;
$nowpage=0;
$domainrows=0;
if($tableok>0)
{
#print "<br> SQL - $mainsqlx";
$rs_countg = mysql_query($mainsqlx) or die(mysql_error());
$domainrows = mysql_num_rows($rs_countg);
$startpage1z=$startpage*$noofrec;
$mainsqlx=$mainsqlx." limit $startpage1z,$noofrec";

$tpage=1;
$zx=0;
for($z=0;$z<$domainrows;$z++)
{
$zx++;
if($zx==$noofrec)
{
$zx=0;
$tpage++;
}
}

$nowpage=$startpage+1;
}
?>

<!-- TABLE DESIGN START -->
<form name="mybox" action="index.php" method=post>
<div class="box"><div class="title"><h2>Email Search Result(s) (Total : <?=$domainrows?>) Page <?=$nowpage?> of <?=$tpage?> </h2>
<!-- <img src="images/title-hide.gif" class="toggle" alt="" /> -->
</div>
<div class="content pages">
<? 
if($tableok>0)
{

if($domainrows>0)
{
$totalrecord=$domainrows;
#print "<br>$totalrecord  SQL - $mainsqlx";
$rsg = mysql_query($mainsqlx) or die(mysql_error());
?>
<input type="hidden" name="fun" value="restoreemail">
<table><thead><tr><td><input type="checkbox" class="checkall" /></td><td>Sr.</td><td>Email From</td><td>Email To</td>
<td>Subject</td><td>Dated</td></tr></thead><tbody>

<?
$jsid=0;
while($tey=mysql_fetch_array($rsg))
{
$tey[1]=htmlentities($tey[1]);
$jsid++;
$teysub=str_replace(" ","",$tey[3]);
if($tey[3]=="" || $teysub ==""){$tey[3]="No subject";}
$xsubx=Array();
$xsubx=str_split($tey[3]);
$subc=count($xsubx);
if($subc>38)
{
$tey[3]="";
for($ez=0;$ez<33;$ez++)
{
$tey[3]=$tey[3].$xsubx[$ez];
}
$tey[3]=$tey[3]."...";

}
print "<tr class=\"grey\"><td><input type=\"checkbox\" name=\"chkid_".$jsid."\" value=\"".$tey[5]."__".$tey[0]."\" /></td><td>".$jsid."</td><td>".$tey[1]."&nbsp;</td><td>".$tey[2]."&nbsp;</td><td><a href=\"?fun=viewemail&et=".$tey[5]."&eid=".$tey[0]."&\" style=\"color:red\">".$tey[3]."</a></td><td>".$tey[4]."</td></tr>";
}
?>
</tbody></table></form><div class="pages-bottom">
<div class="actionbox"><button type="usubmit" onClick="if(confirm('Are you sure you want to restore selected emails?')){document.mybox.submit();}return false;" ><span>Restore selected to my Inbox</span></button></div>
<div class="pagination">
<form name="abcform" action="index.php" method="post">
<select name="startpage">
<?
for($hb=0;$hb<$tpage;$hb++)
{
$hb1=$hb+1;
$hb2="";
if($hb==$startpage){$hb2="selected";}
print "<option value=\"".$hb."\" ".$hb2.">Page ".$hb1."</option>";
}
?>
</select> 


<input type="hidden" name="fun" value="searchresult">
<input type="hidden" name="searchmaintype" value="<?=$searchmaintype?>">
<input type="hidden" name="searchdate"  value="<?=$searchdate?>">
<input type="hidden" name="searchcomtype" value="<?=$searchcomtype?>">
<input type="hidden" name="searchcom" value="<?=$searchcom?>">
<input type="hidden" name="searchsubtype" value="<?=$searchsubtype?>">
<input type="hidden" name="searchsub" value="<?=$searchsub?>">
<input type="hidden" name="noofrec" value="<?=$noofrec?>">
<input type="submit" name="usubmit" value="Go" style="color:white; font-size:11px; font-weight : bold; background-color:green" onclick="document.abcnow.usubmit.value='Please wait..';document.abcnow.usubmit.disabled=true;document.abcnow.submit();">

</form>
</div>
</div> 


<?
}
}

if($totalrecord==0){print "<center><font color=red><b>No Record Found.!!!<b></font></center>";}
?>


</div></div> 
<!-- TABLE DESIGN END -->
<?php
}
##### work for search over here -- end



?>





<!-- HTML BODY for Work END here --> 
</div>



		<div class="footer"> 
			<div class="split">&#169; Copyright <a href="http://www.technoinfotech.com">TechnoInfotech,India</a></div> 
			<div class="split right">Maintained by <a href="mailto:support@technoinfotech.com">TechnoInfotech Support Team</a></div> 
		</div> 
		


</div></div>

<script type="text/javascript" src="js/jquery-ui.js"></script>
<script type="text/javascript" src="js/jquery.pngFix.js"></script>
<script type="text/javascript" src="js/hoverIntent.js"></script>
<script type="text/javascript" src="js/superfish.js"></script>
<script type="text/javascript" src="js/supersubs.js"></script>
<script type="text/javascript" src="js/date.js"></script>
<script type="text/javascript" src="js/jquery.sparkbox-select.js"></script>
<script type="text/javascript" src="js/jquery.datepicker.js"></script>

<script type="text/javascript" src="js/jquery.filestyle.mini.js"></script>
<script type="text/javascript" src="js/jquery.flot.js"></script>
<script type="text/javascript" src="js/jquery.graphtable-0.2.js"></script>
<script type="text/javascript" src="js/jquery.wysiwyg.js"></script>
<script type="text/javascript" src="js/plugins/wysiwyg.rmFormat.js"></script>
<script type="text/javascript" src="js/controls/wysiwyg.link.js"></script>
<script type="text/javascript" src="js/controls/wysiwyg.table.js"></script>
<script type="text/javascript" src="js/controls/wysiwyg.image.js"></script>

<script type="text/javascript" src="js/inline.js"></script> 
 
<?php
###### HTML After Login over
}
## all login after details over
?>
</body>
</html>
<?php
ob_end_flush();
?>
