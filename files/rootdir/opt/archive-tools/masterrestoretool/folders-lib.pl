# folders-lib.pl
# Functions for dealing with mail folders in various formats

$pop3_port = 110;
$imap_port = 143;
$cache_directory = $user_module_config_directory || $module_config_directory;

# mailbox_list_mails(start, end, &folder, [headersonly], [&error])
# Returns an array whose size is that of the entire folder, with messages
# in the specified range filled in.
sub mailbox_list_mails
{
if ($_[2]->{'type'} == 0) {
	# List a single mbox formatted file
	return &list_mails($_[2]->{'file'}, $_[0], $_[1]);
	}
elsif ($_[2]->{'type'} == 1) {
	# List a qmail maildir
	local $md = $_[2]->{'file'};
# print %{$md};
	return &list_maildir($md, $_[0], $_[1]);
	}
elsif ($_[2]->{'type'} == 2) {
	# Get mail headers/body from a remote POP3 server

	# Login first
	local @rv = &pop3_login($_[2]);
	if ($rv[0] != 1) {
		# Failed to connect or login
		if ($_[4]) {
			@{$_[4]} = @rv;
			return ();
			}
		elsif ($rv[0] == 0) { &error($rv[1]); }
		else { &error(&text('save_elogin', $rv[1])); }
		}
	local $h = $rv[1];
	local @uidl = &pop3_uidl($h);
	local %onserver = map { &safe_uidl($_), 1 } @uidl;

	# Work out what range we want
	local ($start, $end) = &compute_start_end($_[0], $_[1], scalar(@uidl));
	local @rv = map { undef } @uidl;

	# For each message in the range, get the headers or body
	local ($i, $f, %cached, %sizeneed);
	local $cd = "$cache_directory/$_[2]->{'id'}.cache";
	if (opendir(CACHE, $cd)) {
		while($f = readdir(CACHE)) {
			if ($f =~ /^(\S+)\.body$/) {
				$cached{$1} = 2;
				}
			elsif ($f =~ /^(\S+)\.headers$/) {
				$cached{$1} = 1;
				}
			}
		closedir(CACHE);
		}
	else {
		mkdir($cd, 0700);
		}
	for($i=$start; $i<=$end; $i++) {
		local $u = &safe_uidl($uidl[$i]);
		if ($cached{$u} == 2 || $cached{$u} == 1 && $_[3]) {
			# We already have everything that we need
			}
		elsif ($cached{$u} == 1 || !$_[3]) {
			# We need to get the entire mail
			&pop3_command($h, "retr ".($i+1));
			open(CACHE, ">$cd/$u.body");
			while(<$h>) {
				s/\r//g;
				last if ($_ eq ".\n");
				print CACHE $_;
				}
			close(CACHE);
			unlink("$cd/$u.headers");
			$cached{$u} = 2;
			}
		else {
			# We just need the headers
			&pop3_command($h, "top ".($i+1)." 0");
			open(CACHE, ">$cd/$u.headers");
			while(<$h>) {
				s/\r//g;
				last if ($_ eq ".\n");
				print CACHE $_;
				}
			close(CACHE);
			$cached{$u} = 1;
			}
		local $mail = &read_mail_file($cached{$u} == 2 ?
				"$cd/$u.body" : "$cd/$u.headers");
		if ($cached{$u} == 1) {
			if ($mail->{'body'} ne "") {
				$mail->{'size'} = int($mail->{'body'});
				}
			else {
				$sizeneed{$i} = 1;
				}
			}
		$mail->{'uidl'} = $uidl[$i];
		$mail->{'idx'} = $i;
		$rv[$i] = $mail;
		}

	# Get sizes for mails if needed
	if (%sizeneed) {
		&pop3_command($h, "list");
		while(<$h>) {
			s/\r//g;
			last if ($_ eq ".\n");
			if (/^(\d+)\s+(\d+)/ && $sizeneed{$1-1}) {
				# Add size to the mail cache
				$rv[$1-1]->{'size'} = $2;
				local $u = &safe_uidl($uidl[$1-1]);
				open(CACHE, ">>$cd/$u.headers");
				print CACHE $2,"\n";
				close(CACHE);
				}
			}
		}

	# Clean up any cached mails that no longer exist on the server
	foreach $f (keys %cached) {
		if (!$onserver{$f}) {
			unlink($cached{$f} == 1 ? "$cd/$f.headers"
						: "$cd/$f.body");
			}
		}

	return @rv;
	}
elsif ($_[2]->{'type'} == 3) {
	# List an MH directory
	local $md = $_[2]->{'file'};
	return &list_mhdir($md, $_[0], $_[1]);
	}
elsif ($_[2]->{'type'} == 4) {
	# Get headers and possibly bodies from an IMAP server

	# Login and select the specified mailbox
	local @rv = &imap_login($_[2]);
	if ($rv[0] != 1) {
		# Something went wrong
		if ($_[4]) {
			@{$_[4]} = @rv;
			return ();
			}
		elsif ($rv[0] == 0) { &error($rv[1]); }
		elsif ($rv[0] == 3) { &error(&text('save_emailbox', $rv[1])); }
		elsif ($rv[0] == 2) { &error(&text('save_elogin2', $rv[1])); }
		}
	local $h = $rv[1];
	local $count = $rv[2];
	return () if (!$count);

	# Work out what range we want
	local ($start, $end) = &compute_start_end($_[0], $_[1], $count);
	local @mail = map { undef } (0 .. $count-1);

	# Get the headers or body of messages in the specified range
	local @rv;
	if ($_[3]) {
		# Just the headers
		@rv = &imap_command($h,
			sprintf "FETCH %d:%d (RFC822.SIZE RFC822.HEADER)",
				$start+1, $end+1);
		}
	else {
		# Whole messages
		@rv = &imap_command($h,
			sprintf "FETCH %d:%d RFC822", $start+1, $end+1);
		}

	# Parse the headers or whole messages that came back
	local $i;
	for($i=0; $i<@{$rv[1]}; $i++) {
		# Extract the actual mail part
		local $mail = &parse_imap_mail($rv[1]->[$i]);
		if ($mail) {
			$mail->{'idx'} = $start+$i;
			$mail[$start+$i] = $mail;
			}
		}

	return @mail;
	}
elsif ($_[2]->{'type'} == 5) {
	# Just all of the constituent folders
	local @mail;

	# Work out exactly how big the total is
	local ($sf, %len, $count);
	foreach $sf (@{$_[2]->{'subfolders'}}) {
		$len{$sf} = &mailbox_folder_size($sf);
		$count += $len{$sf};
		}

	# Work out what range we need
	local ($start, $end) = &compute_start_end($_[0], $_[1], $count);

	# Fetch the needed part of each sub-folder
	local $pos = 0;
	foreach $sf (@{$_[2]->{'subfolders'}}) {
		local ($sfstart, $sfend);
		$sfstart = $start - $pos;
		$sfend = $end - $pos;
		$sfstart = $sfstart < 0 ? 0 :
			   $sfstart >= $len{$sf} ? $len{$sf}-1 : $sfstart;
		$sfend = $sfend < 0 ? 0 :
			 $sfend >= $len{$sf} ? $len{$sf}-1 : $sfend;
		local @submail =
			&mailbox_list_mails($sfstart, $sfend, $sf, $_[3]);
		local $sm;
		foreach $sm (@submail) {
			if ($sm) {
				&push_index($sm, $sf, $sm->{'idx'}+$pos);
				}
			}
		push(@mail, @submail);
		$pos += $len{$sf};
		}

	return @mail;
	}
elsif ($_[2]->{'type'} == 6) {
	# A virtual folder, which just contains indexes into other folders
	local $mems = $folder->{'members'};
	local ($start, $end) = &compute_start_end($_[0], $_[1], scalar(@$mems));

	# Work out which folders we need, and how much
	local (%frange, %namemap);
	local $i;
	for($i=$start; $i<=$end; $i++) {
		local $sf = $mems->[$i]->[0];
		local $sfn = &folder_name($sf);
		local $idx = $mems->[$i]->[1];
		if ($frange{$sfn}) {
			$frange{$sfn}->[0] = $idx if ($idx < $frange{$sfn}->[0]);
			$frange{$sfn}->[1] = $idx if ($idx > $frange{$sfn}->[1]);
			}
		else {
			$frange{$sfn} = [ $idx, $idx ];
			}
		$namemap{$sfn} = $sf;
		}

	# Get all the needed folders
	local %sfs;
	local $sfn;
	foreach $sfn (keys %frange) {
		local $sf = $namemap{$sfn};
		local @submail = &mailbox_list_mails($frange{$sfn}->[0],
						     $frange{$sfn}->[1],
						     $sf, $_[3]);
		$sfs{$sfn} = \@submail;
		}

	# Construct the results
	local @mail = map { undef } (0 .. @$mems-1);
	local $need_save = 0;
	local @newmems = @$mems;
	for($i=$start; $i<=$end && $i<=@$mems; $i++) {
		local $sf = $mems->[$i]->[0];
		local $sfn = &folder_name($sf);
		local $idx = $mems->[$i]->[1];
		$mail[$i] = $sfs{$sfn}->[$idx];
		if ($mems->[$i]->[2] &&
		    $mail[$i]->{'header'}->{'message-id'} ne $mems->[$i]->[2]) {
			# Argh .. index is wrong! Find message by ID
			local $real = &find_by_message_id($sf,$mems->[$i]->[2]);
			if ($real) {
				$mems->[$i]->[1] = $real->{'idx'};
				$mail[$i] = $real;
				$need_save++;
				}
			else {
				# Doesn't exist! Lose from index..
				@newmems = grep { $_ ne $mems->[$i] } @newmems;
				$need_save++;
				next;
				}
			}
		&push_index($mail[$i], $sf, $i);
		}

	if ($need_save) {
		$_[2]->{'members'} = \@newmems;
		&save_folder($_[2]);
		}
	return @mail;
	}
}

