#!/opt/lampp/bin/perl
use DBI;
use databaseconnect;
#use XML::DOM;
#use XML::Simple;
sub ReadParse
{
local $a = $_[0] ? $_[0] : \%in;
%$a = ( );
local $i;
local $meth = $_[1] ? $_[1] : $ENV{'REQUEST_METHOD'};
undef($in);
if ($meth eq 'POST') {
        read(STDIN, $in, $ENV{'CONTENT_LENGTH'});
        }
if ($ENV{'QUERY_STRING'}) {
        if ($in) { $in .= "&".$ENV{'QUERY_STRING'}; }
        else { $in = $ENV{'QUERY_STRING'}; }
        }
@in = split(/\&/, $in);
foreach $i (@in) {
        local ($k, $v) = split(/=/, $i, 2);
if($k eq "myquery")
{
$vv=$v;        
}
if (!$_[2]) {
                $k =~ tr/\+/ /;
                $v =~ tr/\+/ /;
                }
$k =~ s/%(..)/pack("c",hex($1))/ge;
        $v =~ s/%(..)/pack("c",hex($1))/ge;
       # $k =~ s/%(\d\d)/pack("c",hex($1))/ge;

# $v =~ s/%(\d\d)/pack("c",hex($1))/ge;


       $a->{$k} = defined($a->{$k}) ? $a->{$k}."\0".$v : $v;
        }
}
&ReadParse;

#my $parser=XML::DOM::Parser->new();

#my $doc=$parser->parsefile($in{data});

#$xml = new XML::Simple;
#$data = $xml->XMLin("mynewxml.xml");
$in{databasename}="qmaillog";
$in{hostname}="172.16.0.241";
$in{username}="qmaillog";
$in{password}="qmail2007";
$in{databasetype}="mysql";

#$in{databasename}=$data->{DATABASE};
#$in{hostname}=$data->{HOSTNAME};
#$in{username}=$data->{USERNAME};
#$in{password}=$data->{PASSWORD};
#print  "Content-type: text/html\n\n";
#print "$in{torec}"."=========";
#print %in;
#die();
my $dbcnt=new databaseconnect() or die "cannot connect to database";

my $mylink=$dbcnt->connectit($in{hostname},$in{databasetype},$in{databasename},$in{username},$in{password});
#$selquery="select id,email1,email2,website,industry from accounts where website like '\%$in{'website'}\%'";
#$selquery="select `from`,`to`,`time_end_msg_log`,`success_message` from `generallog`";
#################################query buildup here############################################################
$myquery="select ";
$count=0;
#sort %in;
foreach $myline(sort keys %in)
{
$cmm="";
if($in{$myline} eq "fromaddr")
{
if($count > 0)
{
$cmm=",";
}

$myquery.=$cmm."`bounce_mail_from`";
$count++;
}
if($in{$myline} eq "toaddr")
{
if($count > 0)
{
$cmm=",";
}
$myquery.=$cmm."`bounce_mail_to`";
$count++;
}
if($in{$myline} eq "qmailsubject")
{
if($count > 0)
{
$cmm=",";
}

$myquery.=$cmm."`bounce_mail_subject`";
$count++;
}
if($in{$myline} eq "qmailattach")
{
if($count > 0)
{
$cmm=",";
}
$myquery.=$cmm."`qmail_attachment`";
$count++;
}
if($in{$myline} eq "date")
{
if($count > 0)
{
$cmm=",";
}

$myquery.=$cmm."Date_Format(bounce_mail_time_delivery_log,'\%d-\%m-\%Y')";
#$myquery.=$cmm."Date(time_end_msg_log)";
$count++;
}
if($in{$myline} eq "normalmailstatus")
{
if($count > 0)
{
$cmm=",";
}

$myquery.=$cmm."bounce_mail_normal_error";
$count++;
}
if($in{$myline} eq "techmailstatus")
{
if($count > 0)
{
$cmm=",";
}

$myquery.=$cmm."bounce_mail_technical_error";
$count++;
}
if($in{$myline} eq "archivefilename")
{
if($count > 0)
{
$cmm=",";
}

$myquery.=$cmm."bounce_mail_ms_archive_file";
$myfilecnt=$count;
$count++;
}
if($in{$myline} eq "archivelocation")
{
if($count > 0)
{
$cmm=",";
}

$myquery.=$cmm."bounce_mail_ms_archive_file_location_on_nas_server";
$mypathcnt=$count;
$count++;
}
if($in{$myline} eq "archivedvdname")
{
if($count > 0)
{
$cmm=",";
}

$myquery.=$cmm."bounce_mail_ms_archive_dvd_name";

$count++;
}
if($in{$myline} eq "archivedvddate")
{
if($count > 0)
{
$cmm=",";
}

$myquery.=$cmm."Date_Format(bounce_mail_ms_archive_dvd_date,'\%d-\%m-\%Y')";
$count++;
}
if($in{$myline} eq "archivedvdcount")
{
if($count > 0)
{
$cmm=",";
}

$myquery.=$cmm."bounce_mail_ms_archive_dvd_count";
$count++;
}
 }
