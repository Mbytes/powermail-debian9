<?php
session_start();
$Domain_Name="technomail.in";
# the response from reCAPTCHA
if(isset($_POST["security_code"]))
if(($_SESSION['security_code'] == $_POST['security_code']) && (!empty($_SESSION['security_code'] )) && (isset($_POST['submit'])))
{

$serverrashfcname="localhost";
$userrashfc="technomailuser";
$passwordrashfc="g20102010";
$databaserashfc="technoom";
$serverrashfcname="localhost";
$userrashfc="technomailuser";
$passwordrashfc="g20102010";
$databaserashfc="technoom";


mysql_connect("$serverrashfcname", "$userrashfc", "$passwordrashfc") or die(mysql_error());
//echo "Connected to MySQL<br />";
mysql_select_db("$databaserashfc") or die(mysql_error());


$daterash=date('Y-m-d H:i:s',time());
$datefc=date('Y-m-d');
#$datefc="2010-02-23";
$feedback="";
$fastcontrolusername = $_POST["fastcontrolusername"];
$fastcontrolusername = strtolower($fastcontrolusername);
$fastcontrolusername = str_replace(" ","",$fastcontrolusername);
$fastcontrolusername = str_replace("\n","",$fastcontrolusername);
$fastcontrolusername = str_replace("\t","",$fastcontrolusername);
$fastcontrolusername = str_replace("\r","",$fastcontrolusername);

if (preg_match("/@/", $fastcontrolusername)){
#$clusername = str_replace("@","",$clusername);

list($fastcontrolusername,$gbn)=split("@",$fastcontrolusername);
$fastcontrolusername = str_replace("@","",$fastcontrolusername);

}


$longnamefc = $_POST["longnamefc"];
$address1fc = $_POST["address1fc"];
$address2fc = $_POST["address2fc"];
$address3fc = $_POST["address3fc"];
$cityfc= $_POST["cityfc"];
$statefc=$_POST["statefc"];
$zipfc=$_POST["zipfc"];
//$dateofbirthfc=$_POST["dateofbirthfc"];
$dateyy=$_POST["dateyy"];
$datemm=$_POST["datemm"];
$datedd=$_POST["datedd"];
$mobilenumberfc=$_POST["mobilenumberfc"];

$mobilenumberfc = str_replace(" ","",$mobilenumberfc);
$mobilenumberfc = str_replace("\n","",$mobilenumberfc);
$mobilenumberfc = str_replace("\t","",$mobilenumberfc);
$mobilenumberfc = str_replace("\r","",$mobilenumberfc);


$emailidfc=$_POST["emailidfc"];
$emailidfc = strtolower($emailidfc);
$emailidfc = str_replace(" ","",$emailidfc);
$emailidfc = str_replace("\n","",$emailidfc);
$emailidfc = str_replace("\t","",$emailidfc);
$emailidfc = str_replace("\r","",$emailidfc);


$dateofbirthfc1=$dateyy."-".$datemm."-".$datedd;
$dateofbirthfc=date('Y-m-d', strtotime($dateofbirthfc1));



$userdvdok=0;
$msgfc="";
#if($error == ""){
$selemainmo="select `Cl_Code`, `Mobile_Pager`, `Email` from `Main_Client_Info` where `Cl_Code`='$fastcontrolusername' and `Domain_Name`='$Domain_Name' and ValidUser='Y'  order by `rid` desc limit 0,1"; 

$selemainmo="SELECT `pw_name` as Cl_Code , `pw_gecos` as Mobile_Pager  FROM vpopmail.`technomail_in` WHERE `pw_name` LIKE '$fastcontrolusername' limit 0,1";

$lt = mysql_query($selemainmo);
$num_rowsfc = mysql_num_rows($lt);
//if($error == ""){
while ($rowmo = mysql_fetch_array($lt)) {
$clusername=$rowmo['Cl_Code'];
$clusername=strtolower($clusername);
$clusername = str_replace(" ","",$clusername);
$clusername = str_replace("\n","",$clusername);
$clusername = str_replace("\t","",$clusername);
$clusername = str_replace("\r","",$clusername);


$mobilemo=$rowmo['Mobile_Pager'];
$mobilemo = str_replace(" ","",$mobilemo);
$mobilemo = str_replace("\n","",$mobilemo);
$mobilemo = str_replace("\t","",$mobilemo);
$mobilemo = str_replace("\r","",$mobilemo);



$emailmo=$rowmo['Email'];
$emailmo = strtolower($emailmo);
$emailmo = str_replace(" ","",$emailmo);
$emailmo = str_replace("\n","",$emailmo);
$emailmo = str_replace("\t","",$emailmo);
$emailmo = str_replace("\r","",$emailmo);
$userdvdok=1;

}


if($userdvdok==0)
{
$dvdmsgfc="<html><head><title>TechnoMail Password Request</title></head><body><center><img src=\"/technomail.png\" align=center></center><center><b><h1><u>TechnoMail Password Request</h1></u><font size=3 color=red>We have not received your request form for opening/activating TechnoMail email account <font color=blue>".$fastcontrolusername."@TechnoMail.in.</font>  </b></center>";

print "$dvdmsgfc";
exit;
}


$mnb="select * from `onlinepasswordrequest` where `Cl_Code`='$fastcontrolusername' and `Domain_Name`='$Domain_Name' and `ValidUser`='Y' and `CreateDate` = '$datefc' order by `rid` desc limit 0,1";
#print $mnb;
$vu = mysql_query($mnb);
$num=mysql_num_rows($vu);

while ($rowfy = mysql_fetch_array($vu)) {
$datetimecr=$rowfy["CreateDatetime"];
$setoripass=$rowfy["Password"];
}
#$datetimecr=date('Y-j-n', strtotime($datetimecr1));
#print $setoripass;
list($datecr,$timecr)=split(" ",$datetimecr);
list($yycr,$mmcr,$ddcr)=split("-",$datecr);
list($hhcr,$micr,$sscr)=split(":",$timecr);
#print "HH".$hhcr."YY".$yycr."MM".$mmcr."DD".$ddcr."<br>";
$b=mktime( $hhcr, 0, 0, $mmcr, $ddcr, $yycr);

$c=$b+14400;

$d=date("Y-m-d H:i:s",$b);
$dc=date("Y-m-d H:i:s",$c);
$bcd=mktime( date('H'), 0, 0, date('n'), date('j'), date('Y'));
$datebcd=date("Y-m-d H:i:s",$bcd);
#print $d."<br>".$dc."<br>".$datebcd."<br>";
list($cmpdate,$cmptime)=split(" ",$dc);
list($cmphhcr,$cmpmicr,$cmpsscr)=split(":",$cmptime);

list($currdate,$currtime)=split(" ",$datebcd);
list($currhh,$currmi,$currss)=split(":",$currtime);
#print $cmptime."<br>Cmphh".$cmphhcr."<br>Curr".$currhh."<br>";

if($num != 0 && ($currhh < $cmphhcr)){
$msgfc="<center><b><h1><u>Password Request</h1></u><font size=4 color=green> You have already place a request for password request.<br>Please wait at least 4 hours, before request for again.</font></b></center>";

}


if (($num_rowsfc != 0) and ($clusername == $fastcontrolusername) and ($mobilemo == $mobilenumberfc) and ($emailmo == $emailidfc) && (($num != 0 && $currhh >= $cmphhcr) or($num == 0) )){

function createRandomPassword() {



    $chars = "abcdefghijkmnopqrstuvwxyz023456789";

    srand((double)microtime()*1000000);

    $i = 0;

    $pass = '' ;



    while ($i <= 7) {

        $num = rand() % 33;

        $tmp = substr($chars, $num, 1);

        $pass = $pass . $tmp;

        $i++;

    }



    return $pass;



}
#$passwordre = createRandomPassword();
require_once 'lib/swift_required.php';

$forp="Online Request of Forgot Password";

$passwordre=$setoripass;
if($num == 0){
$passwordre = createRandomPassword();
$df="/home/vpopmail/bin/webmailvpasswd  ".$fastcontrolusername."@".$Domain_Name."   ".$passwordre."";
system($df);
}


### Send SMS here -start
include_once("sms_class.php");
$singlesmsmsg="Hello, Your new password for email ".$fastcontrolusername."@TechnoMail.in is ".$passwordre." .";
$singlesmsmsg1 = str_replace(" ","%20",$singlesmsmsg);
$singlesmsmsg2 = str_replace("\n","%20",$singlesmsmsg1);
$singlesmsmsg3 = str_replace("&","%26",$singlesmsmsg2);
$singlesmsmsg4 = str_replace("+","%2B",$singlesmsmsg3);
#$smsmobileno="9320214357";
$smsmobileno=$mobilemo;
$smsc1='http://www.smscountry.com/SMSCwebservice.asp?User=technoinfotech&passwd=DVD2020SG&mobilenumber=91'.$smsmobileno.'&message='.$singlesmsmsg4.'&sid=InvMail&mtype=N&DR=Y';
#print "$smsc1";
 $rr = new HTTPRequest($smsc1);
       $ghr = $rr->DownloadToString();


### Send SMS here -end

//if($fastcontrolusername != "" and $mobilenumberfc != "" and $emailidfc != "" ){

$fcinsert12="insert into `onlinepasswordrequest` (`rid`, `CreateUser`, `CreateDatetime`, `CreateDate`, `DataFrom`, `Domain_Name`,`Cl_Code`, `Long_Name`, `Address_1`, `Address_2`, `Address_3`, `City`, `State`, `Zip`, `DateOfBirth`, `Mobile_Pager`, `Email`, `Password`, `ValidUser`, `SystemStatus`, `SystemPassword`, `Userfirstlogin`, `ForcePasswordChange`, `Uploaduniqueid`,`Update_User`, `Update_Datetime`, `Basic_Reasons`, `Internal_Note`, `Send_SMS_Message`, `Send_Email_Message`, `Send_Email_Subject`, `Send_Email_DeliveryStatus`) VALUES ('','onlineforgotpassword','$daterash','$datefc','web','$Domain_Name','$fastcontrolusername','$longnamefc','$address1fc','$address2fc','$address3fc','$cityfc','$statefc','$zipfc','$dateofbirthfc','$mobilenumberfc','$emailidfc','$passwordre','Y','autoreply','','','','','','$daterash','','','$Sms_message','$dmsg','$Email_subjectr','')";
$gn=mysql_query($fcinsert12);
#$bn=mysql_query($fcinsert);
//echo "Request has been submitted";
//}


$msgfc="<center><b><h1><u>TechnoMail Password Request</h1></u><font size=4 color=green>You will shortly receive an SMS on your personal Mobile registered with us, for your TechnoMail email account <font color=blue>".$fastcontrolusername."@TechnoMail.in </font></b></center>";

}

$mnbselvu="select * from `onlinepasswordrequest` where `Cl_Code`='$fastcontrolusername' and `Domain_Name`='$Domain_Name' and `ValidUser`='W' and `CreateDate`='$datefc'";
$vut = mysql_query($mnbselvu);
$numon=mysql_num_rows($vut);
 
 


if($numon != 0){
$msgfc="<center><b><h1><u>TechnoMail Password Request</h1></u><font size=4 color=green> Your TechnoMail Password Request for today is already in process.<br>You will receive new password via SMS on your personal Mobile within few minutes  (Most case ASAP).</font></b></center>";

}

if($mobilemo != $mobilenumberfc && $userdvdok==1)
{
$msgfc="<center><b><h1><u>TechnoMail Password Request</h1></u><font size=4 color=red>You have enter the incorrect mobile number for your Investormail email account <font color=blue>".$fastcontrolusername."@investormail.in.</font><br>Please re-enter the Mobile number which you have register with us for TechnoMail.in account for receiving password via SMS.</font></b></center>";
}


 


$bn=mysql_query($fcinsert);
print "<center><img src=\"/technomail.png\"></center>";
echo $msgfc;
exit;
}
else
{
 //     echo 'CAPTHCA is not valid; ignore submission';
$msgh="<font color=red>Enter invalid characters</red>";
}


