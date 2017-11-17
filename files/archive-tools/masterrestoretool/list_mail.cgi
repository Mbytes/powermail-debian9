#!/usr/bin/perl
# list_mail.cgi
# List the mail messages for some user in some folder
require './mailboxes-lib.pl';
&ReadParse();
&can_user($in{'user'}) || &error($text{'mail_ecannot'});
&is_user($in{'user'}) || -e $in{'user'} || &error($text{'mail_efile'});

if ($config{'track_read'}) {
	dbmopen(%read, "$module_config_directory/$in{'user'}.read", 0600);
	}

&ui_print_header(undef, $text{'mail_title'}, "");
print &check_clicks_function();
@folders = &list_user_folders_sorted($in{'user'});
($folder) = grep { $_->{'index'} == $in{'folder'} } @folders;

# Get folder-selection HTML
$sel = &folder_select(\@folders, $folder, "folder");

# Work out start from jump page
$perpage = $folder->{'perpage'} || $config{'perpage'};
if ($in{'jump'} =~ /^\d+$/ && $in{'jump'} > 0) {
	$in{'start'} = ($in{'jump'}-1)*$perpage;
	}

# View mail from the most recent
@mail = reverse(&mailbox_list_mails(-$in{'start'},
				    -$in{'start'}-$perpage+1,
				    $folder, 1, \@error));
if ($in{'start'} >= @mail && $in{'jump'}) {
	# Jumped too far!
	$in{'start'} = @mail - $perpage;
	@mail = reverse(&mailbox_list_mails(-$in{'start'},
					    -$in{'start'}-$perpage+1,
					    $folder, 1, \@error));
	}
print "<center>\n";
print "<form action=list_mail.cgi><font size=+1>\n";
print "<input type=hidden name=user value='$in{'user'}'>\n";
if ($in{'start'}+$perpage < @mail) {
	printf "<a href='list_mail.cgi?start=%d&user=$in{'user'}&folder=%d'>%s</a>\n",
		$in{'start'}+$perpage, $in{'folder'},
		'<img src=/images/left.gif border=0 align=middle>';
	}

local $s = @mail-$in{'start'};
local $e = @mail-$in{'start'}-$perpage+1;
if (@mail) {
	print &text('mail_pos', $s, $e < 1 ? 1 : $e, scalar(@mail), $sel);
	}
else {
	print &text('mail_none', $sel);
	}
print "</font><input type=submit value='$text{'mail_fchange'}'>\n";

if ($in{'start'}) {
	printf "<a href='list_mail.cgi?start=%d&user=$in{'user'}&folder=%d'>%s</a>\n",
		$in{'start'}-$perpage, $in{'folder'},
		'<img src=/images/right.gif border=0 align=middle>';
	}
print "</form></center>\n";

print "<form action=delete_mail.cgi method=post>\n";
print "<input type=hidden name=user value='$in{'user'}'>\n";
print "<input type=hidden name=folder value='$folder->{'index'}'>\n";
print "<input type=hidden name=mod value=",&modification_time($folder),">\n";
print "<input type=hidden name=start value='$in{'start'}'>\n";
if ($config{'top_buttons'} && @mail) {
	&show_buttons(1, \@folders, $folder, \@mail, $in{'user'});
	print &select_all_link("d", 1, $text{'mail_all'}),"&nbsp;\n";
	print &select_invert_link("d", 1, $text{'mail_invert'}),"&nbsp;\n";
	}

$showto = $folder->{'sent'} || $folder->{'drafts'};
if (@mail) {
	print "<table border width=100%>\n";
	print "<tr $tb> <td>&nbsp;</td> ",
	      $showto ? "<td><b>$text{'mail_to'}</b></td>"
		       : "<td><b>$text{'mail_from'}</b></td> ",
	      $config{'show_to'} ? $showto ?
			"<td><b>$text{'mail_from'}</b></td>" :
			"<td><b>$text{'mail_to'}</b></td>" : "",
	      "<td><b>$text{'mail_date'}</b></td> ",
	      "<td><b>$text{'mail_size'}</b></td> ",
	      "<td><b>$text{'mail_subject'}</b></td> </tr>\n";
	}
if (@error) {
	print "<center><b><font color=#ff0000>\n";
	print &text('mail_err', $error[0] == 0 ? $error[1] :
			      &text('save_elogin', $error[1])),"\n";
	print "</font></b></center>\n";
	}
elsif (@error && $error[0] == 2) {
	}

