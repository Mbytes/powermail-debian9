<?php

$fullgetenv=getenv("QUERY_STRING");
$testin=split("&",$fullgetenv);

for($eget=0;$eget<count($testin);$eget++)
{
list($egetkey,$egetval)=split("=",$testin[$eget]);
#print "<hr> $egetkey ==== $egetval";
$_REQUEST[$egetkey]=$egetval;
}

$buffer = trim(fgets(STDIN));
$buffer=urldecode($buffer);
if(strpos($_SERVER["CONTENT_TYPE"],'application/x-www-form-urlencoded')<>-1){
#print "GGGGGGGGGG";

    $ValueArray=split('[&]', $buffer);
    foreach ($ValueArray as $V){
#print "SSSSSSSSSSS";
      $V=split('=', $V);
      #$_POST[$V[0]]=urldecode($V[1]);
      $_POST[$V[0]]=$V[1];
#print "<hr>".urldecode($V[1]);
    }
	}

#print "<hr>";


$server="localhost";
$user="root";
$password="iball2010";
$database="emaildatabase";
mysql_connect("$server", "$user", "iball2010") or die(mysql_error());
//echo "Connected to MySQL<br />";
mysql_select_db("$database") or die(mysql_error());
//echo "Connected to Database";
?>