?>


<html>
<head>
<meta http-equiv="content-type" content="text/html;charset=ISO-8859-1">
<title>TechnoMail Password Request</title>
<SCRIPT LANGUAGE="JavaScript">

function validatePwd(fieldname) {
var errorMsg = "";
var space  = " ";
var msgfc="<?=$msgfc?>";
//alert (msgfc);
fieldname   = document.myForm.fastcontrolusername;
fld13=document.myForm.mobilenumberfc;
fieldvalue  = fieldname.value;
valfld13  = mobilenumberfc.value;


fieldlength = fieldvalue.length;
//alert(fieldvalue+">>"+vv);
if (fieldvalue== "" || valfld13==""
){
// errorMsg += tu+"\nplease enter value.\n";
alert ("\nPlease enter all fields properly.\n");
return false;
}
if (!(valfld13.match(/[0-9]/))) {
alert ("\nPlease enter valid mobile number.\n");
return false;
}


vallen=valfld13.length;
if(!(vallen >= 10)){
alert ("\nMobile number should be 10 digit.\n");
return false;

}




return true;
}

</script>


</head>

  <body>
<center><img src="/technomail.png" align=center></center>
<form name="myForm" method=post action="" onSubmit="return validatePwd('fastcontrolusername','longnamefc')">
<?