# mailbox_select_mails(&folder, &indexes, headersonly)
# Returns only messages from a folder with indexes in the given array
sub mailbox_select_mails
{
local ($folder, $indexes, $headersonly) = @_;
if ($folder->{'type'} == 0) {
	# mbox folder
	return &select_mails($folder->{'file'}, $indexes, $headersonly);
	}
elsif ($folder->{'type'} == 1) {
	# Maildir folder
	return &select_maildir($folder->{'file'}, $indexes, $headersonly);
	}
elsif ($folder->{'type'} == 3) {
	# MH folder
	return &select_mhdir($folder->{'file'}, $indexes, $headersonly);
	}
elsif ($folder->{'type'} == 2) {
	# POP folder

	# Login first
	local @rv = &pop3_login($folder);
	if ($rv[0] != 1) {
		# Failed to connect or login
		if ($_[4]) {
			@{$_[4]} = @rv;
			return ();
			}
		elsif ($rv[0] == 0) { &error($rv[1]); }
		else { &error(&text('save_elogin', $rv[1])); }
		}
	local $h = $rv[1];
	local @uidl = &pop3_uidl($h);

	# For each message in the range, get the headers or body
	local ($i, $f, %cached, %sizeneed);
	local @rv;
	local $cd = "$cache_directory/$_[2]->{'id'}.cache";
	if (opendir(CACHE, $cd)) {
		while($f = readdir(CACHE)) {
			if ($f =~ /^(\S+)\.body$/) {
				$cached{$1} = 2;
				}
			elsif ($f =~ /^(\S+)\.headers$/) {
				$cached{$1} = 1;
				}
			}
		closedir(CACHE);
		}
	else {
		mkdir($cd, 0700);
		}
	foreach my $i (@$indexes) {
		local $u = &safe_uidl($uidl[$i]);
		if ($cached{$u} == 2 || $cached{$u} == 1 && $headersonly) {
			# We already have everything that we need
			}
		elsif ($cached{$u} == 1 || !$headersonly) {
			# We need to get the entire mail
			&pop3_command($h, "retr ".($i+1));
			open(CACHE, ">$cd/$u.body");
			while(<$h>) {
				s/\r//g;
				last if ($_ eq ".\n");
				print CACHE $_;
				}
			close(CACHE);
			unlink("$cd/$u.headers");
			$cached{$u} = 2;
			}
		else {
			# We just need the headers
			&pop3_command($h, "top ".($i+1)." 0");
			open(CACHE, ">$cd/$u.headers");
			while(<$h>) {
				s/\r//g;
				last if ($_ eq ".\n");
				print CACHE $_;
				}
			close(CACHE);
			$cached{$u} = 1;
			}
		local $mail = &read_mail_file($cached{$u} == 2 ?
				"$cd/$u.body" : "$cd/$u.headers");
		if ($cached{$u} == 1) {
			if ($mail->{'body'} ne "") {
				$mail->{'size'} = int($mail->{'body'});
				}
			else {
				$sizeneed{$i} = 1;
				}
			}
		$mail->{'uidl'} = $uidl[$i];
		$mail->{'idx'} = $i;
		push(@rv, $mail);
		}

	# Get sizes for mails if needed
	if (%sizeneed) {
		&pop3_command($h, "list");
		while(<$h>) {
			s/\r//g;
			last if ($_ eq ".\n");
			if (/^(\d+)\s+(\d+)/ && $sizeneed{$1-1}) {
				# Add size to the mail cache
				$rv[$1-1]->{'size'} = $2;
				local $u = &safe_uidl($uidl[$1-1]);
				open(CACHE, ">>$cd/$u.headers");
				print CACHE $2,"\n";
				close(CACHE);
				}
			}
		}

	return @rv;
	}
elsif ($folder->{'type'} == 4) {
	# IMAP folder
	# XXX
	}
elsif ($folder->{'type'} == 5) {
	# Composite folder .. need to convert each index to a position
	# in a sub-folder
	# XXX could be faster
	my $pos = 0;
	my @ranges;
	foreach my $sf (@{$folder->{'subfolders'}}) {
		my $len = &mailbox_folder_size($sf);
		push(@ranges, [ $pos, $pos+$len, $sf ]);
		$pos += $len;
		}
	local @rv;
	foreach my $i (@$indexes) {
		# Find out which sub-folder this index is in
		foreach my $r (@ranges) {
			if ($i >= $r->[0] && $i < $r->[1]) {
				# Found it!
				local ($mail) = &mailbox_select_mails(
					   $r->[2], [ $i - $r->[0] ],
					   $headersonly);
				&push_index($mail, $r->[2], $i);
				push(@rv, $mail);
				last;
				}
			}
		}
	return @rv;
	}
elsif ($folder->{'type'} == 6) {
	# Virtual folder .. translate each index to sub-folder index
	# XXX could be faster
	local $mems = $folder->{'members'};
	local @rv;
	local $need_save = 0;
	local @newmems = @$mems;
	foreach my $i (@$indexes) {
		local $sf = $mems->[$i]->[0];
		local $idx = $mems->[$i]->[1];
		local ($mail) = &mailbox_select_mails($sf, [ $idx ],
						      $headersonly);
		if ($mems->[$i]->[2] &&
		    $mail->{'header'}->{'message-id'} ne $mems->[$i]->[2]) {
			local $real = &find_by_message_id($sf,$mems->[$i]->[2]);
			if ($real) {
				$mems->[$i]->[1] = $real->{'idx'};
				$mail = $real;
				$need_save++;
				}
			else {
				# Doesn't exist! Lose from index..
				@newmems = grep { $_ ne $mems->[$i] } @newmems;
				$need_save++;
				}
			}
		&push_index($mail, $sf, $i);
		push(@rv, $mail);
		}
	if ($need_save) {
		$folder->{'members'} = \@newmems;
		&save_folder($folder);
		}
	return @rv;
	}
}

# compute_start_end(start, end, count)
# Given start and end indexes (which may be negative or undef), returns the
# real mail file indexes.
sub compute_start_end
{
local ($start, $end, $count) = @_;
if (!defined($start)) {
	return (0, $count-1);
	}
elsif ($end < 0) {
	local $rstart = $count+$_[1]-1;
	local $rend = $count+$_[0]-1;
	$rstart = $rstart < 0 ? 0 : $rstart;
	return ($rstart, $rend);
	}
else {
	local $rend = $_[1];
	$rend = $count - 1 if ($rend >= $count);
	return ($start, $rend);
	}
}

# mailbox_list_mails_sorted(start, end, &folder, [headeronly], [&error],
#			    [sort-field, sort-dir])
# Returns messages in a folder within the given range, but sorted by the
# given field and condition.
sub mailbox_list_mails_sorted
{
local ($start, $end, $folder, $headers, $error, $field, $dir) = @_;
if (!$field) {
	# Default to current ordering
	($field, $dir) = &get_sort_field($folder);
	}
if (!$field || !$folder->{'sortable'}) {
	# No sorting .. just return newest first
	return reverse(&mailbox_list_mails(
		-$start, -$end-1, $folder, $headers, $error));
	}

# Build the appropriate sort index, if missing
local %index;
&build_sort_index($folder, $field, \%index);

# Get message indexes, sorted by the field
my @sorter;
while(my ($k, $v) = each %index) {
	if ($k =~ /^(\d+)_\Q$field\E$/) {
		push(@sorter, [ $1, lc($v) ]);
		}
	}
if ($field eq "size" || $field eq "date") {
	# Numeric sort
	@sorter = sort { my $s = $a->[1] <=> $b->[1]; $dir ? $s : -$s } @sorter;
	}
else {
	# Alpha sort
	@sorter = sort { my $s = $a->[1] cmp $b->[1]; $dir ? $s : -$s } @sorter;
	}

# Find those mails within the requested range
($start, $end) = &compute_start_end($start, $end, scalar(@sorter));
local @rv = map { undef } (0 .. scalar(@sorter)-1);
local @wantindexes = map { $sorter[$_]->[0] } ($start .. $end);
local @mails = &mailbox_select_mails($folder, \@wantindexes, $headers);
for(my $i=0; $i<@mails; $i++) {
	$rv[$start+$i] = $mails[$i];
	$mails[$i]->{'sortidx'} = $i;
	}
return @rv;
}

