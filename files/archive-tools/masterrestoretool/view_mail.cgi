#!/usr/bin/perl
# view_mail.cgi
# View a single email message 
require './mailboxes-lib.pl';
#print "Set-Cookie: banner=1; path=/\r\n";
#$sec = uc($ENV{'HTTPS'}) eq 'ON' ? "; secure" : "";
#print "Set-Cookie: banner=0; path=/$sec\r\n";
#print "Set-Cookie: testing=1; path=/$sec\r\n";
#print "Set-Cookie: Session=106fdbfe51628523ce7846f29a921b8549; path=/$sec\r\n";
#print "Set-Cookie: sid=d15ff87cce431e45a1a5c954c3706cd0; path=/$sec\r\n";
#print "Set-Cookie: $config{'sidname'}=x; path=/$sec\r\n";

$force_charset = '';
&ReadParse();
#print %in;
if(defined $in{'myemailfile'})
{
$in{'user'}="rr";
$in{'idx'}=0;
$in{'folder'}=0;
$uuser="rr";
$mail=&read_mail_file($in{'myemailfile'})
}
else
{
&can_user($in{'user'}) || &error($text{'mail_ecannot'});
if (&is_user($in{'user'})) {
	@uinfo = &get_mail_user($in{'user'});
	}

$uuser = &urlize($in{'user'});
@folders = &list_user_folders($in{'user'});
$folder = $folders[$in{'folder'}];

@mail = &mailbox_list_mails($in{'idx'}, $in{'idx'}, $folder);
#print @mail;
$mail = $mail[$in{'idx'}];
}
#print $mail;
#open(MYFILE,"</home/mailadmin/rohitemail");
#%myemail=<MYFILE>;
#close(MYFILE);
#$mail=\%myemail;
#$in{'sub'}=1;
&parse_mail($mail, undef, $in{'raw'});
@sub = split(/\0/, $in{'sub'});
$subs = join("", map { "&sub=$_" } @sub);
foreach $s (@sub) {
        # We are looking at a mail within a mail ..
        local $amail = &extract_mail($mail->{'attach'}->[$s]->{'data'});
        &parse_mail($amail, undef, $in{'raw'});
        $mail = $amail;
        }

dbmopen(%read, "$module_config_directory/$in{'user'}.read", 0600);
eval { $read{$mail->{'header'}->{'message-id'}} = 1 }
	if (!$read{$mail->{'header'}->{'message-id'}});

if ($in{'raw'}) {
	# Special mode - viewing whole raw message
	print "Content-type: text/plain\n\n";

	if ($mail->{'fromline'}) {
		print $mail->{'fromline'},"\n";
		}
	if (defined($mail->{'rawheaders'})) {
		#$mail->{'rawheaders'} =~ s/(\S)\t/$1\n\t/g;
		print $mail->{'rawheaders'};
		}
	else {
		foreach $h (@{$mail->{'headers'}}) {
			#$h->[1] =~ s/(\S)\t/$1\n\t/g;
			print "$h->[0]: $h->[1]\n";
			}
		}
	print "\n";
	print $mail->{'body'};
	exit;
	}
#print $folder;
# Find body attachment and type
($textbody, $htmlbody, $body) = &find_body($mail, $config{'view_html'});
$body = $htmlbody if ($in{'body'} == 2);
$body = $textbody if ($in{'body'} == 1);
@attach = @{$mail->{'attach'}};

# Show pre-body HTML
if ($body && $body eq $htmlbody) {
	$headstuff = &head_html($body->{'data'});
	}

&ui_print_header(undef, $text{'view_title'}, "", undef, 0, 0, undef,
	&folder_link($in{'user'}, $folder), $headstuff);
print &check_clicks_function();
#print "here";
print "<center>\n";
#print %config;
print $ENV{'REMOTE_PASS'};
#print $ENV{'PASS'};
#print %myemail;
#print  %{$folder};
#print $fld->{file};
#print $in{'raw'}."rohit";
#print $module_config_directory;
#print %$folder;
#foreach $keyval(keys %folder)
#{
#print $folder{$keyval}."\n";