?>
<div id="header">
	<table  align=center cellpadding="3" cellspacing="1" bgcolor="#6699cc">
<tbody>					

<tr>
		<th colspan="2" bgcolor='#fffff'><font face='verdana, arial, helvetica' size='2' align='center'>TechnoMail Password Request <font color=red>(All fields are compulsory.) </font></font></th>

	</tr>				

<tr bgcolor="#FFFFFF">
		<td align="left">
			<b>TechnoMail Username:</b>
		</td>
		<td align="left">

			<input name="fastcontrolusername" id="fastcontrolusername" value="<?=$_POST["fastcontrolusername"]?>" size="30" maxlength="100" type="text">&nbsp;<b><font color="blue">@TechnoMail.in</font></b></td>
</tr>
<!--
<tr bgcolor="#FFFFFF">
                <td align="left" >
                        <b>Full Name:</b>
                </td>
                <td align="left">

                        <input name="longnamefc" id="longnamefc" value="<?=$_POST["longnamefc"]?>" size="30" maxlength="100" type="text">&nbsp;
                </td>
</tr>

<tr bgcolor="#FFFFFF">
                <td align="left">
                        <b>Address 1:</b>
                </td>

                <td align="left">

                        <input name="address1fc" id="address1fc" value="<?=$_POST["address1fc"]?>" size="30" maxlength="100" type="text">&nbsp;
                </td>