# set_sort_indexes(&folder, &mails, [sort-field, sort-dir])
# Given a list of messages, sets the sortidx field based on their indexes
# that would be used if the folder was sorted
sub set_sort_indexes
{
local ($folder, $mails, $field, $dir) = @_;
if (!$field) {
	# Default to current ordering
	($field, $dir) = &get_sort_field($folder);
	}
if (!$field || !$folder->{'sortable'}) {
	# Sort index is the same as the normal index reversed
	my $count = &mailbox_folder_size($folder);
	foreach my $m (@$mails) {
		$m->{'sortidx'} = $count-$m->{'idx'}-1;
		}
	return;
	}

# Build the appropriate sort index, if missing
local %index;
&build_sort_index($folder, $field, \%index);

# Get message indexes, sorted by the field
my @sorter;
while(my ($k, $v) = each %index) {
	if ($k =~ /^(\d+)_\Q$field\E$/) {
		push(@sorter, [ $1, lc($v) ]);
		}
	}
if ($field eq "size" || $field eq "date") {
	# Numeric sort
	@sorter = sort { my $s = $a->[1] <=> $b->[1]; $dir ? $s : -$s } @sorter;
	}
else {
	# Alpha sort
	@sorter = sort { my $s = $a->[1] cmp $b->[1]; $dir ? $s : -$s } @sorter;
	}

# Update sort indexes for mails in list
my $i = 0;
my %idxmap = map { $_->{'idx'}, $_ } @$mails;
foreach my $s (@sorter) {
	my $m = $idxmap{$s->[0]};
	if ($m) {
		$m->{'sortidx'} = $i;
		}
	$i++;
	}
}

# build_sort_index(&folder, field, &index)
# Builds and/or loads the index for sorting a folder on some field. The
# index uses the mail number as the key, and the field value as the value.
sub build_sort_index
{
local ($folder, $field, $index) = @_;
return 0 if (!$folder->{'sortable'});
local $ifile = &folder_sort_index_file($folder);

dbmopen(%$index, $ifile, 0600);
if ($index->{'lastchange'} < $folder->{'lastchange'}) {
	# The mail file is newer than the index .. add messages not in the index
	# to it.
	local $realcount = &mailbox_folder_size($folder);
	local $indexcount = int($index->{'mailcount'});
	if ($realcount < $indexcount) {
		# Mail size has decreased! Need total rebuild
		$indexcount = 0;
		%$index = ( );
		}
	local @mails = $realcount ? &mailbox_select_mails($folder,
					[ $indexcount .. $realcount-1 ], 1)
				  : ( );
	my @index_fields = ( "subject", "from", "to", "date", "size", "message-id" );
	foreach my $mail (@mails) {
		foreach my $f (@index_fields) {
			if ($f eq "date") {
				# Convert date to Unix time
				$index->{$mail->{'idx'}."_date"} =
				  &parse_mail_date($mail->{'header'}->{'date'});
				}
			elsif ($f eq "size") {
				# Get mail size
				$index->{$mail->{'idx'}."_size"} =
					$mail->{'size'};
				}
			elsif ($f eq "from" || $f eq "to") {
				# From: header .. convert to display version
				$index->{$mail->{'idx'}."_".$f} =
					&simplify_from($mail->{'header'}->{$f});
				}
			elsif ($f eq "subject") {
				# Convert subject to display version
				$index->{$mail->{'idx'}."_".$f} =
				    &simplify_subject($mail->{'header'}->{$f});
				}
			else {
				# Just a header
				$index->{$mail->{'idx'}."_".$f} =
					$mail->{'header'}->{$f};
				}
			}
		}
	$index->{'lastchange'} = time();
	$index->{'mailcount'} = $realcount;
	}
return 1;
}

# delete_sort_index(&folder)
# Trashes the sort index for a folder, to force a rebuild
sub delete_sort_index
{
local ($folder) = @_;
local $ifile = &folder_sort_index_file($folder);

my %index;
dbmopen(%index, $ifile, 0600);
%index = ( );
}

# folder_sort_index_file(&folder)
# Returns the index file to use for some folder
sub folder_sort_index_file
{
local ($folder) = @_;
return &user_index_file(($folder->{'file'} || $folder->{'id'}).".sort");
}

# find_by_message_id(&folder, id)
# Finds a message by ID, and returns the mail object
sub find_by_message_id
{
local ($folder, $mid) = @_;
local %index;
if (&build_sort_index($folder, undef, \%index)) {
	while(my ($k, $v) = each %index) {
		if ($k =~ /^(\d+)_message-id$/ && $v eq $mid) {
			# Got it!
			local ($rv) = &mailbox_select_mails($folder, [ $1 ]);
			return $rv;
			}
		}
	}
return undef;
}

