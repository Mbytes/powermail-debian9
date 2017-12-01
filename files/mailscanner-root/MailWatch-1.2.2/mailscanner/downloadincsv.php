<?php

$combosonlinedbhost="localhost";
$combosonlinedbuser="mailscanner";
$combosonlinedb="mailscanner";
$combosonlinedbpassword="fuxieg6M";


$combosonlinelink = mysqli_connect("$combosonlinedbhost", "$combosonlinedbuser", "$combosonlinedbpassword") or die("Could not connect $combosonlinedb ");

mysqli_select_db( $combosonlinelink, $combosonlinedb);

$sqlx= $_GET['sqlline'];
###$sqlx=$sqlx." limit 0, 10";
###print $sqlx;

$filex="ReportDownload-".time().".csv";
header('Content-Description: File Transfer');
    header('Content-Type: application/octet-stream');
    header('Content-Disposition: attachment; filename="'.$filex.'"');
    header('Expires: 0');
    header('Cache-Control: must-revalidate');
    header('Pragma: public');

######$sqlx="SELECT id AS id2, DATE_FORMAT(timestamp, '%d/%m/%y %H:%i:%s') AS datetime, from_address, to_address, subject, size, isspam, ishighspam, isrblspam, spamwhitelisted, spamblacklisted, virusinfected, nameinfected, otherinfected, sascore, report, ismcp, ishighmcp, mcpwhitelisted, mcpblacklisted, mcpsascore, '' AS status FROM maillog WHERE (1=1) AND (1=1) AND date = '2017-10-08' AND subject LIKE '%MOAMC PMS Report for the Month of Sep, 2017%' ORDER BY date DESC, time DESC limit 0, 10";

$rsa = mysqli_query($combosonlinelink,$sqlx);

$okgottree=0;
$gtree=array();
$ki=0;
$i = 0;
while ($i < mysqli_num_fields($rsa)){
$fld = mysqli_fetch_field($rsa);
if($i!=0){ print ",";}
print "\"".$fld->name."\"";
$i++;
}
while($obj = mysqli_fetch_array($rsa,MYSQLI_NUM)){
print "\n";
$i = 0;
while ($i < mysqli_num_fields($rsa)){
if($i!=0){print ",";}
print "\"".$obj[$i]."\"";
$i++;
}
}

print "\n";


?>
