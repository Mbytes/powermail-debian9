<?php
$serverrashsms="localhost";
$userrashsms="root";
$passwordrashsms="iball2010";
$databaserashsms="loginemailmap";
mysql_connect("$serverrashsms", "$userrashsms", "$passwordrashsms") or die(mysql_error());
//echo "Connected to MySQL<br />";
mysql_select_db("$databaserashsms") or die(mysql_error());
//echo "Connected to Database";
?>