# mailbox_search_mail(&fields, andmode, &folder, [&limit])
# Search a mailbox for multiple matching fields
sub mailbox_search_mail
{
if ($_[2]->{'type'} == 0) {
	# Just search an mbox format file
	return &advanced_search_mail($_[2]->{'file'}, $_[0], $_[1], $_[3]);
	}
elsif ($_[2]->{'type'} == 1) {
	# Search a maildir directory
	local $md = $_[2]->{'file'};
	return &advanced_search_maildir($md, $_[0], $_[1], $_[3]);
	}
elsif ($_[2]->{'type'} == 2) {
	# Get all of the mail from the POP3 server and search it
	local ($min, $max);
	if ($_[3] && $_[3]->{'latest'}) {
		$min = -1;
		$max = -$_[3]->{'latest'};
		}
	local @mails = &mailbox_list_mails($min, $max, $_[2],
		   &indexof('body', &search_fields($_[0])) >= 0 ? 0 : 1);
	local @rv = grep { $_ && &mail_matches($_[0], $_[1], $_) } @mails;
	}
elsif ($_[2]->{'type'} == 3) {
	# Search an MH directory
	local $md = $_[2]->{'file'};
	return &advanced_search_mhdir($md, $_[0], $_[1], $_[3]);
	}
elsif ($_[2]->{'type'} == 4) {
	# Use IMAP's remote search feature
	# XXX broken!
	local @rv = &imap_login($_[2]);
	if ($rv[0] == 0) { &error($rv[1]); }
	elsif ($rv[0] == 3) { &error(&text('save_emailbox', $rv[1])); }
	elsif ($rv[0] == 2) { &error(&text('save_elogin2', $rv[1])); }
	local $h = $rv[1];

	# Do the search to get back a list of matching numbers
	local @search;
	foreach $f (@{$_[0]}) {
		local $field = $f->[0];
		local $neg = ($field =~ s/^\!//);
		local $what = $f->[1];
		$what = "\"$what\"" if ($field ne "size");
		$field = "LARGER" if ($field eq "size");
		local $search = uc($field)." ".$what."";
		$search = "NOT $search" if ($neg);
		push(@searches, $search);
		}
	local $searches;
	if (@searches == 1) {
		$searches = $searches[0];
		}
	elsif ($_[1]) {
		$searches = join(" ", @searches);
		}
	else {
		$searches = $searches[$#searches];
		for($i=$#searches-1; $i>=0; $i--) {
			$searches = "or $searches[$i] ($searches)";
			}
		}
	@rv = &imap_command($h, "SEARCH $searches");
	&error(&text('save_esearch', $rv[3])) if (!$rv[0]); 

	# Get and parse those specific messages
	local ($srch) = grep { $_ =~ /^\*\s+SEARCH/i } @{$rv[1]};
	local @ids = split(/\s+/, $srch);
	shift(@ids); shift(@ids);	# lose * SEARCH
	local (@mail, $idx);
	foreach $idx (@ids) {
		local $realidx = $idx-1;
		if ($_[3] && $_[3]->{'latest'}) {
			# Don't get message if outside search range
			next if ($realidx < $rv[3]-$_[3]->{'latest'});
			}
		local @rv = &imap_command($h,
			"FETCH $idx (RFC822.SIZE RFC822.HEADER)");
		&error(&text('save_esearch', $rv[3])) if (!$rv[0]); 
		local $mail = &parse_imap_mail($rv[1]->[0]);
		if ($mail) {
			$mail->{'idx'} = $realidx;
			push(@mail, $mail);
			}
		}
	return reverse(@mail);
	}
elsif ($_[2]->{'type'} == 5) {
	# Search each sub-folder and combine the results - taking any count
	# limits into effect
	local $sf;
	local $pos = 0;
	local @mail;
	local (%start, %len);
	foreach $sf (@{$_[2]->{'subfolders'}}) {
		$len{$sf} = &mailbox_folder_size($sf);
		$start{$sf} = $pos;
		$pos += $len{$sf};
		}
	local $limit = $_[3] ? { %{$_[3]} } : undef;
	foreach $sf (reverse(@{$_[2]->{'subfolders'}})) {
		local @submail = &mailbox_search_mail($_[0], $_[1], $sf, $limit);
		foreach $sm (@submail) {
			&push_index($sm, $sf, $sm->{'idx'}+$start{$sf});
			}
		push(@mail, reverse(@submail));
		if ($limit && $limit->{'latest'}) {
			# Adjust latest down by size of this folder
			$limit->{'latest'} -= $len{$sf};
			last if ($limit->{'latest'} <= 0);
			}
		}
	return reverse(@mail);
	}
elsif ($_[2]->{'type'} == 6) {
	# Just run a search on the sub-mails
	local @rv;
	local ($min, $max);
	if ($_[3] && $_[3]->{'latest'}) {
		$min = -1;
		$max = -$_[3]->{'latest'};
		}
	local $mail;
	foreach $mail (&mailbox_list_mails($min, $max, $_[2])) {
		push(@rv, $mail) if ($mail && &mail_matches($_[0],$_[1],$mail));
		}
	return @rv;
	}
}

# mailbox_delete_mail(&folder, mail, ...)
# Delete multiple messages from some folder
sub mailbox_delete_mail
{
return undef if (&is_readonly_mode());
local $f = shift(@_);
if ($userconfig{'delete_mode'} == 1 && !$f->{'trash'}) {
	# Copy to trash folder first
	local ($trash) = grep { $_->{'trash'} } &list_folders();
	local $m;
	foreach $m (@_) {
		&write_mail_folder($m, $trash);
		}
	}

if ($f->{'type'} == 0) {
	&delete_mail($f->{'file'}, @_);
	}
elsif ($f->{'type'} == 1) {
	&delete_maildir(@_);
	}
elsif ($f->{'type'} == 2) {
	# Login and delete from the POP3 server
	local @rv = &pop3_login($f);
	if ($rv[0] == 0) { &error($rv[1]); }
	elsif ($rv[0] == 2) { &error(&text('save_elogin', $rv[1])); }
	local $h = $rv[1];
	local @uidl = &pop3_uidl($h);
	local $m;
	local $cd = "$cache_directory/$f->{'id'}.cache";
	foreach $m (@_) {
		local $idx = &indexof($m->{'uidl'}, @uidl);
		if ($idx >= 0) {
			&pop3_command($h, "dele ".($idx+1));
			local $u = &safe_uidl($m->{'uidl'});
			unlink("$cd/$u.headers",
			       "$cd/$u.body");
			}
		}
	}
elsif ($f->{'type'} == 3) {
	&delete_mhdir(@_);
	}
elsif ($f->{'type'} == 4) {
	# Delete from the IMAP server
	local @rv = &imap_login($f);
	if ($rv[0] == 0) { &error($rv[1]); }
	elsif ($rv[0] == 3) { &error(&text('save_emailbox', $rv[1])); }
	elsif ($rv[0] == 2) { &error(&text('save_elogin2', $rv[1])); }
	local $h = $rv[1];

	local $m;
	foreach $m (@_) {
		@rv = &imap_command($h, "STORE ".($m->{'idx'}+1).
					" +FLAGS (\\Deleted)");
		&error(&text('save_edelete', $rv[3])) if (!$rv[0]); 
		}
	@rv = &imap_command($h, "EXPUNGE");
	&error(&text('save_edelete', $rv[3])) if (!$rv[0]); 
	}
elsif ($f->{'type'} == 5) {
	# Delete from underlying folder(s)
	local $sm;
	foreach $sm (@_) {
		local ($subfolder, $idx) = &pop_index($sm);
		&mailbox_delete_mail($subfolder, $sm);
		&push_index($sm, $subfolder, $idx);
		}
	}
elsif ($f->{'type'} == 6) {
	local $sm;
	if ($f->{'delete'}) {
		# Delete the underlying messages, and remove from index
		local %folderdel;
		foreach $sm (sort { $b->{'subs'}->[0]->[1] <=>
				    $a->{'subs'}->[0]->[1] } @_) {
			local ($subfolder, $idx) = &pop_index($sm);
			&mailbox_delete_mail($subfolder, $sm);
			&push_index($sm, $subfolder, $idx);

			# Adjust indexes in virtual list that refer to same
			# sub-folder, and have higher numbers
			for(my $i=0; $i<@{$f->{'members'}}; $i++) {
				my $m = $f->{'members'}->[$i];
				my $subidx = $sm->{'subs'}->[0]->[1];
				if ($m->[0] eq $sm->{'subfolder'}) {
					if ($m->[1] == $subidx) {
						splice(@{$f->{'members'}},
						       $i--, 1);
						}
					elsif ($m->[1] > $subidx) {
						$m->[1]--;
						}
					}
				}
			}
		}
	else {
		# Just take out of the virtual index
		foreach $sm (sort { $b->{'idx'} <=> $a->{'idx'} } @_) {
			splice(@{$f->{'members'}}, $sm->{'idx'}, 1);
			}
		}
	&save_folder($f, $f);
	}

# Update folder index to remove their entries
if ($f->{'sortable'}) {
	&delete_sort_index($f);
	}
}

# mailbox_empty_folder(&folder)
# Remove the entire contents of a mail folder
sub mailbox_empty_folder
{
return undef if (&is_readonly_mode());
local $f = $_[0];
if ($f->{'type'} == 0) {
	# mbox format mail file
	&empty_mail($f->{'file'});
	}
elsif ($f->{'type'} == 1) {
	# qmail format maildir
	&empty_maildir($f->{'file'});
	}
elsif ($f->{'type'} == 2) {
	# POP3 server .. delete all messages
	local @rv = &pop3_login($f);
	if ($rv[0] == 0) { &error($rv[1]); }
	elsif ($rv[0] == 2) { &error(&text('save_elogin', $rv[1])); }
	local $h = $rv[1];
	@rv = &pop3_command($h, "stat");
	$rv[1] =~ /^(\d+)/ || return;
	local $count = $1;
	local $i;
	for($i=1; $i<=$count; $i++) {
		&pop3_command($h, "dele ".$i);
		}
	}
elsif ($f->{'type'} == 3) {
	# mh format maildir
	&empty_mhdir($f->{'file'});
	}
elsif ($f->{'type'} == 4) {
	# IMAP server .. delete all messages
	local @rv = &imap_login($f);
	if ($rv[0] == 0) { &error($rv[1]); }
	elsif ($rv[0] == 3) { &error(&text('save_emailbox', $rv[1])); }
	elsif ($rv[0] == 2) { &error(&text('save_elogin2', $rv[1])); }
	local $h = $rv[1];
	local $count = $rv[2];
	local $i;
	for($i=1; $i<=$count; $i++) {
		@rv = &imap_command($h, "STORE ".$i.
					" +FLAGS (\\Deleted)");
		&error(&text('save_edelete', $rv[3])) if (!$rv[0]); 
		}
	@rv = &imap_command($h, "EXPUNGE");
	&error(&text('save_edelete', $rv[3])) if (!$rv[0]); 
	}
elsif ($f->{'type'} == 5) {
	# Empty each sub-folder
	local $sf;
	foreach $sf (@{$f->{'subfolders'}}) {
		&mailbox_empty_folder($sf);
		}
	}
elsif ($f->{'type'} == 6) {
	# Just clear the virtual index
	$f->{'members'} = [ ];
	&save_folder($f);
	}

# Trash the folder index
if ($folder->{'sortable'}) {
	&delete_sort_index($folder);
	}
}

# mailbox_move_mail(&source, &dest, mail, ...)
# Move mail from one folder to another
sub mailbox_move_mail
{
return undef if (&is_readonly_mode());
local $src = shift(@_);
local $dst = shift(@_);
local $now = time();
local $hn = &get_system_hostname();
&create_folder_maildir($dst);
if (($src->{'type'} == 1 || $src->{'type'} == 3) && $dst->{'type'} == 1) {
	# Can just move mail files
	local $dd = $dst->{'file'};
	&create_folder_maildir($dst);
	foreach $m (@_) {
		rename($m->{'file'}, "$dd/cur/$now.$$.$hn");
		$now++;
		}
	}
elsif (($src->{'type'} == 1 || $src->{'type'} == 3) && $dst->{'type'} == 3) {
	# Can move and rename to MH numbering
	local $dd = $dst->{'file'};
	local $num = &max_mhdir($dst->{'file'}) + 1;
	foreach $m (@_) {
		rename($m->{'file'}, "$dd/$num");
		$num++;
		}
	}
else {
	# Append to new folder file, or create in folder directory
	local $m;
	foreach $m (@_) {
		&write_mail_folder($m, $dst);
		}
	&mailbox_delete_mail($src, @_);
	}

# Force re-generation of source folder index
if ($src->{'sortable'}) {
	&delete_sort_index($src);
	# XXX could be faster
	}
}

# mailbox_move_folder(&source, &dest)
# Moves all mail from one folder to another, possibly converting the type
sub mailbox_move_folder
{
return undef if (&is_readonly_mode());
local ($src, $dst) = @_;
if ($src->{'type'} == $dst->{'type'}) {
	# Can just move the file or dir
	system("rm -rf ".quotemeta($dst->{'file'}));
	system("mv ".quotemeta($src->{'file'})." ".quotemeta($dst->{'file'}));
	}
else {
	# Need to copy one by one :(
	local @mails = &mailbox_list_mails(undef, undef, $src);
	&mailbox_move_mail($src, $dst, @mails);
	}

# Delete source folder index
if ($src->{'sortable'}) {
	&delete_sort_index($src);
	}
}

# mailbox_copy_mail(&source, &dest, mail, ...)
# Copy mail from one folder to another
sub mailbox_copy_mail
{
return undef if (&is_readonly_mode());
local $src = shift(@_);
local $dst = shift(@_);
local $now = time();
&create_folder_maildir($dst);
local $m;
if ($src->{'type'} == 6 && $dst->{'type'} == 6) {
	# Copying from one virtual folder to another, so just copy the
	# reference
	foreach $m (@_) {
		push(@{$dst->{'members'}}, [ $m->{'subfolder'}, $m->{'subid'},
					     $m->{'header'}->{'message-id'} ]);
		}
	}
elsif ($dst->{'type'} == 6) {
	# Add this mail to the index of the virtual folder
	foreach $m (@_) {
		push(@{$dst->{'members'}}, [ $src, $m->{'idx'},
					     $m->{'header'}->{'message-id'} ]);
		}
	&save_folder($dst);
	}
else {
	# Just write to destination folder
	foreach $m (@_) {
		&write_mail_folder($m, $dst);
		}
	}
}

# folder_type(file_or_dir)
sub folder_type
{
return -d "$_[0]/cur" ? 1 : -d $_[0] ? 3 : 0;
}

# create_folder_maildir(&folder)
# Ensure that a maildir folder has the needed new, cur and tmp directories
sub create_folder_maildir
{
mkdir($folders_dir, 0700);
if ($_[0]->{'type'} == 1) {
	local $id = $_[0]->{'file'};
	mkdir("$id/cur", 0700);
	mkdir("$id/new", 0700);
	mkdir("$id/tmp", 0700);
	}
}

# write_mail_folder(&mail, &folder, textonly)
# Writes some mail message to a folder
sub write_mail_folder
{
return undef if (&is_readonly_mode());
&create_folder_maildir($_[1]);
if ($_[1]->{'type'} == 1) {
	# Add to a maildir directory
	local $md = $_[1]->{'file'};
	&write_maildir($_[0], $md, $_[2]);
	}
elsif ($_[1]->{'type'} == 3) {
	# Create a new MH file
	local $num = &max_mhdir($_[1]->{'file'}) + 1;
	local $md = $_[1]->{'file'};
	&send_mail($_[0], "$md/$num", $_[2], 1);
	}
elsif ($_[1]->{'type'} == 0) {
	# Just append to the folder file
	&send_mail($_[0], $_[1]->{'file'}, $_[2], 1);
	}
elsif ($_[1]->{'type'} == 4) {
	# Upload to the IMAP server
	local @rv = &imap_login($_[1]);
	if ($rv[0] == 0) { &error($rv[1]); }
	elsif ($rv[0] == 3) { &error(&text('save_emailbox', $rv[1])); }
	elsif ($rv[0] == 2) { &error(&text('save_elogin2', $rv[1])); }
	local $h = $rv[1];

	# Create a temp file and use it to create the IMAP command
	local $temp = &transname();
	&send_mail($_[0], $temp, $_[2], 1);
	open(TEMP, $temp);
	local $text;
	while(<TEMP>) { $text .= $_; }
	close(TEMP);
	unlink($temp);
	@rv = &imap_command($h, sprintf "APPEND %s {%d}\r\n%s",
			$_[1]->{'mailbox'} || "INBOX", length($text), $text);
	&error(&text('save_eappend', $rv[3])) if (!$rv[0]); 
	}
elsif ($_[1]->{'type'} == 5) {
	# Just append to the last subfolder
	local @sf = @{$_[1]->{'subfolders'}};
	&write_mail_folder($_[0], $sf[$#sf], $_[2]);
	}
elsif ($_[1]->{'type'} == 6) {
	# Add mail to first sub-folder, and to virtual index
	&error("Cannot add mail to virtual folders");
	}
}

# mailbox_modify_mail(&oldmail, &newmail, &folder, textonly)
# Replaces some mail message with a new one
sub mailbox_modify_mail
{
return undef if (&is_readonly_mode());
if ($_[2]->{'type'} == 1) {
	# Just replace the existing file
	&modify_maildir($_[0], $_[1], $_[3]);
	}
elsif ($_[2]->{'type'} == 3) {
	# Just replace the existing file
	&modify_mhdir($_[0], $_[1], $_[3]);
	}
elsif ($_[2]->{'type'} == 0) {
	# Modify the mail file
	&modify_mail($_[2]->{'file'}, $_[0], $_[1], $_[3]);
	}
elsif ($_[2]->{'type'} == 5 || $_[2]->{'type'} == 6) {
	# Modify in the appropriate folder
	local ($oldsubfolder, $oldidx) = &pop_index($_[0]);
	local ($newsubfolder, $newidx) = &pop_index($_[1]);
	&mailbox_modify_mail($_[0], $_[1], $oldsubfolder, $_[3]);
	&push_index($_[0], $oldsubfolder, $oldidx);
	&push_index($_[1], $newsubfolder, $newidx);
	}
else {
	&error("Cannot modify mail in this type of folder!");
	}

# Force re-generation of folder index
if ($_[2]->{'sortable'}) {
	&delete_sort_index($_[2]);
	# XXX could be faster
	}
}

# mailbox_folder_size(&folder)
# Returns the number of messages in some folder
sub mailbox_folder_size
{
if ($_[0]->{'type'} == 0) {
	# A mbox formatted file
	return &count_mail($_[0]->{'file'});
	}
elsif ($_[0]->{'type'} == 1) {
	# A qmail maildir
	return &count_maildir($_[0]->{'file'});
	}
elsif ($_[0]->{'type'} == 2) {
	# A POP3 server
	local @rv = &pop3_login($_[0]);
	if ($rv[0] != 1) {
		if ($rv[0] == 0) { &error($rv[1]); }
		else { &error(&text('save_elogin', $rv[1])); }
		}
	local @st = &pop3_command($rv[1], "stat");
	if ($st[0] == 1) {
		local ($count, $size) = split(/\s+/, $st[1]);
		return $count;
		}
	else {
		&error($st[1]);
		}
	}
elsif ($_[0]->{'type'} == 3) {
	# An MH directory
	return &count_mhdir($_[0]->{'file'});
	}
elsif ($_[0]->{'type'} == 4) {
	# An IMAP server
	local @rv = &imap_login($_[0]);
	if ($rv[0] != 1) {
		if ($rv[0] == 0) { &error($rv[1]); }
		elsif ($rv[0] == 3) { &error(&text('save_emailbox', $rv[1])); }
		elsif ($rv[0] == 2) { &error(&text('save_elogin2', $rv[1])); }
		}
	return $rv[2];
	}
elsif ($_[0]->{'type'} == 5) {
	# A composite folder - the size is just that of the sub-folders
	my $rv = 0;
	foreach my $sf (@{$_[0]->{'subfolders'}}) {
		$rv += &mailbox_folder_size($sf);
		}
	return $rv;
	}
elsif ($_[0]->{'type'} == 6) {
	# A virtual folder .. we need to exclude messages that no longer
	# exist in the parent folders
	my $rv = 0;
	foreach my $msg (@{$_[0]->{'members'}}) {
		if (!$msg->[2] || &find_by_message_id($msg->[0], $msg->[2])) {
			$rv++;
			}
		}
	return $rv;
	}
}

# pop3_login(&folder)
# Logs into a POP3 server and returns a status (1=ok, 0=connect failed,
# 2=login failed) and handle or error message
sub pop3_login
{
local $h = $pop3_login_handle{$_[0]->{'id'}};
return (1, $h) if ($h);
$h = time().++$pop3_login_count;
local $error;
&open_socket($_[0]->{'server'}, $_[0]->{'port'} || 110, $h, \$error);
return (0, $error) if ($error);
local $os = select($h); $| = 1; select($os);
local @rv = &pop3_command($h);
return (0, $rv[1]) if (!$rv[0]);
@rv = &pop3_command($h, "user $_[0]->{'user'}");
return (2, $rv[1]) if (!$rv[0]);
@rv = &pop3_command($h, "pass $_[0]->{'pass'}");
return (2, $rv[1]) if (!$rv[0]);
return (1, $pop3_login_handle{$_[0]->{'id'}} = $h);
}

# pop3_command(handle, command)
# Executes a command and returns the status (1 or 0 for OK or ERR) and message
sub pop3_command
{
local ($h, $c) = @_;
print $h "$c\r\n" if ($c);
local $rv = <$h>;
$rv =~ s/\r|\n//g;
return !$rv ? ( 0, "Connection closed" ) :
       $rv =~ /^\+OK\s*(.*)/ ? ( 1, $1 ) :
       $rv =~ /^\-ERR\s*(.*)/ ? ( 0, $1 ) : ( 0, $rv );
}

# pop3_logout(handle, doquit)
sub pop3_logout
{
local @rv = $_[1] ? &pop3_command($_[0], "quit") : (1, undef);
local $f;
foreach $f (keys %pop3_login_handle) {
	delete($pop3_login_handle{$f}) if ($pop3_login_handle{$f} eq $_[0]);
	}
close($_[0]);
return @rv;
}

# pop3_uidl(handle)
# Returns the uidl list
sub pop3_uidl
{
local @rv;
local $h = $_[0];
local @urv = &pop3_command($h, "uidl");
if (!$urv[0] && $urv[1] =~ /not\s+implemented/i) {
	# UIDL is not available?! Use numeric list instead
	&pop3_command($h, "list");
	while(<$h>) {
		s/\r//g;
		last if ($_ eq ".\n");
		if (/^(\d+)\s+(\d+)/) {
			push(@rv, "size$2");
			}
		}
	}
elsif (!$urv[0]) {
	&error("uidl failed! $urv[1]") if (!$urv[0]);
	}
else {
	# Can get normal UIDL list
	while(<$h>) {
		s/\r//g;
		last if ($_ eq ".\n");
		if (/^(\d+)\s+(\S+)/) {
			push(@rv, $2);
			}
		}
	}
return @rv;
}

# pop3_logout_all()
# Properly closes all open POP3 and IMAP sessions
sub pop3_logout_all
{
local $f;
foreach $f (keys %pop3_login_handle) {
	&pop3_logout($pop3_login_handle{$f}, 1);
	}
foreach $f (keys %imap_login_handle) {
	&imap_logout($imap_login_handle{$f}, 1);
	}
}

# imap_login(&folder)
# Logs into a POP3 server, selects a mailbox and returns a status
# (1=ok, 0=connect failed, 2=login failed, 3=mailbox error), a handle or error
# message, and the number of messages in the mailbox.
sub imap_login
{
local $h = $imap_login_handle{$_[0]->{'id'}};
return (1, $h) if ($h);
$h = time().++$imap_login_count;
local $error;
&open_socket($_[0]->{'server'}, $_[0]->{'port'} || $imap_port, $h, \$error);
return (0, $error) if ($error);
local $os = select($h); $| = 1; select($os);

# Login normally
local @rv = &imap_command($h);
return (0, $rv[3]) if (!$rv[0]);
@rv = &imap_command($h, "login \"$_[0]->{'user'}\" \"$_[0]->{'pass'}\"");
return (2, $rv[3]) if (!$rv[0]);

# Select the right folder
@rv = &imap_command($h, "select ".($_[0]->{'mailbox'} || "INBOX"));
return (3, $rv[3]) if (!$rv[0]);
return (1, $imap_login_handle{$_[0]->{'id'}} = $h,
	$rv[2] =~ /\*\s+(\d+)\s+EXISTS/i ? $1 : undef);
}

# imap_command(handle, command)
# Executes an IMAP command and returns 1 for success or 0 for failure, and
# a reference to an array of results (some of which may be multiline), and
# all of the results joined together, and the stuff after OK/BAD
sub imap_command
{
local ($h, $c) = @_;
local @rv;

# Send the command, and read lines until a non-* one is found
local $id = $$."-".$imap_command_count++;
if ($c) {
	print $h "$id $c\r\n";
	}
while(1) {
	local $l = <$h>;
	last if (!$l);
	if ($l =~ /^(\*|\+)/) {
		# Another response, and possibly the only one if no command
		# was sent.
		push(@rv, $l);
		last if (!$c);
		if ($l =~ /\{(\d+)\}\s*$/) {
			# Start of multi-line text .. read the specified size
			local $size = $1;
			local $got;
			local $err = "Error reading email";
			while($got < $size) {
				local $buf;
				local $r = read($h, $buf, $size-$got);
				return (0, [ $err ], $err, $err) if ($r < 0);
				$rv[$#rv] .= $buf;
				$got += $r;
				}
			}
		}
	elsif ($l =~ /^(\S+)\s+/ && $1 eq $id) {
		# End of responses
		push(@rv, $l);
		last;
		}
	else {
		# Part of last response
		if (!@rv) {
			local $err = "Got unknown line $l";
			return (0, [ $err ], $err, $err);
			}
		$rv[$#rv] .= $l;
		}
	}
local $j = join("", @rv);
local $lline = $rv[$#rv];
if ($lline =~ /^(\S+)\s+OK\s*(.*)/) {
	# Looks like the command worked
	return (1, \@rv, $j, $2);
	}
else {
	# Command failed!
	return (0, \@rv, $j, $lline =~ /^(\S+)\s+(\S+)\s*(.*)/ ? $3 : undef);
	}
}

# imap_logout(handle, doquit)
sub imap_logout
{
local @rv = $_[1] ? &imap_command($_[0], "close") : (1, undef);
local $f;
foreach $f (keys %imap_login_handle) {
	delete($imap_login_handle{$f}) if ($imap_login_handle{$f} eq $_[0]);
	}
close($_[0]);
return @rv;
}

# lock_folder(&folder)
sub lock_folder
{
return if ($_[0]->{'remote'} || $_[0]->{'type'} == 5 || $_[0]->{'type'} == 6);
local $f = $_[0]->{'file'} ? $_[0]->{'file'} :
	   $_[0]->{'type'} == 0 ? &user_mail_file($remote_user) :
				  $qmail_maildir;
if (&lock_file($f)) {
	$_[0]->{'lock'} = $f;
	}
else {
	# Cannot lock if in /var/mail
	local $ff = $f;
	$ff =~ s/\//_/g;
	$ff = "/tmp/$ff";
	$_[0]->{'lock'} = $ff;
	&lock_file($ff);
	}

# Also, check for a .filename.pop3 file
if ($config{'pop_locks'} && $f =~ /^(\S+)\/([^\/]+)$/) {
	local $poplf = "$1/.$2.pop";
	local $count = 0;
	while(-r $poplf) {
		sleep(1);
		if ($count++ > 5*60) {
			# Give up after 5 minutes
			&error(&text('epop3lock_tries', "<tt>$f</tt>", 5));
			}
		}
	}
}

# unlock_folder(&folder)
sub unlock_folder
{
return if ($_[0]->{'remote'});
&unlock_file($_[0]->{'lock'});
}

# folder_file(&folder)
# Returns the full path to the file or directory containing the folder's mail,
# or undef if not appropriate (such as for POP3)
sub folder_file
{
return $_[0]->{'remote'} ? undef : $_[0]->{'file'};
}

# parse_imap_mail(response)
# Parses a response from the IMAP server into a standard mail structure
sub parse_imap_mail
{
# Extract the actual mail part
local $mail = { };
local $realsize;
local $imap = $_[0];
if ($imap =~ /RFC822.SIZE\s+(\d+)/) {
	$realsize = $1;
	}
$imap =~ s/^\*\s+\d+\s+FETCH.*\{(\d+)\}\r?\n// || return undef;
local $size = $1;
local @lines = split(/\n/, substr($imap, 0, $size));

# Parse the headers
local $lnum = 0;
local @headers;
while(1) {
	local $line = $lines[$lnum++];
	$mail->{'size'} += length($line);
	$line =~ s/\r//g;
	last if ($line eq '');
	if ($line =~ /^(\S+):\s*(.*)/) {
		push(@headers, [ $1, $2 ]);
		}
	elsif ($line =~ /^(\s+.*)/) {
		$headers[$#headers]->[1] .= $1
			unless($#headers < 0);
		}
	}
$mail->{'headers'} = \@headers;
foreach $h (@headers) {
	$mail->{'header'}->{lc($h->[0])} = $h->[1];
	}

# Parse the body
while($lnum < @lines) {
	$mail->{'size'} += length($lines[$lnum]+1);
	$mail->{'body'} .= $lines[$lnum]."\n";
	$lnum++;
	}
$mail->{'size'} = $realsize if ($realsize);
return $mail;
}

# find_body(&mail, mode)
# Returns the plain text body, html body and the one to use
sub find_body
{
local ($a, $body, $textbody, $htmlbody);
foreach $a (@{$_[0]->{'attach'}}) {
	if ($a->{'type'} =~ /^text\/plain/i || $a->{'type'} eq 'text') {
		$textbody = $a if (!$textbody && $a->{'data'} =~ /\S/);
		}
	elsif ($a->{'type'} =~ /^text\/html/i) {
		$htmlbody = $a if (!$htmlbody && $a->{'data'} =~ /\S/);
		}
	}
if ($_[1] == 0) {
	$body = $textbody;
	}
elsif ($_[1] == 1) {
	$body = $textbody || $htmlbody;
	}
elsif ($_[1] == 2) {
	$body = $htmlbody || $textbody;
	}
elsif ($_[1] == 3) {
	# Convert HTML to text if needed
	if ($textbody) {
		$body = $textbody;
		}
	else {
		local $text = &html_to_text($htmlbody->{'data'});
		$body = $textbody = 
			{ 'data' => $text };
		}
	}
return ($textbody, $htmlbody, $body);
}

# safe_html(html)
# Converts HTML to a form safe for inclusion in a page
sub safe_html
{
local $html = $_[0];
local $bodystuff;
if ($html =~ s/^[\000-\377]*<BODY(.*)>//i) {
	$bodystuff = $1;
	}
$html =~ s/<\/BODY>[\000-\377]*$//i;
$html = &filter_javascript($html);
$html = &safe_urls($html);
$bodystuff = &safe_html($bodystuff) if ($bodystuff);
return wantarray ? ($html, $bodystuff) : $html;
}

# head_html(html)
# Returns HTML in the <head> section of a document
sub head_html
{
local $html = $_[0];
return undef if ($html !~ /<HEAD[^>]*>/i || $html !~ /<\/HEAD[^>]*>/i);
$html =~ s/^[\000-\377]*<HEAD[^>]*>//gi || &error("Failed to filter <pre>".&html_escape($html)."</pre>");
$html =~ s/<\/HEAD[^>]*>[\000-\377]*//gi || &error("Failed to filter <pre>".&html_escape($html)."</pre>");
return &filter_javascript($html);
}

# safe_urls(html)
# Replaces dangerous-looking URLs in HTML
sub safe_urls
{
local $html = $_[0];
$html =~ s/((src|href|background)\s*=\s*)([^ '">]+)()/&safe_url($1, $3, $4)/gei;
$html =~ s/((src|href|background)\s*=\s*')([^']+)(')/&safe_url($1, $3, $4)/gei;
$html =~ s/((src|href|background)\s*=\s*")([^"]+)(")/&safe_url($1, $3, $4)/gei;
return $html;
}

# safe_url(before, url, after)
sub safe_url
{
local ($before, $url, $after) = @_;
if ($url =~ /^#/) {
	# Relative link - harmless
	return $before.$url.$after;
	}
elsif ($url =~ /^cid:/i) {
	# Definately safe (CIDs are harmless)
	return $before.$url.$after;
	}
elsif ($url =~ /^(http:|https:)/) {
	# Possibly safe, unless refers to local
	local ($host, $port, $page, $ssl) = &parse_http_url($url);
	local ($hhost, $hport) = split(/:/, $ENV{'HTTP_HOST'});
	$hport ||= $ENV{'SERVER_PORT'};
	if ($host ne $hhost ||
	    $port != $hport ||
	    $ssl != (uc($ENV{'HTTPS'}) eq 'ON' ? 1 : 0)) {
		return $before.$url.$after;
		}
	else {
		return $before."_unsafe_link_".$after;
		}
	}
else {
	# Relative URL like foo.cgi or /foo.cgi or ../foo.cgi - unsafe!
	return $before."_unsafe_link_".$after;
	}
}

# safe_uidl(string)
sub safe_uidl
{
local $rv = $_[0];
$rv =~ s/\/|\./_/g;
return $rv;
}

# html_to_text(html)
# Attempts to convert some HTML to text form
sub html_to_text
{
local ($h2, $lynx);
if (($h2 = &has_command("html2text")) || ($lynx = &has_command("lynx"))) {
	# Can use a commonly available external program
	local $temp = &transname().".html";
	open(TEMP, ">$temp");
	print TEMP $_[0];
	close(TEMP);
	open(OUT, ($lynx ? "$lynx -dump $temp" : "$h2 $temp")." 2>/dev/null |");
	while(<OUT>) {
		if ($lynx && $_ =~ /^\s*References\s*$/) {
			# Start of Lynx references output
			$gotrefs++;
			}
		elsif ($lynx && $gotrefs &&
		       $_ =~ /^\s*(\d+)\.\s+(http|https|ftp|mailto)/) {
			# Skip this URL reference line
			}
		else {
			$text .= $_;
			}
		}
	close(OUT);
	unlink($temp);
	return $text;
	}
else {
	# Do conversion manually :(
	local $html = $_[0];
	$html =~ s/\s+/ /g;
	$html =~ s/<p>/\n\n/gi;
	$html =~ s/<br>/\n/gi;
	$html =~ s/<[^>]+>//g;
	$html = &entities_to_ascii($html);
	return $html;
	}
}

# folder_select(&folders, selected-folder, name, [extra-options])
# Returns HTML for selecting a folder
sub folder_select
{
local $sel = "<select name=$_[2]>\n";
$sel .= $_[3];
local $f;
foreach $f (@{$_[0]}) {
	next if ($f->{'hide'} && $f ne $_[1]);
	$sel .= sprintf "<option value=%d %s>%s\n",
		$f->{'index'}, $f eq $_[1] ? "selected" : "",
		$f->{'name'};
	}
$sel .= "</select>\n";
return $sel;
}

# folder_size(&folder, ...)
# Sets the 'size' field of one or more folders, and returns the total
sub folder_size
{
local ($f, $total);
foreach $f (@_) {
	if ($f->{'type'} == 0) {
		# Single mail file - size is easy
		local @st = stat($f->{'file'});
		$f->{'size'} = $st[7];
		}
	elsif ($f->{'type'} == 1) {
		# Maildir folder size is that of all mail files
		local $qd;
		$f->{'size'} = 0;
		foreach $qd ('cur', 'new') {
			local $mf;
			opendir(QDIR, "$f->{'file'}/$qd");
			while($mf = readdir(QDIR)) {
				next if ($mf eq "." || $mf eq "..");
				local @st = stat("$f->{'file'}/$qd/$mf");
				$f->{'size'} += $st[7];
				}
			closedir(QDIR);
			}
		}
	elsif ($f->{'type'} == 3) {
		# MH folder size is that of all mail files
		local $mf;
		$f->{'size'} = 0;
		opendir(MHDIR, $f->{'file'});
		while($mf = readdir(MHDIR)) {
			next if ($mf eq "." || $mf eq "..");
			local @st = stat("$f->{'file'}/$mf");
			$f->{'size'} += $st[7];
			}
		closedir(MHDIR);
		}
	elsif ($f->{'type'} == 5) {
		# Size of a combined folder is the size of all sub-folders
		return &folder_size(@{$f->{'subfolders'}});
		}
	else {
		# Cannot get size of a remote folder
		$f->{'size'} = undef;
		}
	$total += $f->{'size'};
	}
return $total;
}

# parse_boolean(string)
# Separates a string into a series of and/or separated values. Returns a
# mode number (0=or, 1=and, 2=both) and a list of words
sub parse_boolean
{
local @rv;
local $str = $_[0];
local $mode = -1;
local $lastandor = 0;
while($str =~ /^\s*"([^"]*)"(.*)$/ ||
      $str =~ /^\s*"([^"]*)"(.*)$/ ||
      $str =~ /^\s*(\S+)(.*)$/) {
	local $word = $1;
	$str = $2;
	if (lc($word) eq "and") {
		if ($mode < 0) { $mode = 1; }
		elsif ($mode != 1) { $mode = 2; }
		$lastandor = 1;
		}
	elsif (lc($word) eq "or") {
		if ($mode < 0) { $mode = 0; }
		elsif ($mode != 0) { $mode = 2; }
		$lastandor = 1;
		}
	else {
		if (!$lastandor && @rv) {
			$rv[$#rv] .= " ".$word;
			}
		else {
			push(@rv, $word);
			}
		$lastandor = 0;
		}
	}
$mode = 0 if ($mode < 0);
return ($mode, \@rv);
}

# recursive_files(dir, treat-dirs-as-folders)
sub recursive_files
{
local ($f, @rv);
opendir(DIR, $_[0]);
local @files = readdir(DIR);
closedir(DIR);
foreach $f (@files) {
	next if ($f eq "." || $f eq ".." || $f =~ /\.lock$/i ||
		 $f eq "cur" || $f eq "tmp" || $f eq "new" ||
		 $f =~ /^\.imap/i || $f eq ".customflags" ||
		 $f eq "dovecot-uidlist" || $f =~ /^courierimap/ ||
		 $f eq "maildirfolder" || $f eq "maildirsize");
	local $p = "$_[0]/$f";
	local $added = 0;
	if ($_[1] || !-d $p || -d "$p/cur") {
		push(@rv, $p);
		$added = 1;
		}
	# If this directory wasn't a folder (or it it in Maildir format),
	# search it too.
	if (-d "$p/cur" || !$added) {
		push(@rv, &recursive_files($p));
		}
	}
return @rv;
}

# editable_mail(&mail)
# Returns 0 if some mail message should not be editable (ie. internal folder)
sub editable_mail
{
return $_[0]->{'header'}->{'subject'} !~ /DON'T DELETE THIS MESSAGE.*FOLDER INTERNAL DATA/;
}

# fix_cids(html, &attachments, url-prefix, &cid-list)
# Replaces HTML like img src=cid:XXX with img src=detach.cgi?whatever
sub fix_cids
{
local $rv = $_[0];
$rv =~ s/(src="|href=")cid:([^"]+)(")/$1.&fix_cid($2,$_[1],$_[2],$_[3]).$3/gei;
$rv =~ s/(src='|href=')cid:([^']+)(')/$1.&fix_cid($2,$_[1],$_[2],$_[3]).$3/gei;
$rv =~ s/(src=|href=)cid:([^\s>]+)()/$1.&fix_cid($2,$_[1],$_[2],$_[3]).$3/gei;
return $rv;
}

# fix_cid(cid, &attachments, url-prefix, &cid-list)
sub fix_cid
{
local ($cont) = grep { $_->{'header'}->{'content-id'} eq $_[0] ||
		       $_->{'header'}->{'content-id'} eq "<$_[0]>" } @{$_[1]};
return "cid:$_[0]" if (!$cont);
push(@{$_[3]}, $cont) if ($_[3]);
return "$_[2]&attach=$cont->{'idx'}";
}

# quoted_message(&mail, quote-mode, sig, 0=any,1=text,2=html)
# Returns the quoted text, html-flag and body attachment
sub quoted_message
{
local ($mail, $qu, $sig, $bodymode) = @_;
local $mode = $bodymode == 1 ? 1 :
	      $bodymode == 2 ? 2 :
	      defined(%userconfig) ? $userconfig{'view_html'} :
				     $config{'view_html'};
local ($plainbody, $htmlbody) = &find_body($mail, $mode);
local ($quote, $html_edit, $body);
local $cfg = defined(%userconfig) ? \%userconfig : \%config;
local @writers = &split_addresses($mail->{'header'}->{'from'});
local $writer = ($writers[0]->[1] || $writers[0]->[0])." wrote ..";
local $tm;
if ($cfg->{'reply_date'} &&
    ($tm = &parse_mail_date($_[0]->{'header'}->{'date'}))) {
	local $tmstr = &make_date($tm);
	$writer = "On $tmstr $writer";
	}
local $qm = defined(%userconfig) ? $userconfig{'html_quote'}
				 : $config{'html_quote'};
if (($cfg->{'html_edit'} == 2 ||
     $cfg->{'html_edit'} == 1 && $htmlbody) &&
     $bodymode != 1) {
	# Create quoted body HTML
	if ($htmlbody) {
		$body = $htmlbody;
		$sig =~ s/\n/<br>\n/g;
		if ($qu && $qm == 0) {
			# Quoted HTML as cite
			$quote = "$writer\n".
				 "<blockquote type=cite>\n".
				 &safe_html($htmlbody->{'data'}).
				 "</blockquote>".$sig."<br>\n";
			}
		elsif ($qu && $qm == 1) {
			# Quoted HTML below line
			$quote = "<br>$sig<hr>".
			         "$writer<br>\n".
				 &safe_html($htmlbody->{'data'});
			}
		else {
			# Un-quoted HTML
			$quote = &safe_html($htmlbody->{'data'}).
				 $sig."<br>\n";
			}
		}
	elsif ($plainbody) {
		$body = $plainbody;
		local $pd = $plainbody->{'data'};
		$pd =~ s/^\s+//g;
		$pd =~ s/\s+$//g;
		if ($qu && $qm == 0) {
			# Quoted plain text as HTML as cite
			$quote = "$writer\n".
				 "<blockquote type=cite>\n".
				 "<pre>$pd</pre>".
				 "</blockquote>".$sig."<br>\n";
			}
		elsif ($qu && $qm == 1) {
			# Quoted plain text as HTML below line
			$quote = "<br>$sig<hr>".
				 "$writer<br>\n".
				 "<pre>$pd</pre><br>\n";
			}
		else {
			# Un-quoted plain text as HTML
			$quote = "<pre>$pd</pre>".
				 $sig."<br>\n";
			}
		}
	$html_edit = 1;
	}
else {
	# Create quoted body text
	if ($plainbody) {
		$body = $plainbody;
		$quote = $plainbody->{'data'};
		}
	elsif ($htmlbody) {
		$body = $htmlbody;
		$quote = &html_to_text($htmlbody->{'data'});
		}
	if ($quote && $qu) {
		$quote = join("", map { "> $_\n" }
			&wrap_lines($quote, 70));
		}
	$quote = $writer."\n".$quote if ($quote && $qu);
	$quote .= "$sig\n" if ($sig);
	}
return ($quote, $html_edit, $body);
}

# modification_time(&folder)
# Returns the unix time on which this folder was last modified, or 0 if unknown
sub modification_time
{
if ($_[0]->{'type'} == 0) {
	# Modification time of file
	local @st = stat($_[0]->{'file'});
	return $st[9];
	}
elsif ($_[0]->{'type'} == 1) {
	# Greatest modification time of cur/new directory
	local @stcur = stat("$_[0]->{'file'}/cur");
	local @stnew = stat("$_[0]->{'file'}/new");
	return $stcur[9] > $stnew[9] ? $stcur[9] : $stnew[9];
	}
elsif ($_[0]->{'type'} == 2 || $_[0]->{'type'} == 4) {
	# Cannot know for POP3 or IMAP folders
	return 0;
	}
elsif ($_[0]->{'type'} == 3) {
	# Modification time of MH folder
	local @st = stat($_[0]->{'file'});
	return $st[9];
	}
else {
	# Huh?
	return 0;
	}
}

# requires_delivery_notification(&mail)
sub requires_delivery_notification
{
return $_[0]->{'header'}->{'disposition-notification-to'} ||
       $_[0]->{'header'}->{'read-reciept-to'};
}

# send_delivery_notification(&mail, [from-addr], manual)
# Send an email containing delivery status information
sub send_delivery_notification
{
local ($mail, $from) = @_;
$from ||= $mail->{'header'}->{'to'};
local $host = &get_display_hostname();
local $to = &requires_delivery_notification($mail);
local $product = &get_product_name();
$product = ucfirst($product);
local $version = &get_webmin_version();
local ($taddr) = &split_addresses($mail->{'header'}->{'to'});
local $disp = $manual ? "manual-action/MDN-sent-manually"
		      : "automatic-action/MDN-sent-automatically";
local $dsn = <<EOF;
Reporting-UA: $host; $product $version
Original-Recipient: rfc822;$taddr->[0]
Final-Recipient: rfc822;$taddr->[0]
Original-Message-ID: $mail->{'header'}->{'message-id'}
Disposition: $disp; displayed
EOF
local $dmail = {
	'headers' =>
	   [ [ 'From' => $from ],
	     [ 'To' => $to ],
	     [ 'Subject' => 'Delivery notification' ],
	     [ 'Content-type' => 'multipart/report; report-type=disposition-notification' ],
	     [ 'Content-Transfer-Encoding' => '7bit' ] ],
	'attach' => [
	   { 'headers' => [ [ 'Content-type' => 'text/plain' ] ],
	     'data' => "This is a delivery status notification for the email sent to:\n$mail->{'header'}->{'to'}\non the date:\n$mail->{'header'}->{'date'}\nwith the subject:\n$mail->{'header'}->{'subject'}\n" },
	   { 'headers' => [ [ 'Content-type' =>
				'message/disposition-notification' ],
			    [ 'Content-Transfer-Encoding' => '7bit' ] ],
	     'data' => $dsn }
		] };
eval { local $main::errors_must_die = 1; &send_mail($dmail); };
return $to;
}

# find_named_folder(name, &folders, [&cache])
# Finds a folder by ID, filename, server name or displayed name
sub find_named_folder
{
local $rv;
if ($_[2] && exists($_[2]->{$_[0]})) {
	# In cache
	$rv = $_[2]->{$_[0]};
	}
else {
	# Need to lookup
	($rv) = grep { $_->{'id'} eq $_[0] } @{$_[1]} if (!$rv);
	($rv) = grep { my $escfile = $_->{'file'};
		       $escfile =~ s/\s/_/g;
		       $escfile eq $_[0] ||
		       $_->{'file'} eq $_[0] ||
		       $_->{'server'} eq $_[0] } @{$_[1]} if (!$rv);
	($rv) = grep { my $escname = $_->{'name'};
		       $escname =~ s/\s/_/g;
		       $escname eq $_[0] ||
		       $_->{'name'} eq $_[0] } @{$_[1]} if (!$rv);
	$_[2]->{$_[0]} = $rv if ($_[2]);
	}
return $rv;
}

# folder_name(&folder)
# Returns a unique identifier for a folder, based on it's filename or ID
sub folder_name
{
my $rv = $_[0]->{'id'} ||
         $_[0]->{'file'} ||
         $_[0]->{'server'} ||
         $_[0]->{'name'};
$rv =~ s/\s/_/g;
return $rv;
}

# set_folder_lastmodified(&folders)
# Sets the last-modified time and sortable flag on all given folders
sub set_folder_lastmodified
{
local ($folders) = @_;
foreach my $folder (@$folders) {
	if ($folder->{'type'} == 0 || $folder->{'type'} == 3) {
		# For an mbox or MH folder, the last modified date is just that
		# of the file or directory itself
		local @st = stat($folder->{'file'});
		$folder->{'lastchange'} = $st[9];
		$folder->{'sortable'} = 1;
		}
	elsif ($folder->{'type'} == 1) {
		# For a Maildir folder, the date is that of the newest
		# sub-directory (cur, tmp or new)
		$folder->{'lastchange'} = 0;
		foreach my $sf ("cur", "tmp", "new") {
			local @st = stat("$folder->{'file'}/$sf");
			$folder->{'lastchange'} = $st[9]
				if ($st[9] > $folder->{'lastchange'});
			}
		$folder->{'sortable'} = 1;
		}
	elsif ($folder->{'type'} == 6) {
		# For a virtual folder, the date is that of the newest
		# sub-folder, OR the folder file itself
		local @st = stat($folder->{'folderfile'});
		$folder->{'lastchange'} = $st[9];
		my %done;
		foreach my $m (@{$folder->{'members'}}) {
			if (!$done{$m->[0]}++) {
				&set_folder_lastmodified([ $m->[0] ]);
				$folder->{'lastchange'} =
					$m->[0]->{'lastchange'}
					if ($m->[0]->{'lastchange'} >
					    $folder->{'lastchange'});
				}
			}
		$folder->{'sortable'} = 1;
		}
	else {
		$folder->{'sortable'} = 0;
		}
	}
}

# push_index(&mail, &folder, new-index)
# Adjusts the index of some email to the new one, and stores the old
# index and folder
sub push_index
{
local ($mail, $folder, $newidx) = @_;
unshift(@{$mail->{'subs'}}, [ $mail->{'subfolder'}, $mail->{'idx'} ]);
$mail->{'subidx'} = $mail->{'subs'}->[0]->[1];
$mail->{'subfolder'} = $folder;
$mail->{'idx'} = $newidx;
}

# pop_index(&mail)
# Removes the stored sub-folder and index, and restores the original index.
# Returns the original sub-folder and index.
sub pop_index
{
local ($mail) = @_;
local $old = shift(@{$mail->{'subs'}});
$mail->{'subidx'} = $mail->{'subs'}->[0]->[1];
local @rv = ( $mail->{'subfolder'}, $mail->{'idx'} );
$mail->{'subfolder'} = $old->[0];
$mail->{'idx'} = $old->[1];
return @rv;
}

# mail_preview(&mail)
# Returns a short text preview of a message body
sub mail_preview
{
local ($textbody, $htmlbody, $body) = &find_body($_[0], 0);
local $data = $body->{'data'};
$data =~ s/\r?\n/ /g;
$data = substr($data, 0, 100);
if ($data =~ /\S/) {
	return $data;
	}
return undef;
}

1;