</tr>

<tr bgcolor="#FFFFFF">
                <td align="left">
                        <b>Address 2:</b>

                </td>
                <td align="left">

                        <input name="address2fc" id="address2fc" value="<?=$_POST["address2fc"]?>" size="30" maxlength="100" type="text">&nbsp;
                </td>
</tr>
<tr bgcolor="#FFFFFF">
                <td align="left">
                        <b>Address 3:</b>

                </td>
                <td>

                        <input name="address3fc" id="address3fc" size="30" value="<?=$_POST["address3fc"]?>" maxlength="100" type="text">&nbsp;
                </td>
</tr>
<tr bgcolor="#FFFFFF">
                <td>
                       <b>City:</b>

                </td>
                <td >

                        <input name="cityfc" id="cityfc" size="30" value="<?=$_POST["cityfc"]?>" maxlength="100" type="text">&nbsp;
                </td>
</tr>
<tr bgcolor="#FFFFFF">
                <td align="left">
                        <b>State:</b>

                </td>
                <td>

                        <input name="statefc" id="statefc" size="30" value="<?=$_POST["statefc"]?>" maxlength="100" type="text">&nbsp;
                </td>
</tr>
<tr bgcolor="#FFFFFF">
                <td align="left">
                        <b>Zip:</b>

                </td>
                <td>

                        <input name="zipfc" id="zipfc" size="30" value="<?=$_POST["zipfc"]?>"  maxlength="100" type="text">&nbsp;
                </td>
