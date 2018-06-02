#!/usr/bin/php
<?php
print "Content-type: text/html\n";

include("dbinfo.php");
$addloginusername=$_POST['addloginusername'];
$adduserlogindisplayname=$_POST['adduserlogindisplayname'];
$adduserloginemail=$_POST['adduserloginemail'];
$addorgunit=$_POST['addorgunit'];
$domainnm="@sampledomain.com";
$fulldomain=$adduserloginemail.$domainnm;
$rashmi="";
$rash14=mysql_query("select `username`, `email` from mosluseremailmap where `username`='$addloginusername' or `email`='$fulldomain'");
//print $rash14;
while($rowras=mysql_fetch_array($rash14))
{
$userval=$rowras['username'];
$email=$rowras['email'];
//$rowras[''];


if($addloginusername == $userval)
{

$rrrrr="<b> This username is already present.</b>"."<br>";
$rashmi=$rashmi.$rrrrr;

//echo "{success:false,errors:[{id:'addloginusername',msg:'Sorry, This username is already present!'}]}";
}

if($fulldomain == $email){
$rrrr="<b> This email is already present.</b>"."<br>";
$rashmi=$rashmi.$rrrr;
}

}
if($rashmi == "")
{

$up= " insert into `mosluseremailmap` (`displayname`,`username`,`email`,`orgunit`) values('$adduserlogindisplayname','$addloginusername','$fulldomain','$addorgunit')";
$gh=mysql_query($up);
//echo "{success:true}";
}

$errormsg="";
//$errormsg=$vpopmaildomain.">>".$emailidusermg.">>".$vpopmaildomainusermg.">>".$groupaddsstext.">>".$groupdetailsprefix.">>".$groupdetailsprilist;
if($rashmi != "")
{
$errormsg=$rashmi;
$errornow=1;
}
if($rashmi == "")
{
$errormsg="Submitted";
$errornow=0;
}


if($errornow==0)
{
print "{success: {message: '".$errormsg."  Request Submitted.<br>&nbsp;'}}";
}
else
{
print "{failure: {message: '".$errormsg."'}}";
}


?>