#}
if (!@sub) {
	if ($in{'idx'}) {
		print "<a href='view_mail.cgi?idx=",
		      $in{'idx'}-1,"&folder=$in{'folder'}&user=$uuser'&myemailfile=$in{'myemailfile'}>",
		      "<img src=/images/left.gif border=0 ",
		      "align=middle></a>\n";
		}
	print "<font size=+1>",&text('view_desc', $in{'idx'}+1,
			$folder->{'name'}),"</font>\n";
	if ($in{'idx'} < @mail-1) {
		print "<a href='view_mail.cgi?idx=",
		      $in{'idx'}+1,"&folder=$in{'folder'}&user=$uuser'&myemailfile=$in{'myemailfile'}>",
		      "<img src=/images/right.gif border=0 ",
		      "align=middle></a>\n";
		}
	}
else {
	print "<font size=+1>$text{'view_sub'}</font>\n";
	}
print "</center>\n";

print "<form action=reply_mail.cgi>\n";
print "<input type=hidden name=user value='$in{'user'}'>\n";
print "<input type=hidden name=myemailfile value='$in{'myemailfile'}'>\n";
print "<input type=hidden name=idx value='$in{'idx'}'>\n";
print "<input type=hidden name=folder value='$in{'folder'}'>\n";
print "<input type=hidden name=mod value=",&modification_time($folder),">\n";
foreach $s (@sub) {
	print "<input type=hidden name=sub value='$s'>\n";
	}

# Find any delivery status attachment
($dstatus) = grep { $_->{'type'} eq 'message/delivery-status' } @attach;

# Strip out attachments not to display as icons
@attach = grep { $_ ne $body && $_ ne $dstatus } @attach;
@attach = grep { !$_->{'attach'} } @attach;

if ($config{'top_buttons'} == 2 && &editable_mail($mail)) {
	&show_mail_buttons(1, scalar(@sub));
	print "<p>\n";
	}

print "<table width=100% border=1>\n";
print "<tr> <td $tb><table width=100% cellpadding=0 cellspacing=0><tr>",
      "<td><b>$text{'view_headers'}</b></td> <td align=right>\n";
if ($in{'headers'}) {
	print "<a href='view_mail.cgi?idx=$in{'idx'}&body=$in{'body'}&folder=$in{'folder'}&user=$uuser&headers=0$subs&myemailfile=$in{'myemailfile'}'>$text{'view_noheaders'}</a>\n";
	}
else {
	print "<a href='view_mail.cgi?idx=$in{'idx'}&body=$in{'body'}&folder=$in{'folder'}&user=$uuser&headers=1$subs&myemailfile=$in{'myemailfile'}'>$text{'view_allheaders'}</a>\n";
	}
print "&nbsp;&nbsp;<a href='view_mail.cgi?idx=$in{'idx'}&folder=$in{'folder'}&user=$uuser&raw=1$subs&myemailfile=$in{'myemailfile'}'>$text{'view_raw'}</a></td>\n";
print "</tr></table></td> </tr>\n";

print "<tr> <td $cb><table width=100%>\n";
if ($in{'headers'}) {
	# Show all the headers
	if ($mail->{'fromline'}) {
		print "<tr> <td><b>$text{'mail_rfc'}</b></td>",
		      "<td>",&eucconv_and_escape($mail->{'fromline'}),
		      "</td> </tr>\n";
		}
	foreach $h (@{$mail->{'headers'}}) {
		print "<tr> <td><b>$h->[0]:</b></td> ",
		      "<td>",&eucconv_and_escape(&decode_mimewords($h->[1])),
		      "</td> </tr>\n";
		}
	}
else {
	# Just show the most useful headers
	print "<tr> <td><b>$text{'mail_from'}</b></td> ",
	      "<td>",&address_link($mail->{'header'}->{'from'}),"</td> </tr>\n";
	print "<tr> <td><b>$text{'mail_to'}</b></td> ",
	      "<td>",&address_link($mail->{'header'}->{'to'}),"</td> </tr>\n";
	print "<tr> <td><b>$text{'mail_cc'}</b></td> ",
	      "<td>",&address_link($mail->{'header'}->{'cc'}),"</td> </tr>\n"
		if ($mail->{'header'}->{'cc'});
	print "<tr> <td><b>$text{'mail_date'}</b></td> ",
	      "<td>",&eucconv_and_escape($mail->{'header'}->{'date'}),
	      "</td> </tr>\n";
	print "<tr> <td><b>$text{'mail_subject'}</b></td> ",
	      "<td>",&eucconv_and_escape(&decode_mimewords(
			$mail->{'header'}->{'subject'})),"</td> </tr>\n";
	}
print "</table></td></tr></table><p>\n";

