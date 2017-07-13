<?php
include("dbinfo.php");
$usernameadds=$_REQUEST['usernameadds'];

$edituserlogindisplayname=$_POST['edituserlogindisplayname'];
#$edituserlogindisplayname=ltrim($edituserlogindisplayname);
$edituserloginemail=$_POST['edituserloginemail'];
$editorgunit=$_POST['editorgunit'];
$domainnmnm="@motilaloswal.com";

$fulldom=$edituserloginemail.$domainnmnm;
$rashmita="";

$rash14=mysql_query("select `username`, `email` from mosluseremailmap where 1");
//print $rash14;
while($rowras=mysql_fetch_array($rash14))
{
$usernamenm=$rowras['username'];
$email=$rowras['email'];



if($usernamenm != $usernameadds AND $fulldom == $email ){
$rrrr="<b> This email is already present.</b>"."<br>";
$rashmita=$rashmita.$rrrr;
}
}

if($rashmita == ""){
$rasheditupe="update `mosluseremailmap` set `displayname`='$edituserlogindisplayname',`email`='$fulldom',`orgunit`='$editorgunit' where `username`='$usernameadds'";
$fg=mysql_query($rasheditupe);

//echo "{success:true}";
}

$errormsg="";
if($rashmita != "")
{
$errormsg=$rashmita;
$errornow=1;
}
if($rashmita == "")
{
$errormsg="";
$errornow=0;
}

if($errornow==0)
{
print "{success: {message: '".$errormsg."<br /><b>Updated  Successfully<b><br />'}}";
}
else
{
print "{failure: {message: '".$errormsg."'}}";
}


?>
