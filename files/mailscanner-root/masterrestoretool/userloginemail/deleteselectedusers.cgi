#!/usr/bin/php
<?php
print "Content-type: text/html\n\n";

include_once("dbinfo.php");
phpinfo();
$tt=1;
$rasharray=array(',','?','!','%','(',')');
$rt=$_POST['task'];
 if (version_compare(PHP_VERSION,"5.2","<"))
    {
        require_once("./JSON.php"); //if php<5.2 need JSON class
        $json = new Services_JSON();//instantiate new json object
        $selectedRows = $json->decode(stripslashes($rt));//decode the data from json format
    } else
    {
        $selectedRows = json_decode(stripslashes($rt));//decode the data from json format
    }

#$rashemailid=$_REQUEST['msgfilename'];
#$rt=$_POST['task'];
print "DVD".$rt;
echo $selectedRows[0].">>".$selectedRows[1];
#echo $string[0];
for($i=0; $i<count($selectedRows); $i++)
{


$del="delete from `mosluseremailmap` where `username`='$selectedRows[$i]'";
print $del;
#mysql_query($del);
}
# echo '1';



?>
