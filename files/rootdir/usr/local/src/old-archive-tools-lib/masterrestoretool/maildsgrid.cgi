#!/usr/bin/php
<?php
#mysql_pconnect("localhost", "root", "") or die("Could not connect");
#mysql_select_db("demo") or die("Could not select database");

print "Content-type: text/html\n\n";
include_once("dbinfo.php");

$start = ($_REQUEST["start"] == null)? 0 : $_REQUEST["start"];
$count = ($_REQUEST["limit"] == null)? 20 : $_REQUEST["limit"];
$sort = ($_REQUEST["sort"] == null)? "" : $_REQUEST["sort"];
$dir = ($_REQUEST["dir"] == "desc")? "DESC" : "";
$filter = $_REQUEST["filter"];

$where = " 0 = 0 ";
if (is_array($filter)) {
	for ($i=0;$i<count($filter);$i++){
		switch($filter[$i]['data']['type']){
			case 'string' : $qs .= " AND ".$filter[$i]['field']." LIKE '%".$filter[$i]['data']['value']."%'"; Break;
			case 'list' : 
				if (strstr($filter[$i]['data']['value'],',')){
					$fi = explode(',',$filter[$i]['data']['value']);
					for ($q=0;$q<count($fi);$q++){
						$fi[$q] = "'".$fi[$q]."'";
					}
					$filter[$i]['data']['value'] = implode(',',$fi);
					$qs .= " AND ".$filter[$i]['field']." IN (".$filter[$i]['data']['value'].")"; 
				}else{
					$qs .= " AND ".$filter[$i]['field']." = '".$filter[$i]['data']['value']."'"; 
				}
			Break;
			case 'boolean' : $qs .= " AND ".$filter[$i]['field']." = ".($filter[$i]['data']['value']); Break;
			case 'numeric' : 
				switch ($filter[$i]['data']['comparison']) {
					case 'eq' : $qs .= " AND ".$filter[$i]['field']." = ".$filter[$i]['data']['value']; Break;
					case 'lt' : $qs .= " AND ".$filter[$i]['field']." < ".$filter[$i]['data']['value']; Break;
					case 'gt' : $qs .= " AND ".$filter[$i]['field']." > ".$filter[$i]['data']['value']; Break;
				}
			Break;
			case 'date' : 
				switch ($filter[$i]['data']['comparison']) {
					case 'eq' : $qs .= " AND ".$filter[$i]['field']." = '".date('Y-m-d',strtotime($filter[$i]['data']['value']))."'"; Break;
					case 'lt' : $qs .= " AND ".$filter[$i]['field']." < '".date('Y-m-d',strtotime($filter[$i]['data']['value']))."'"; Break;
					case 'gt' : $qs .= " AND ".$filter[$i]['field']." > '".date('Y-m-d',strtotime($filter[$i]['data']['value']))."'"; Break;
				}
			Break;
		}
	}	
	$where .= $qs;
}

$query = "SELECT * FROM `mailstatus`".$where;
if ($sort != "") {
	$query .= " ORDER BY ".$sort." ".$dir;
}
$query .= " LIMIT ".$start.",".$count;

$rs = mysql_query($query);
$total = mysql_query("SELECT COUNT(id) FROM demo WHERE ".$where);
$total = mysql_result($total, 0, 0);
print "{\"meta\":{\"code\":1,\"exception\":[],\"success\":true,\"message\":null},\"data\":{\"total\":".$rows.",\"results\":[";
while(@row = $execute->fetchrow($rs))
{
$e++;
print "{";
$msgfilename=$row[0];
print "\"msgfilename\":\"".$msgfilename."\",";
$msgfilename =~ s/\+/ /g;
$mailondate=$row[1];
print "\"mailondate\":\"".$mailondate."\",";
$mailondate =~ s/\+/ /g;
$from=$row[2];
print "\"from\":\"".$from."\",";
$from =~ s/\+/ /g;
$to=$row[3];
print "\"to\":\"".$to."\",";
$to =~ s/\+/ /g;
$size=$row[4];
print "\"size\":\"".$size."\",";
$size =~ s/\+/ /g;
$subject=$row[5];
print "\"subject\":\"".$subject."\",";
$subject =~ s/\+/ /g;
$asondate=$row[6];
print "\"asondate\":\"".$asondate."\"";
$asondate =~ s/\+/ /g;
}
print "]}}";
print"\n";

#$arr = array();
#while($obj = mysql_fetch_object($rs)) {
#	$arr[] = $obj;
#}
#print'{"total":"'.$total.'","results":'.($arr).'}';
#echo '{"total":"'.$total.'","data":'.json_encode($arr).'}';
?>
