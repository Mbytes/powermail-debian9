<?php
include("dbinfo.php");
$tt=1;
$rashusernameadds=$_REQUEST['usernameadds'];

$hfytrh="select * from `mosluseremailmap` where `username`='$rashusernameadds'";
$nn=mysql_query($hfytrh);
while($hgjgfj=mysql_fetch_array($nn))
{
//$usernamerash=$hgjgfj['username'];
$displaynamerash=$hgjgfj['displayname'];
$orgunitrash=$hgjgfj['orgunit'];
$emailrash=$hgjgfj['email'];



}
/////////////////////////////forward email start
//////////////usergroupmap end
if($tt==1)
{
print $displaynamerash.",".$emailrash.",".$orgunitrash;
}
?>