</tr>
<tr bgcolor="#FFFFFF">
                <td align="left">
                       <b>Date Of Birth:</b>

                </td>
                <td>    
     <select name="dateyy">
<option value="Year">Year</option>
 <?php
            for ($iy= 2010; $iy >= 1900; $iy--)
                {
		if($_POST['dateyy']==$iy){
			 echo "<option value=".$iy." selected>".$iy."</option>" ;
		}else{
                	echo "<option value=".$iy.">".$iy."</option>" ;
		}
                }
            ?>
</select>
     <select name="datemm" id= "datemm">
<option value="Month">Month</option>
<?php
  $montharray=array("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec");
foreach($montharray as $montharrayval){
//foreach($monthval as 
if($_POST['datemm']== $montharrayval){
                         echo "<option value=".$montharrayval." selected>".$montharrayval."</option>" ;
                }else{
echo "<option value=".$montharrayval.">".$montharrayval."</option>" ;

}
}
?>
</select>
<select name="datedd">
<option value="Day">Day</option>
<?php
 $datearray=array("01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31");
foreach($datearray as $datearrayval){
//foreach($monthval as
if($_POST['datedd']== $datearrayval){
                         echo "<option value=".$datearrayval." selected>".$datearrayval."</option>" ;
                }else{
echo "<option value=".$datearrayval.">".$datearrayval."</option>" ;

}
}

            ?>

</select> <b> <font size=2>(YYYY-MM-DD)</b></font>
 </td>



</tr>
-->
<tr bgcolor="#FFFFFF">
                <td align="left" >
                        <b>Mobile (10 digit):</b>

                </td>
                <td >

                        <input name="mobilenumberfc" id="mobilenumberfc" value="<?=$_POST["mobilenumberfc"]?>"  size="30" maxlength="100" type="text">&nbsp;

                </td>
</tr>
<!-- 
<tr bgcolor="#FFFFFF">
                <td align="left" >
                      <b>Personal Email ID:</b>

                </td>
                <td >

                        <input name="emailidfc" id="emailidfc" value="<?=$_POST["emailidfc"]?>" size="30" maxlength="100" type="text">&nbsp;

                </td>
</tr>
 -->
<tr bgcolor="#FFFFFF">
<td  colspan="3" align="center" >
 <table><tr><td align="center">
<img src="CaptchaSecurityImages.php?width=100&height=40&characters=5" /></td></tr>
<tr><td align="center">
                <label for="security_code"><b>Security Code: </b></label><input id="security_code" name="security_code" type="text" /></td></tr>

<tr><td  align="center" colspan="5">
<?php echo $msgh; ?>
</td>
</tr>
</table>
</td>
</tr>

<tr colspan="2" align="center">
<td colspan="2" align="center">
                        <input type="submit" value="Submit detail for password reset." name="submit" id="submit"> &nbsp;&nbsp;&nbsp;&nbsp;
</td>
</tr>
</tbody>
</table>

    </form>

  </body>
</html>
