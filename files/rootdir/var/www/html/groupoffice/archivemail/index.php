<?php
ob_start();
session_name('groupoffice');

session_start();
##include_once("customerdb.php");
$loginok=0;
$globalwebmailuser=$_SESSION['GO_SESSION']['username'];

#print "--> $globalwebmailuser";



function encode($string,$key) {
$j=0;
$key = sha1($key);
$strLen = strlen($string);
$keyLen = strlen($key);
for ($i = 0; $i < $strLen; $i++) {
$ordStr = ord(substr($string,$i,1));
if ($j == $keyLen) { $j = 0; }
$ordKey = ord(substr($key,$j,1));
$j++;
$hash .= strrev(base_convert(dechex($ordStr + $ordKey),16,36));
}
return $hash;
}
function decode($string,$key) {
$key = sha1($key);
$strLen = strlen($string);
$keyLen = strlen($key);
for ($i = 0; $i < $strLen; $i+=2) {
$ordStr = hexdec(base_convert(strrev(substr($string,$i,2)),36,16));
if ($j == $keyLen) { $j = 0; }
$ordKey = ord(substr($key,$j,1));
$j++;
$hash .= chr($ordStr - $ordKey);
}
return $hash;
}

$encoded = encode($globalwebmailuser , "getkeynowxyz");
#echo $encoded;
#echo "\n";
$decoded = decode($encoded, "getkeynowxyz");
#echo $decoded;
#echo "\n";


$cookie_name = "mailarchiveid";
$cookie_value = $encoded;
setcookie($cookie_name, $cookie_value, time() + (86400 * 30), "/"); // 86400 = 1 day


header("location:/archivesearch/index.php?");
exit;


?>