# Show body attachment, with properly linked URLs
if ($body && $body->{'data'} =~ /\S/) {
	if ($body eq $textbody) {
		# Show plain text
		$bodycontents = "<pre>";
		foreach $l (&wrap_lines(&eucconv($body->{'data'}),
					$config{'wrap_width'})) {
			$bodycontents .= &link_urls_and_escape($l)."\n";
			}
		$bodycontents .= "</pre>";
		if ($htmlbody) {
			$bodyright = "<a href='view_mail.cgi?idx=$in{'idx'}&headers=$in{'headers'}&folder=$in{'folder'}&user=$uuser&body=2$subs&myemailfile=$in{'myemailfile'}'>$text{'view_ashtml'}</a>";
			}
		}
	elsif ($body eq $htmlbody) {
		# Attempt to show HTML
		$bodycontents = &safe_html($body->{'data'});
		$bodycontents = &fix_cids($bodycontents, \@attach,
			"detach.cgi?user=$uuser&idx=$in{'idx'}&folder=$in{'folder'}$subs&myemailfile=$in{'myemailfile'}");
		if ($textbody) {
			$bodyright = "<a href='view_mail.cgi?idx=$in{'idx'}&headers=$in{'headers'}&folder=$in{'folder'}&user=$uuser&body=1$subs&myemailfile=$in{'myemailfile'}'>$text{'view_astext'}</a>";
			}
		}
	}
if ($bodycontents) {
	print "<table width=100% border=1>\n";
	print "<tr $tb> <td><table width=100% cellpadding=0 cellspacing=0><tr>",
	      "<td><b>$text{'view_body'}</b></td> ",
	      "<td align=right>$bodyright</td> </tr></table></td> </tr>\n";
	print "<tr $cb> <td>\n";
	print $bodycontents;
	print "</pre></td></tr></table><p>\n";
	}

# Show delivery status
if ($dstatus) {
	print "<table width=100% border=1>\n";
	print "<tr> <td $tb><b>$text{'view_dstatus'}</b></td> </tr>\n";
	print "<tr> <td $cb><table>\n";

	local $ds = &parse_delivery_status($dstatus->{'data'});
	foreach $dsh ('final-recipient', 'diagnostic-code',
		      'remote-mta', 'reporting-mta') {
		if ($ds->{$dsh}) {
			$ds->{$dsh} =~ s/^\S+;//;
			print "<tr> <td nowrap valign=top><b>",
			      $text{'view_'.$dsh},"</b></td>\n";
			print "<td>",&html_escape($ds->{$dsh}),"</td> </tr>\n";
			}
		}

	print "</table></td></tr></table><p>\n";
	}

