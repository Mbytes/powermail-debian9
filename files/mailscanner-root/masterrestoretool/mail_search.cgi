#!/usr/bin/perl
# mail_search.cgi
# Find mail messages matching some pattern

require './mailboxes-lib.pl';
&ReadParse();
&can_user($in{'user'}) || &error($text{'mail_ecannot'});
@folders = &list_user_folders($in{'user'});

if ($in{'simple'}) {
	# Make sure a search was entered
	$in{'search'} || &error($text{'search_ematch'});
	$ofolder = $folders[$in{'folder'}];
	}
else {
	# Validate search fields
	for($i=0; defined($in{"field_$i"}); $i++) {
		if ($in{"field_$i"}) {
			$in{"what_$i"} || &error(&text('search_ewhat', $i+1));
			$neg = $in{"neg_$i"} ? "!" : "";
			push(@fields, [ $neg.$in{"field_$i"}, $in{"what_$i"} ]);
			}
		}
	@fields || &error($text{'search_enone'});
	$ofolder = $folders[$in{'ofolder'}];
	}

if ($in{'folder'} == -2) {
	$desc = $text{'search_local'};
	}
elsif ($in{'folder'} == -1) {
	$desc = $text{'search_all'};
	}
else {
	$folder = $folders[$in{'folder'}];
	$desc = &text('mail_for', $folder->{'name'});
	}
&ui_print_header($desc, $text{'search_title'}, "", undef, 0, 0, undef,
	&folder_link($in{'user'}, $ofolder));

if ($in{'simple'}) {
	# Just search by Subject and From in one folder
	($mode, $words) = &parse_boolean($in{'search'});
	if ($mode == 0) {
		# Can just do a single 'or' search
		@searchlist = map { ( [ 'subject', $_ ],
				      [ 'from', $_ ] ) } @$words;
		@rv = &mailbox_search_mail(\@searchlist, 0, $folder);
		}
	elsif ($mode == 1) {
		# Need to do two 'and' searches and combine
		@searchlist1 = map { ( [ 'subject', $_ ] ) } @$words;
		@rv1 = &mailbox_search_mail(\@searchlist1, 1, $folder);
		@searchlist2 = map { ( [ 'from', $_ ] ) } @$words;
		@rv2 = &mailbox_search_mail(\@searchlist2, 1, $folder);
		@rv = @rv1;
		%gotidx = map { $_->{'idx'}, 1 } @rv;
		foreach $mail (@rv2) {
			push(@rv, $mail) if (!$gotidx{$mail->{'idx'}});
			}
		}
	else {
		&error($text{'search_eboolean'});
		}
	foreach $mail (@rv) {
		$mail->{'folder'} = $folder;
		}
	print "<p><b>",&text('search_results2', scalar(@rv),
			     "<tt>$in{'search'}</tt>")," ..</b><p>\n";
	}
else {
	# Complex search, perhaps over multiple folders!
	if ($in{'folder'} == -2) {
		@sfolders = grep { !$_->{'remote'} } @folders;
		$multi_folder = 1;
		}
	elsif ($in{'folder'} == -1) {
		@sfolders = @folders;
		$multi_folder = 1;
		}
	else {
		@sfolders = ( $folder );
		}
	foreach $sf (@sfolders) {
		local @frv = &mailbox_search_mail(\@fields, $in{'and'}, $sf);
		foreach $mail (@frv) {
			$mail->{'folder'} = $sf;
			}
		push(@rv, @frv);
		}
	print "<p><b>",&text('search_results4', scalar(@rv))," ..</b><p>\n";
	}
@rv = reverse(@rv);

$showto = $folder->{'sent'} || $folder->{'drafts'};
if (@rv) {
	print "<form action=delete_mail.cgi method=post>\n";
	print "<input type=hidden name=folder value='$in{'folder'}'>\n";
	print "<input type=hidden name=user value='$in{'user'}'>\n";
	if ($config{'top_buttons'}) {
		if (!$multi_folder) {
			&show_buttons(1, \@folders, $folder, \@rv, $in{'user'});
			print &select_all_link("d", 0, $text{'mail_all'}),
			      "&nbsp;\n";
			print &select_invert_link("d", 0, $text{'mail_invert'}),
			      "&nbsp;<br>\n";
			}
		}
	print "<table border width=100%>\n";
	print "<tr $tb> ",
	      $multi_folder ? "<td><b>$text{'mail_folder'}</b></td>"
			    : "<td>&nbsp;</td> ",
	      $showto ? "<td><b>$text{'mail_to'}</b></td> "
		      : "<td><b>$text{'mail_from'}</b></td> ",
	      "<td><b>$text{'mail_date'}</b></td> ",
	      "<td><b>$text{'mail_size'}</b></td> ",
	      "<td><b>$text{'mail_subject'}</b></td> </tr>\n";
	}
foreach $m (@rv) {
	local $idx = $m->{'idx'};
	local $mf = $m->{'folder'};
	print "<tr $cb>\n";
	if ($multi_folder) {
		print "<td>$mf->{'name'}</td>\n";
		}
	else {
		print "<td><input type=checkbox name=d value=$idx></td>\n";
		}
	print "<td nowrap><a href='view_mail.cgi?idx=$idx&folder=$mf->{'index'}&user=$in{'user'}'>",&simplify_from($m->{'header'}->{$showto?'to':'from'}),"</td>\n";
	print "<td nowrap>",&simplify_date($m->{'header'}->{'date'}),"</td>\n";
	print "<td nowrap>",&nice_size($m->{'size'}),"</td>\n";
	print "<td><table border=0 cellpadding=0 cellspacing=0 width=100%>",
	      "<tr><td>",&simplify_subject($m->{'header'}->{'subject'}),
	      "</td> <td align=right>";
	if ($m->{'header'}->{'content-type'} =~ /multipart\/\S+/i) {
		print "<img src=images/attach.gif>";
		}
	local $p = int($m->{'header'}->{'x-priority'});
	if ($p == 1) {
		print "&nbsp;<img src=images/p1.gif>";
		}
	elsif ($p == 2) {
		print "&nbsp;<img src=images/p2.gif>";
		}
	print "</td></tr></table></td> </tr>\n";
	}
if (@rv) {
	print "</table>\n";
	if (!$multi_folder) {
		print &select_all_link("d", 0, $text{'mail_all'}),"&nbsp;\n";
		print &select_invert_link("d", 0, $text{'mail_invert'}),"&nbsp;<p>\n";
		&show_buttons(2, \@folders, $folder, \@rv, $in{'user'});
		}
	print "</form><p>\n";
	}
else {
	print "<b>$text{'search_none'}</b> <p>\n";
	}

&ui_print_footer($in{'simple'} ? ( ) : ( "search_form.cgi?folder=$in{'folder'}",
				$text{'sform_return'} ),
	"list_mail.cgi?user=$in{'user'}&folder=$in{'folder'}", $text{'mail_return'},
	"", $text{'index_return'});

