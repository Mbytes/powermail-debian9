#!/usr/bin/perl
# send_mail.cgi
# Send off an email message

require './mailboxes-lib.pl';
&ReadParseMime();
&can_user($in{'user'}) || &error($text{'mail_ecannot'});

# Check inputs
@folders = &list_user_folders($in{'user'});
$folder = $folders[$in{'folder'}];
&error_setup($text{'send_err'});
$in{'to'} || &error($text{'send_eto'});
if ($access{'fmode'} == 0) {
	$in{'from'} || &error($text{'send_efrom'});
	}
elsif ($access{'fmode'} == 1) {
	foreach $f (split(/\s+/, $access{'from'})) {
		$found++ if ("$in{'user'}\@$f" eq $in{'from'} ||
			     "$in{'ouser'}\@$f" eq $in{'from'});
		}
	&error($text{'send_efrom'}) if (!$found);
	}
elsif ($access{'fmode'} == 2) {
	foreach $f (split(/\s+/, $access{'from'})) {
		$found++ if ($f eq $in{'from'});
		}
	&error($text{'send_efrom'}) if (!$found);
	}
elsif ($access{'fmode'} == 3) {
	$in{'from'} .= "\@$access{'from'}";
	}
if ($in{'from'} =~ /^(\S+)\@(\S+)$/ && $access{'fromname'}) {
	$in{'from'} = "$access{'fromname'} <$in{'from'}>";
	}
@sub = split(/\0/, $in{'sub'});
$subs = join("", map { "&sub=$_" } @sub);

# Construct the email
$in{'from'} || &error($text{'send_efrom'});
$mail->{'headers'} = [ [ 'From', $in{'from'} ],
		       [ 'Subject', $in{'subject'} ],
		       [ 'To', $in{'to'} ],
		       [ 'Cc', $in{'cc'} ],
		       [ 'Bcc', $in{'bcc'} ],
		       [ 'X-Originating-IP', $ENV{'REMOTE_ADDR'} ],
		       [ 'X-Mailer', "Usermin ".&get_webmin_version() ] ];
push(@{$mail->{'headers'}}, [ 'X-Priority', $in{'pri'} ]) if ($in{'pri'});
$in{'body'} =~ s/\r//g;
if ($in{'body'} =~ /\S/) {
	if ($in{'spell'}) {
		pipe(INr, INw);
		pipe(OUTr, OUTw);
		select(INw); $| = 1; select(OUTr); $| = 1; select(STDOUT);
		if (!fork()) {
			close(INw);
			close(OUTr);
			untie(*STDIN);
			untie(*STDOUT);
			untie(*STDERR);
			open(STDOUT, ">&OUTw");
			open(STDERR, ">/dev/null");
			open(STDIN, "<&INr");
			exec("ispell -a");
			exit;
			}
		close(INr);
		close(OUTw);
		local $indent = "&nbsp;" x 4;
		local @errs;
		foreach $line (split(/\n+/, $in{'body'})) {
			next if ($line !~ /\S/);
			print INw $line,"\n";
			local @lerrs;
			while(1) {
				($spell = <OUTr>) =~ s/\r|\n//g;
				last if (!$spell);
				if ($spell =~ /^#\s+(\S+)/) {
					# Totally unknown word
					push(@lerrs, $indent.&text('send_eword', "<i>".&html_escape($1)."</i>"));
					}
				elsif ($spell =~ /^&\s+(\S+)\s+(\d+)\s+(\d+):\s+(.*)/) {
					# Maybe possible word, with options
					push(@lerrs, $indent.&text('send_eword2', "<i>".&html_escape($1)."</i>", "<i>".&html_escape($4)."</i>"));
					}
				elsif ($spell =~ /^\?\s+(\S+)/) {
					# Maybe possible word
					push(@lerrs, $indent.&text('send_eword', "<i>".&html_escape($1)."</i>"));
					}
				}
			if (@lerrs) {
				push(@errs, &text('send_eline', "<tt>".&html_escape($line)."</tt>")."<br>".join("<br>", @lerrs)."<p>\n");
				}
			}
		close(INw);
		close(OUTr);
		if (@errs) {
			# Spelling errors found!
			&ui_print_header(undef, $text{'compose_title'}, "", undef, 0, 0, undef,
				&folder_link($in{'user'}, $folder));
			print "<b>$text{'send_espell'}</b><p>\n";
			print @errs;
			&ui_print_footer("index.cgi?user=$in{'user'}&folder=$in{'folder'}",
				$text{'mail_return'});
			exit;
			}
		}
	local $mt = $in{'html_edit'} ? "text/html" : "text/plain";
	if ($in{'body'} =~ /[\177-\377]/) {
		# Contains 8-bit characters .. need to make quoted-printable
		$quoted_printable++;
		@attach = ( { 'headers' => [ [ 'Content-Type', $mt ],
					     [ 'Content-Transfer-Encoding',
					       'quoted-printable' ] ],
			      'data' => quoted_encode($in{'body'}) } );
		}
	else {
		# Plain 7-bit ascii text
		@attach = ( { 'headers' => [ [ 'Content-Type', $mt ],
					     [ 'Content-Transfer-Encoding',
					       '7bit' ] ],
			      'data' => $in{'body'} } );
		}
	$bodyattach = $attach[0];
	}