for($i=$in{'start'}; $i<@mail && $i<$in{'start'}+$perpage; $i++) {
	local $idx = $mail[$i]->{'idx'};
	local $cols = 0;
	print "<tr $cb>\n";
	if (&editable_mail($mail[$i])) {
		print "<td><input type=checkbox name=d value=$idx></td>\n";
		}
	else {
		print "<td><br></td>\n";
		}
	$cols++;
	print "<td nowrap><a href='view_mail.cgi?idx=$idx&user=$in{'user'}&folder=$folder->{'index'}'>",
              &simplify_from($mail[$i]->{'header'}->{$showto ? 'to' : 'from'}),
	      "</td>\n";
	$cols++;
	if ($config{'show_to'}) {
		print "<td nowrap>",&simplify_from(
	   		$mail[$i]->{'header'}->{$showto ? 'from' : 'to'}),
			"</td>\n";
		$cols++;
		}
	print "<td nowrap>",&simplify_date($mail[$i]->{'header'}->{'date'}),
	      "</td>\n";
	print "<td nowrap>",&nice_size($mail[$i]->{'size'}, 1024),"</td>\n";
	print "<td><table border=0 cellpadding=0 cellspacing=0 width=100%>",
	      "<tr><td>",&simplify_subject($mail[$i]->{'header'}->{'subject'}),
	      "</td> <td align=right>";
	if ($mail[$i]->{'header'}->{'content-type'} =~ /multipart\/\S+/i) {
		print "<img src=images/attach.gif>";
		}
	local $p = int($mail[$i]->{'header'}->{'x-priority'});
	if ($p == 1) {
		print "&nbsp;<img src=images/p1.gif>";
		}
	elsif ($p == 2) {
		print "&nbsp;<img src=images/p2.gif>";
		}
	if (!$showto) {
		if ($read{$mail[$i]->{'header'}->{'message-id'}} == 2) {
			print "&nbsp;<img src=images/special.gif>";
			}
		elsif ($read{$mail[$i]->{'header'}->{'message-id'}} == 1) {
			print "&nbsp;<img src=images/read.gif>";
			}
		}
	print "</td></tr></table></td> </tr>\n";
	$cols += 4;

	if ($config{'show_body'}) {
                # Show part of the body too
                &parse_mail($mail[$i]);
		local $data = &mail_preview($mail[$i]);
		if ($data) {
                        print "<tr $cb> <td colspan=$cols><tt>",
				&html_escape($data),"</tt></td> </tr>\n";
			}
                }
	}
if (@mail) {
	print "</table>\n";
	print &select_all_link("d", 1, $text{'mail_all'}),"&nbsp;\n";
	print &select_invert_link("d", 1, $text{'mail_invert'}),"<br>\n";
	}

&show_buttons(2, \@folders, $folder, \@mail, $in{'user'});
print "</form>\n";

# Show search form
print "<hr>\n";
print "<table width=100%><tr>\n";
print "<form action=mail_search.cgi><td width=33%>\n";
print "<input type=hidden name=user value='$in{'user'}'>\n";
print "<input type=hidden name=folder value='$folder->{'index'}'>\n";
print "<input type=hidden name=simple value=1>\n";
print "<input type=submit value='$text{'mail_search2'}'>\n";
print "<input name=search size=20></td></form>\n";

$jumpform = (@mail > $perpage);
print "<form action=search_form.cgi>\n";
print "<input type=hidden name=user value='$in{'user'}'>\n";
print "<input type=hidden name=folder value='$folder->{'index'}'>\n";
print "<td width=33% align=center><input type=submit name=advanced ",
      "value='$text{'mail_advanced'}'></td>\n";
print "</form>\n";

# Show page jump form
if ($jumpform) {
	print "<form action=list_mail.cgi>\n";
	print "<input type=hidden name=user value='$in{'user'}'>\n";
	print "<input type=hidden name=folder value='$folder->{'index'}'>\n";
	print "<td width=33% align=right>\n";
	print "<input type=submit value='$text{'mail_jump'}'>\n";
	printf "<input name=jump size=3 value='%s'> %s %s\n",
		int($in{'start'} / $perpage)+1, $text{'mail_of'},
		int(@mail / $perpage)+1;
	print "</td></form>\n";
	}
else {
	print "<td width=33% align=right></td>\n";
	}
print "</tr>\n";

print "<td align=center width=33%></td>\n";

print "</table>\n";

if ($config{'log_read'}) {
	&webmin_log("read", undef, $in{'user'},
		    { 'file' => $folder->{'file'} });
	}
&ui_print_footer("", $text{'index_return'});