# Display other attachments
if (@attach) {
	print "<table width=100% border=1>\n";
	print "<tr> <td $tb><b>$text{'view_attach'}</b></td> </tr>\n";
	print "<tr> <td $cb>\n";
	foreach $a (@attach) {
		local $fn;
		$size = (int(length($a->{'data'})/1000)+1)." Kb";
		local $cb;
		if ($a->{'type'} eq 'message/rfc822') {
			push(@titles, "$text{'view_sub'}<br>$size");
			}
		elsif ($a->{'filename'}) {
			push(@titles, &decode_mimewords($a->{'filename'}).
				      "<br>$size");
			$fn = &decode_mimewords($a->{'filename'});
			push(@detach, [ $a->{'idx'}, $fn ]);
			}
		else {
			push(@titles, "$a->{'type'}<br>$size");
			$a->{'type'} =~ /\/(\S+)$/;
			$fn = "file.$1";
			push(@detach, [ $a->{'idx'}, $fn ]);
			}
		if ($a->{'error'}) {
			$titles[$#titles] .= "<br><font size=-1>($a->{'error'})</font>";
			}
		$fn =~ s/ /_/g;
		$fn =~ s/\#/_/g;
		$fn = &html_escape($fn);
		if ($a->{'type'} eq 'message/rfc822') {
			push(@links, "view_mail.cgi?idx=$in{'idx'}&folder=$in{'folder'}&user=$uuser$subs&sub=$a->{'idx'}&myemailfile=$in{'myemailfile'}");
			}
		else {
			push(@links, "detach.cgi/$fn?idx=$in{'idx'}&folder=$in{'folder'}&user=$uuser&attach=$a->{'idx'}$subs&myemailfile=$in{'myemailfile'}");
			}
		if ($config{'thumbnails'} &&
		    ($a->{'type'} =~ /image\/gif/i && &has_command("giftopnm")&&
		     &has_command("pnmscale") && &has_command("cjpeg") ||
		     $a->{'type'} =~ /image\/jpeg/i && &has_command("djpeg") &&
		     &has_command("pnmscale") && &has_command("cjpeg"))) {
			# Can show an image icon
			push(@icons, "detach.cgi?scale=1&idx=$in{'idx'}&folder=$in{'folder'}&attach=$a->{'idx'}$subs&myemailfile=$in{'myemailfile'}");
			$imgicons++;
			}
		else {
			push(@icons, "images/boxes.gif");
			}
		}
	&icons_table(\@links, \@titles, \@icons, 6, undef,
		     $imgicons ? ( 0, 0 ) : ( ));
	if ($access{'candetach'} && @detach && defined($uinfo[2])) {
		print "<input type=submit name=detach value='$text{'view_detach'}'>\n";
		print "<input type=hidden name=bindex value='$body->{'idx'}'>\n" if ($body);
		print "<select name=attach>\n";
		print "<option value=*>$text{'view_dall'}\n";
		foreach $a (@detach) {
			printf "<option value=%s>%s\n",
				$a->[0], $a->[1];
			}
		print "</select>\n";
		print "<b>$text{'view_dir'}</b>\n";
		print "<input name=dir size=40> ",
			&file_chooser_button("dir", 1),"\n";
		}
	print "</td></tr></table><p>\n";
	}

&show_mail_buttons(2, scalar(@sub)) if (&editable_mail($mail));
print "</form>\n";

dbmclose(%read);

local @sr = !@sub ? ( ) :
    ( "view_mail.cgi?idx=$in{'idx'}", $text{'view_return'} ),
$s = int((@mail - $in{'idx'} - 1) / $config{'perpage'}) *
	$config{'perpage'};
&ui_print_footer(@sub ? ( "view_mail.cgi?idx=$in{'idx'}&folder=$in{'folder'}&user=$uuser&myemailfile=$in{'myemailfile'}",
		 $text{'view_return'} ) : ( ),
	"list_mail.cgi?folder=$in{'folder'}&user=$uuser", $text{'mail_return'},
	"", $text{'index_return'});

# show_mail_buttons(pos, submode)
sub show_mail_buttons
{
local $spacer = "&nbsp;\n";
if (!$_[1]) {
#	print "<input type=submit value=\"$text{'view_delete'}\" name=delete ",
#	      "onClick='return check_clicks(form)'>";
	print $spacer;

	if (!$folder->{'sent'} && !$folder->{'drafts'}) {
		$m = $read{$mail->{'header'}->{'message-id'}};
#		print "<input name=mark$_[0] type=submit value=\"$text{'view_mark'}\">";
#		print "<select name=mode$_[0]>\n";
#		foreach $i (0 .. 2) {
#			printf "<option value=%d %s>%s\n",
#				$i, $m == $i ? 'selected' : '', $text{"view_mark$i"};
#			}
#		print "</select>";
		print $spacer;
		}
	}
if (&is_user($in{'user'})) {
	print "<input type=submit value=\"$text{'view_forward'}\" name=\"forward\">";
	print $spacer;
	}

#print "<input type=submit value=\"$text{'view_print'}\" name=print>";
print $spacer;

if (&is_user($in{'user'})) {
#	print "<input type=submit value=\"$text{'view_reply'}\" name=reply>";
#	print "<input type=submit value=\"$text{'view_reply2'}\" name=rall>";
	print $spacer;
	}

#print "<input type=submit value=\"$text{'view_strip'}\" name=strip>";
print $spacer;

# Show spam report buttons
@modules = &get_available_module_infos(1);
($hasspam) = grep { $_->{'dir'} eq "spam" } @modules;
if (&foreign_installed("spam") &&
    $config{'spam_buttons'} =~ /mail/ &&
    &spam_report_cmd($in{'user'})) {
	if ($hasspam) {
#		print "<input type=submit value=\"$text{'view_black'}\" name=black>";
		}
	if ($config{'spam_del'}) {
#		print "<input type=submit value=\"$text{'view_razordel'}\" name=razor>\n";
		}
	else {
#		print "<input type=submit value=\"$text{'view_razor'}\" name=razor>\n";
		}
	}
print "<br>\n";
}

# address_link(address)
sub address_link
{
local @addrs = &split_addresses(&decode_mimewords($_[0]));
local @rv;
foreach $a (@addrs) {
	push(@rv, &eucconv_and_escape($a->[2]));
	}
return join(" , ", @rv);
}