$attachsize = 0;
foreach $i (0 .. 5) {
	# Add uploaded attachment
	next if (!$in{"attach$i"});
	&test_max_attach($attachsize);
	local $filename = $in{"attach${i}_filename"};
	$filename =~ s/^.*(\\|\/)//;
	local $type = $in{"attach${i}_content_type"}."; name=\"".
		      $filename."\"";
	local $disp = "inline; filename=\"".$filename."\"";
	push(@attach, { 'data' => $in{"attach${i}"},
			'headers' => [ [ 'Content-type', $type ],
				       [ 'Content-Disposition', $disp ],
				       [ 'Content-Transfer-Encoding',
					 'base64' ] ] });
	$atotal += length($in{"attach${i}"});
	}
foreach $i (0 .. 2) {
	# Add server-side attachment
	next if (!$in{"file$i"} || !$access{'canattach'});
	@uinfo = &get_mail_user($in{'user'});
	if ($in{"file$i"} !~ /^\//) {
		$in{"file$i"} = $uinfo[7]."/".$in{"file$i"};
		}

	local @st = stat($in{"file$i"});
	&test_max_attach($st[7]);
	local $data;
	&switch_to_user($in{'user'});
	open(DATA, $in{"file$i"}) || &error(&text('send_efile', $in{"file$i"}, $!));
	while(<DATA>) {
		$data .= $_;
		}
	close(DATA);
	&switch_user_back();
	$in{"file$i"} =~ s/^.*\///;
	local $type = &guess_mime_type($in{"file$i"}).
		      "; name=\"".$in{"file$i"}."\"";
	local $disp = "inline; filename=\"".$in{"file$i"}."\"";
	push(@attach, { 'data' => $data,
			'headers' => [ [ 'Content-type', $type ],
				       [ 'Content-Disposition', $disp ],
				       [ 'Content-Transfer-Encoding',
					 'base64' ] ] });
	$atotal += length($data);
	}
@fwd = split(/\0/, $in{'forward'});
if (@fwd) {
	# Add forwarded attachments
	@mail = &mailbox_list_mails($in{'idx'}, $in{'idx'}, $folder);
	$fwdmail = $mail[$in{'idx'}];
	&parse_mail($fwdmail);

	foreach $s (@sub) {
		# We are looking at a mail within a mail ..
		local $amail = &extract_mail($fwdmail->{'attach'}->[$s]->{'data'});
		&parse_mail($amail);
		$fwdmail = $amail;
		}

	foreach $f (@fwd) {
		&test_max_attach(length($fwdmail->{'attach'}->[$f]->{'data'}));
		push(@attach, $fwdmail->{'attach'}->[$f]);
		$atotal += length($fwdmail->{'attach'}->[$f]->{'data'});
		}
	}
