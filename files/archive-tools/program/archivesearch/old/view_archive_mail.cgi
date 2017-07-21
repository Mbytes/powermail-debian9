#!/usr/bin/php
<?php
print "Content-type: text/html\n\n";
$e=0;
$qsdata=$_SERVER["QUERY_STRING"];
$qsdata=str_replace("..","",$qsdata);
$qsdata=str_replace("|","",$qsdata);
$qsdata=str_replace(";","",$qsdata);
$qsdata=str_replace(":","",$qsdata);
$indata=array();
$indata=explode("&",$qsdata);
$mfile="";
$forwardto="";
$sendmailnow="";
for($e=0;$e<sizeof($indata);$e++)
{
$datax=array();
$datax=explode("=",$indata[$e]);
if($datax[0]=="mfile"){$mfile=urldecode($datax[1]);}
if($datax[0]=="forwardto"){$forwardto=urldecode($datax[1]);}
if($datax[0]=="sendmailnow"){$sendmailnow=urldecode($datax[1]);}
}

#print "aa -> $qsdata --> $mfile -->$forwardto --> $sendmailnow";
#exit;

$xfile=$mfile;
$zfile=array();
$zfile=explode("/",$mfile);
$xfile="/tmp/".$zfile[sizeof($zfile)-1];
$cmdx="/bin/cp -pRv ".$mfile." ".$xfile." ; /bin/gzip -d ".$xfile."";
$xfile=str_replace(".gz","",$xfile);
$cmdxout=`$cmdx`;
#print "<hr> $cmdx  --> $xfile<hr>";
require_once '/etc/php5/vendor/autoload.php';
$Parser = new PhpMimeMailParser\Parser();
$Parser->setPath($xfile);

#echo $Parser->getRawHeader('diagnostic-code');

$to = $Parser->getHeader('to');
$from = $Parser->getHeader('from');
$subject = $Parser->getHeader('subject');
$maildatex = $Parser->getHeader('date');
$stringHeaders = $Parser->getHeadersRaw();  // Get all headers as a string, no charset conversion
$arrayHeaders = $Parser->getHeaders();      // Get all headers as an array, with charset conversion
$text = $Parser->getMessageBody('text');
$html = $Parser->getMessageBody('html');
$htmlem = $Parser->getMessageBody('htmlEmbedded'); //HTML Body included data

#print "\n --> $from -->$to --> $subject --> $maildatex";
$from=str_replace("<","&lt;",$from);
$to=str_replace("<","&lt;",$to);
print "From : ".$from."<br>";
print "To : ".$to."<br>";
print "Subject : ".$subject."<br>";
print "Date : ".$maildatex."";
$attach_dir = $xfile."_attach_tmp/";     // Be sure to include the trailing slash
mkdir($attach_dir, 0777, true);
$include_inline = false ;
$Parser->saveAttachments($attach_dir,[$include_inline]);
$attachments = $Parser->getAttachments([$include_inline]);
?>
<script>
function okf()
{
document.myform.submit();
}
</script>

<?php

if($sendmailnow =="")
{
print '<font color=brown><form name="myform" action="view_archive_mail.cgi" method="GET">Restore/Forward to <input type=text name=forwardto value="'.$forwardto.'" size=30><input type=hidden name=mfile value="'.$mfile.'"> <input type=hidden name=sendmailnow value=yes> <input type=button name="sendnow"  value="Send Now" onclick="okf();return false;"></form></font>';
}
else
{
$sendnowx="sendEmail -f archivemail\@`hostname` -t ".$iforwardto."  -o message-format=raw -o message-file=".$xfile."";
print "<br> Mail send <br> $sendnowx";
}

//  Loop through all the Attachments
if (count($attachments) > 0) {
print "<hr>";
    foreach ($attachments as $attachment) {
        echo '<a href="downloadatt.cgi?folder='.$attach_dir.'&filex='.$attachment->getFilename().'">'.$attachment->getFilename().' ('.filesize($attach_dir.$attachment->getFilename()).' Bytes)</a><br />';
    }
}
print "<hr>";
$donex=0;
#if($html !=""){print "".$html."<hr>"; $donex=1;}
if($htmlem !=""){print "".$htmlem."<hr>"; $donex=1;}
if($html !="" && $donex==0){print "".$html."<hr>"; $donex=1;}
if($donex==0){print "<pre>".$text."</pre><hr>";}




?>