$myquery.=" from bouncemail";
$whereclause=" where Date(bounce_mail_time_delivery_log) between '$in{frmFromYear}-$in{frmFromMonth}-$in{frmFromDay}' and '$in{frmToYear}-$in{frmToMonth}-$in{frmToDay}'";
if($in{frmExclude} ne "")
{
$whereclause.=" and `bounce_mail_to` not like '\%$in{frmExclude}\%'";
}
if($in{frmFromEmailId} ne "")
{

$whereclause.=" and `bounce_mail_from` like '\%$in{frmFromEmailId}\%'";
}
if($in{frmToEmailId} ne "")
{
$whereclause.=" and `bounce_mail_to` like '\%$in{frmToEmailId}\%'";
}
if($in{mysubject} ne "")
{
$whereclause.=" and `bounce_mail_subject` like '\%$in{mysubject}\%'";
}
if($in{myattachment} ne "")
{
$whereclause.=" and `qmail_attachment` like '\%$in{myattachment}\%'";
}
if($in{mynormalmail} ne "")
{
$whereclause.=" and `bounce_mail_normal_error` like '\%$in{mynormalmail}\%'";
}
if($in{mytechnicalmail} ne "")
{
$whereclause.=" and `bounce_mail_technical_error` like '\%$in{mytechnicalmail}\%'";
}

$myquery.=$whereclause;
if(!defined $in{fromrec} && !defined $in{torec})
{
$in{fromrec}=1;
$in{torec}=30;
}
else
{
$tomyrec=($in{torec} - $in{fromrec}) + 1;
if($in{fromrec}==1)
{
$frommyrec=$in{fromrec} - 1;
}
else
{
$frommyrec=$in{fromrec};

}
}
$myquery.=" Limit $frommyrec,$tomyrec";




$selquery=$myquery;
#################################################################################################################
#$selquery=$in{myquery};
#$selquery=$vv;
#$selquery =~ s/\%([A-Fa-f0-9]{2})/pack('C', hex($1))/seg;
#print $in{fromrec}."=========>";
#print $selquery;
#die();
#$$selquery="select `from`,`to`,Date_Format(time_end_msg_log,'\%d-\%m-\%Y'),time_end_msg_log,success_message,extra_info,ms_archive_file,ms_archive_file_location_on_nas_server,ms_archive_dvd_name,ms_archive_dvd_date,ms_archive_dvd_count from generallog where Date(time_end_msg_log) between '2006-12-20' and '2006-12-21'";
#print "hello".$selquery ;
#print $selquery;
#die();
my $sth=$dbcnt->myquery($mylink,$selquery) ;


#my $rows=$sth->rows;
print  "Content-type: text/xml\n\n";
print "<?xml version=\"1.0\" encoding=\"iso-8859-1\"?>\n";
print "<rows>\n";
$i=0;
$strt=$in{fromrec};
while(@getdata=$sth->fetchrow_array)
{
$mycount=@getdata;
#print "<row id=\"$getdata->{id}\">
 #               <cell>$getdata->{id}</cell>
 #              </row>\n";
#&lt;a href=&quot;yahoo.com&quot;&gt;$getdata[$m]&lt;a&gt;
     print "<row id=\"$i\">";
 print "<cell>$strt</cell>";
#$getdata[$m]="<a href="yahoo.com"
for($m=0;$m<$mycount;$m++)
{
if($in{myfilecnt}==$m)
{
print "<cell>&lt;a href=&quot;view_mail.cgi?myemailfile=$getdata[$in{mypathcnt}]$getdata[$in{myfilecnt}]&quot; target=&quot;_blank&quot;&gt;$getdata[$m]&lt;a&gt;</cell>";
} 
else
{
	$getdata[$m]=~ s/\&/"&amp;"/eg;
if($getdata[$m]=~/\</g)
{
#$getdata[$m]=~ s/\</"&lt;\!\[CDATA\[&lt;"/eg;
#$getdata[$m]=~ s/\</"&amp;lt;"/eg;
$getdata[$m]=~ s/\</"&amp;lt;"/eg;
$getdata[$m]=~ s/\>/"&amp;gt;"/eg;
}
#        $getdata[$m]=~ s/\</"&lt;"/eg;
#        $getdata[$m]=~ s/\>/"&gt;"/eg;
        $getdata[$m]=~ s/\"/"&quot;"/eg; 
        $getdata[$m]=~ s/\'/"&apos;"/eg;  
                print "<cell>$getdata[$m]</cell>";
}
} 
               print "</row>\n";


$i++;
$strt++;
}
print  "</rows>";