@mailfwd = split(/\0/, $in{'mailforward'});
if (@mailfwd) {
	# Add forwarded emails
	@mail = &mailbox_list_mails($mailfwd[0], $mailfwd[@mailfwd-1], $folder);
	foreach $f (@mailfwd) {
		$fwdmail = $mail[$f];
		local $headertext;
		foreach $h (@{$fwdmail->{'headers'}}) {
			$headertext .= $h->[0].": ".$h->[1]."\n";
			}
		push(@attach, { 'data' => $headertext."\n".$fwdmail->{'body'},
				'headers' => [ [ 'Content-type', 'message/rfc822' ],
					       [ 'Content-Description',
						  $fwdmail->{'header'}->{'subject'} ] ]
			      });
		}
	}
$mail->{'attach'} = \@attach;
if ($access{'attach'} >= 0 && $atotal > $access{'attach'}*1024) {
	&error(&text('send_eattach', $access{'attach'}));
	}

# Check for text-only email
$textonly = $config{'no_mime'} && !$quoted_printable &&
	    @{$mail->{'attach'}} == 1 &&
	    $mail->{'attach'}->[0] eq $bodyattach &&
	    !$in{'html_edit'};

# Send it off
&send_mail($mail, undef, $textonly, $config{'no_crlf'});
&webmin_log("send", undef, undef, { 'from' => $in{'from'}, 'to' => $in{'to'} });

# Tell the user that email as sent
&ui_print_header(undef, $text{'send_title'}, "", undef, 0, 0, undef,
	&folder_link($in{'user'}, $folder));

@tos = ( split(/,/, $in{'to'}), split(/,/, $in{'cc'}), split(/,/, $in{'bcc'}) );
$tos = join(" , ", map { "<tt>".&html_escape($_)."</tt>" } @tos);
print "<p>",&text($in{'draft'} ? 'send_draft' : 'send_ok', $tos),"<p>\n";

if ($in{'idx'} ne '') {
	&ui_print_footer("view_mail.cgi?idx=$in{'idx'}&folder=$in{'folder'}&user=$in{'user'}$subs",
	        $text{'view_return'},
		"list_mail.cgi?folder=$in{'folder'}&user=$in{'user'}",
		$text{'mail_return'},
		"", $text{'index_return'});
	}
else {
	&ui_print_footer("list_mail.cgi?folder=$in{'folder'}&user=$in{'user'}",
		$text{'mail_return'},
		"", $text{'index_return'});
	}

# write_attachment(&attach)
sub write_attachment
{
local ($a) = @_;
local ($enc, $rv);
foreach $h (@{$a->{'headers'}}) {
	$rv .= $h->[0].": ".$h->[1]."\r\n";
	$enc = $h->[1]
	    if (lc($h->[0]) eq 'content-transfer-encoding');
	}
$rv .= "\r\n";
if (lc($enc) eq 'base64') {
	local $encoded = &encode_base64($a->{'data'});
	$encoded =~ s/\r//g;
	$encoded =~ s/\n/\r\n/g;
	$rv .= $encoded;
	}
else {
	$a->{'data'} =~ s/\r//g;
	$a->{'data'} =~ s/\n/\r\n/g;
	$rv .= $a->{'data'};
	if ($a->{'data'} !~ /\n$/) {
		$rv .= "\r\n";
		}
	}
return $rv;
}

sub test_max_attach
{
$attachsize += $_[0];
if ($access{'attach'} >= 0 && $attachsize > $access{'attach'}) {
	&error(&text('send_eattachsize', $access{'attach'}));
	}
}

