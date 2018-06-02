# mailboxes-lib.pl
# Common functions for reading user mailboxes

do '../web-lib.pl';
do '../ui-lib.pl';
do 'boxes-lib.pl';
do 'folders-lib.pl';
&init_config();
%access = &get_module_acl();
$config{'perpage'} ||= 20;
$gconfig{'logfiles'} = 0;	# file change logging never needs to be done

# Always detect the mail system if not set
if ($config{'mail_system'} == 3) {
	$config{'mail_system'} = &detect_mail_system();
	&save_module_config() if ($config{'mail_system'} != 3);
	}

# send_mail_program(from, to)
# Returns the command for injecting email, based on the mail system in use
sub send_mail_program
{
if ($config{'mail_system'} == 1 || $config{'mail_system'} == 0) {
	# Use sendmail executable, or postfix wrapper
	local %sconfig = &foreign_check("sendmail") &&
			 $config{'mail_system'} == 1 ?
				&foreign_config("sendmail") : ( );
	local $cmd = &has_command($sconfig{'sendmail_path'} || "sendmail");
	return "$cmd -t -f".quotemeta($_[0]) if ($cmd);
	}
elsif ($config{'mail_system'} == 2) {
	# Use qmail injector
	local %qconfig = &foreign_check("qmailadmin") ?
				&foreign_config("qmailadmin") : ( );
	local $cmd = ($qconfig{'qmail_dir'} || "/var/qmail").
		     "/bin/qmail-inject";
	return $cmd if (-x $cmd);
	}
else {
	# Fallback - use sendmail command
	local $cmd = &has_command("sendmail");
	return "$cmd -t -f".quotemeta($_[0]) if ($cmd);
	}
return undef;
}

# list_folders()
# Returns a list of all mailboxes for all users
sub list_folders
{
local (@rv, $uinfo);
foreach $uinfo (&list_mail_users()) {
	push(@rv, &list_user_folders(@$uinfo));
	}
return @rv;
}

# list_user_folders(user, [other info])
# Returns a list of folders for mailboxes belonging to some user
sub list_user_folders
{
if ($_[0] =~ /^\//) {
	# A path .. return a folder just for it
	return ( { 'name' => $_[0],
		   'file' => $_[0],
		   'type' => &folder_type($_[0]),
		   'mode' => 1,
		   'index' => 0 } );
	}
else {
	# Getting folders for a user
	local @uinfo = @_ > 1 ? @_ : &get_mail_user($_[0]);
	return ( ) if (!@uinfo);
	local ($dir, $style, $mailbox, $maildir) = &get_mail_style();
	local @rv;

	# Check for user-specified mail store
	if ($uinfo[10]) {
		push(@rv, { 'name' => $uinfo[10],
			    'file' => $uinfo[10],
			    'type' => &folder_type($uinfo[10]),
			    'mode' => 0,
			    'index' => scalar(@rv) } );
		}

	# Check for /var/mail/USERNAME file
	if ($dir) {
		local $mf = &mail_file_style($uinfo[0], $dir, $style);
		push(@rv, { 'type' => 0,
			    'name' => $mf,
			    'file' => $mf,
			    'user' => $uinfo[0],
			    'index' => scalar(@rv) });
		}

	# Check for file in home dir
	if ($mailbox) {
		local $mf = "$uinfo[7]/$mailbox";
		if (-r $mf || !@rv) {
			push(@rv, { 'type' => 0,
				    'name' => $mf,
				    'file' => $mf,
				    'user' => $uinfo[0],
				    'index' => scalar(@rv) });
			}
		}

	# Check for directory in home dir
	if ($maildir) {
		local $mf = "$uinfo[7]/$maildir";
		if (-d $mf || !@rv) {
			push(@rv, { 'type' => 1,
				    'name' => $mf."/",
				    'file' => $mf,
				    'user' => $uinfo[0],
				    'index' => scalar(@rv) });
			}
		}

	# Add any ~/mail files
	if ($config{'mail_usermin'}) {
		local $folders_dir = "$uinfo[7]/$config{'mail_usermin'}";
		foreach $p (&recursive_files($folders_dir, 1)) {
			local $f = $p;
			$f =~ s/^\Q$folders_dir\E\///;
			push(@rv, { 'name' => $p,
				    'file' => $p,
				    'type' => &folder_type($p),
				    'mode' => 0,
				    'sent' => $f eq "sentmail",
				    'index' => scalar(@rv) } );
			}
		}

	# Add any Usermin external mail files
	if ($config{'mailbox_user'}) {
		local %userconfig;
		&read_file_cached("$uinfo[7]/$config{'mailbox_user'}/config",
				  \%userconfig);
		local $o;
		foreach $o (split(/\t+/, $userconfig{'mailboxes'})) {
			$o =~ /\/([^\/]+)$/ || next;
			push(@rv, { 'name' => $o,
				    'file' => $o,
				    'type' => &folder_type($o),
				    'mode' => 1,
				    'index' => scalar(@rv) } );
			}
		}

	return @rv;
	}
}

sub list_user_folders_sorted
{
return &list_user_folders(@_);
}

# get_mail_style()
# Returns a list containing the mail base directory, directory style,
# mail file in home dir, and maildir in home dir
sub get_mail_style
{
if (!defined(@mail_style_cache)) {
	if ($config{'auto'}) {
		# Based on mail server
		if ($config{'mail_system'} == 1) {
			# Can get paths from Sendmail module config
			local %sconfig = &foreign_config("sendmail");
			if ($sconfig{'mail_dir'}) {
				return ($sconfig{'mail_dir'}, $sconfig{'mail_style'}, undef, undef);
				}
			else {
				return (undef, $sconfig{'mail_style'}, $sconfig{'mail_file'}, undef);
				}
			}
		elsif ($config{'mail_system'} == 0) {
			# Need to query Postfix module for paths
			&foreign_require("postfix", "postfix-lib.pl");
			local @s = &postfix::postfix_mail_system();
			if ($s[0] == 0) {
				return ($s[1], 0, undef, undef);
				}
			elsif ($s[0] == 1) {
				return (undef, 0, $s[1], undef);
				}
			elsif ($s[0] == 2) {
				return (undef, 0, undef, $s[1]);
				}
			}
		elsif ($config{'mail_system'} == 2) {
			# Need to check qmail module config for paths
			local %qconfig = &foreign_config("qmailadmin");
			if ($qconfig{'mail_system'} == 1) {
				return (undef, 0, undef,
					$qconfig{'mail_dir_qmail'});
				}
			elsif ($qconfig{'mail_dir'}) {
				return ($qconfig{'mail_dir'}, $qconfig{'mail_style'}, undef, undef);
				}
			else {
				return (undef, $qconfig{'mail_style'}, $qconfig{'mail_file'}, undef);
				}
			}
		elsif ($config{'mail_system'} == 4) {
			# Qmail+LDAP uses mail file attribute .. so this is
			# never really called.
			}
		elsif ($config{'mail_system'} == 5) {
			# vpopmail always uses ~/Maildir
			return ( undef, 0, undef, "Maildir" );
			}
		else {
			# No mail server set yet!
			return (undef, undef, undef, undef);
			}
		}
	else {
		# Use config settings
		@mail_style_cache = ($config{'mail_dir'}, $config{'mail_style'},
				     $config{'mail_file'}, $config{'mail_sub'});
		}
	}
return @mail_style_cache;
}

# can_user(username, [other details])
sub can_user
{
#$_[0]="administrator";
#$remote_user="administrator";
if (!&is_user($_[0])) {
	# For external files, check if the file is under an allowed
	# directory, or owned by an allowed user.
	local @st = stat($_[0]);
	local @uinfo = &get_mail_uid($st[4]);
	return 1 if (@uinfo && &can_user(@uinfo));
	local $dir = &allowed_directory();
	return defined($dir) && &is_under_directory($dir, $_[0]);
	}
local @u = @_ > 1 ? @_ : &get_mail_user($_[0]);
return 1 if ($_[0] && $access{'sent'} eq $_[0]);
return 1 if ($access{'mmode'} == 1);
return 0 if (!@u);
return 0 if ($_[0] =~ /\.\./);
return 0 if ($access{'mmode'} == 0);
local $u;
if ($access{'mmode'} == 2) {
	# Is user in list of users?
	foreach $u (split(/\s+/, $access{'musers'})) {
		return 1 if ($u eq $_[0]);
		}
	return 0;
	}
elsif ($access{'mmode'} == 4) {
	# Is user the current Webmin user?
	return 1 if ($_[0] eq $remote_user);
	}
elsif ($access{'mmode'} == 5) {
	# Is the user's gid in the list of groups?
	local $gid;
	foreach $gid (split(/\s+/, $access{'musers'})) {
		return 1 if ($u[3] eq $gid);
		if ($access{'msec'}) {
			# Check user's secondary groups too
			local @ginfo = getgrgid($gid);
			local @m = split(/\s+/, $ginfo[3]);
			return 1 if (&indexof($_[0], @m) >= 0);
			}
		}
	}
elsif ($access{'mmode'} == 3) {
	# Is the user not in the list of denied users
	foreach $u (split(/\s+/, $access{'musers'})) {
		return 0 if ($u eq $_[0]);
		}
	return 1;
	}
elsif ($access{'mmode'} == 6) {
	# Does the user match a regexp?
	return ($_[0] =~ /^$access{'musers'}$/);
	}
elsif ($access{'mmode'} == 7) {
	# Is the user's UID within the allowed range?
	return (!$access{'musers'} || $u[2] >= $access{'musers'}) &&
	       (!$access{'musers2'} || $u[2] <= $access{'musers2'});
	}
return 0;	# can't happen!
}

# movecopy_user_select(number, folders, folder, form-no)
# Returns HTML for entering a username to copy mail to
sub movecopy_user_select
{
local $rv;
$rv .= "<input type=submit name=move$_[0] value=\"$text{'mail_move'}\" ".
       "onClick='return check_clicks(form)'>";
$rv .= "<input type=submit name=copy$_[0] value=\"$text{'mail_copy'}\" ".
       "onClick='return check_clicks(form)'>";
$rv .= &ui_user_textbox("mfolder$_[0]", undef, $_[3]);
return $rv;
}

# need_delete_warn(&folder)
sub need_delete_warn
{
return 1 if ($config{'delete_warn'} eq 'y');
return 0 if ($config{'delete_warn'} eq 'n');
local $mf;
return $_[0]->{'type'} == 0 &&
       ($mf = &folder_file($_[0])) &&
       &disk_usage_kb($mf)*1024 > $config{'delete_warn'};
}

@mail_system_modules = (
			 [ undef, 4, \&check_qmail_ldap ],
			 [ undef, 5, \&check_vpopmail ],
			 [ "qmailadmin", 2 ],
			 [ "postfix", 0 ],
			 [ "sendmail", 1 ],
			);

# detect_mail_system()
# Works out which mail server is installed
sub detect_mail_system
{
foreach $m (@mail_system_modules) {
	return $m->[1] if (&check_mail_system($m));
	}
return 3;
}

# check_mail_system(&mailsystem)
sub check_mail_system
{
if ($_[0]->[0]) {
	# Just check module
	return &foreign_installed($_[0]->[0]);
	}
else {
	# Call function
	local $func = $_[0]->[2];
	return &$func($_[0]);
	}
}

# check_qmail_ldap()
# Make sure Qmail with LDAP extensions is installed
sub check_qmail_ldap
{
return 0 if (&foreign_installed("qmailadmin", 1) != 2);
local %qconfig = &foreign_config("qmailadmin");
return 0 if (!-r "$qconfig{'qmail_dir'}/control/ldapserver");
return 1;
}

# check_vpopmail()
# Make sure Qmail with VPopMail extensions is installed
sub check_vpopmail
{
return 0 if (&foreign_installed("qmailadmin", 1) != 2);
return -x "$config{'vpopmail_dir'}/bin/vadddomain";
}

# show_users_table(&users-list, [only-with-mail])
# Outputs HTML for a table of users, with the appropriate sorting and mode
sub show_users_table
{
local @users = @{$_[0]};
local ($u, %size, %incount, %sentcount);
if ($config{'sort_mode'} == 2 || $config{'show_size'} > 0 || $_[1] ||
    $config{'show_count'} || $config{'show_sent'}) {
	# Need to check folders
	foreach $u (@users) {
		local @folders = &list_user_folders(@$u);
		if ($config{'sort_mode'} == 2 ||
		    $config{'show_size'} > 0 || $_[1]) {
			# Compute size of folders
			$size{$u->[0]} = $config{'size_mode'} ?
						&folder_size(@folders) :
						&folder_size($folders[0]);
			}
		if ($config{'show_count'}) {
			# Get number of mails in inbox
			$incount{$u->[0]} = &mailbox_folder_size($folders[0]);
			}
		if ($config{'show_sent'}) {
			# Count number of messages in sent mail
			local ($sent) = grep { $_->{'sent'} } @folders;
			$sentcount{$u->[0]} = &mailbox_folder_size($sent)
				if ($sent);
			}
		}
	}

# Sort by chosen mode
if ($config{'sort_mode'} == 2) {
	@users = sort { $size{$b->[0]} <=> $size{$a->[0]} } @users;
	}
elsif ($config{'sort_mode'} == 1) {
	@users = sort { lc($a->[0]) cmp lc($b->[0]) } @users;
	}

if ($_[1]) {
	# Limit to those with mail
	local @mailonlyusers = grep { $size{$_->[0]} } @users;
	@users = @mailonlyusers if (@mailonlyusers);
	}

# Show table of users
if ($config{'show_size'} == 2) {
	# Show full user details
	local %uconfig = &foreign_config("useradmin");
	local @ccols;
	push(@ccols, $text{'find_incount'}) if ($config{'show_count'});
	push(@ccols, $text{'find_sentcount'}) if ($config{'show_sent'});
	print &ui_columns_start( [ $text{'find_user'}, $text{'find_real'},
				   $text{'find_group'}, $text{'find_home'},
				   $text{'find_size'}, @ccols ], 100);
	foreach $u (@users) {
		local $g = getgrgid($u->[3]);
		$u->[6] =~ s/,.*$// if ($uconfig{'extra_real'});
		local $home = $u->[7];
		if (length($home) > 30) {
			$home = "...".substr($home, -30);
			}
		local @ccols;
		push(@ccols,int($incount{$u->[0]})) if ($config{'show_count'});
		push(@ccols,int($sentcount{$u->[0]})) if ($config{'show_sent'});
		print &ui_columns_row(
			[ "<a href='list_mail.cgi?user=$u->[0]'>$u->[0]</a>",
			  $u->[6], $g, $home,
			  $size{$u->[0]} == 0 ? $text{'index_empty'} :
				&nice_size($size{$u->[0]}),
			  @ccols ],
			[ undef, undef, undef, undef, "nowrap" ]);
		}
	print &ui_columns_end();
	}
else {
	# Just showing username (and maybe size)
	print &ui_table_start($text{'index_header'}, "width=100%", 4);
	local $i = 0;
	foreach $u (@users) {
		print "<tr>\n" if ($i%4 == 0);
		print "<td width=25%><a href='list_mail.cgi?user=$u->[0]'>";
		print $u->[0];
		if ($config{'show_size'} == 1) {
			local @folders = &list_user_folders(@$u);
			local $total = &folder_size(@folders);
			if ($size{$u->[0]} > 0) {
				print " (",&nice_size($size{$u->[0]}),")";
				}
			}
		print "</a></td>\n";
		print "</tr>\n" if ($i%4 == 3);
		$i++;
		}
	if ($i%4) {
		while($i++%4) { print "<td width=25%></td>\n"; }
		print "</tr>\n";
		}
	print &ui_table_end();
	}
}

# switch_to_user(user)
# Switch to the Unix user that files are accessed as.
sub switch_to_user
{
if (!defined($old_uid)) {
        local @uinfo = &get_mail_user($_[0]);
        $old_uid = $>;
        $old_gid = $);
        $) = "$uinfo[3] $uinfo[3]";
        $> = $uinfo[2];
        }
}

sub switch_user_back
{
if (defined($old_uid)) {
        $> = $old_uid;
        $) = $old_gid;
        $old_uid = $old_gid = undef;
        }
}

sub folder_link
{
return "<a href='list_mail.cgi?user=$_[0]&folder=$_[1]->{'index'}'>$text{'mail_return2'}</a>";
}

# get_from_address()
# Returns the address to use when sending email from a script
sub get_from_address
{
local $host = &get_from_domain();
if ($config{'webmin_from'} =~ /\@/) {
	return $config{'webmin_from'};
	}
elsif (!$config{'webmin_from'}) {
	return "webmin\@$host";
	}
else {
	return "$config{'webmin_from'}\@$host";
	}
}

# get_from_domain()
# Returns the default domain for From: addresses
sub get_from_domain
{
return $config{'from_dom'} || &get_display_hostname();
}

# get_user_from_address(&uinfo)
# Returns the default From: address for mail sent from some user's mailbox
sub get_user_from_address
{
local $uinfo = $_[0];
if ($config{'from_addr'}) {
	return $config{'from_addr'};
	}
elsif ($uinfo->[11]) {
	return $uinfo->[11];
	}
elsif ($config{'from_virtualmin'} && &foreign_check("virtual-server")) {
	# Does Virtualmin manage this user?
	&foreign_require("virtual-server", "virtual-server-lib.pl");
	local $d;
	foreach $d (&virtual_server::list_domains()) {
		local @users = &virtual_server::list_domain_users($d, 0, 0, 1);
		local $u;
		foreach $u (@users) {
			if ($u->{'user'} eq $uinfo->[0] && $u->{'email'}) {
				# Found him!
				return $u->{'email'};
				}
			}
		}
	}
if ($uinfo->[0] =~ /\@/) {
	return $uinfo->[0];
	}
else {
	return $uinfo->[0].'@'.&get_from_domain();
	}
}

# check_modification(&folder)
# Display an error message if a folder has been modified since the time
# in $in{'mod'}
sub check_modification
{
local $newmod = &modification_time($_[0]);
if ($in{'mod'} && $in{'mod'} != $newmod && $config{'check_mod'}) {
	# Changed!
	&error(&text('emodified', "list_mail.cgi?user=$in{'user'}&folder=$_[0]->{'index'}"));
	}
}

# spam_report_cmd(user)
# Returns a command for reporting spam, or undef if none
sub spam_report_cmd
{
local ($user) = @_;
local %sconfig = &foreign_config("spam");
local $cmd;
if ($config{'spam_report'} eq 'sa_learn') {
        $cmd = &has_command($sconfig{'sa_learn'}) ? "$sconfig{'sa_learn'} --spam --mbox" : undef;
        }
elsif ($config{'spam_report'} eq 'spamassassin') {
        $cmd = &has_command($sconfig{'spamassassin'}) ? "$sconfig{'spamassassin'} --r" : undef;
        }
else {
        $cmd = &has_command($sconfig{'sa_learn'}) ?
                "$sconfig{'sa_learn'} --spam --mbox" :
               &has_command($sconfig{'spamassassin'}) ?
                "$sconfig{'spamassassin'} --r" : undef;
        }
return $user eq "root" ? $cmd :
       $cmd ? &command_as_user($user, 0, $cmd) : undef;
}

# allowed_directory()
# Returns base directory for mail files, or undef if not allowed
sub allowed_directory
{
if ($access{'dir'}) {
	return $access{'dir'};
	}
else {
	return $access{'mmode'} == 1 ? "/" : undef;
	}
}

# is_user(user)
sub is_user
{
return $_[0] !~ /^\//;
}

# list_mail_users()
# Returns getpw* style structures for all users who can recieve mail
sub list_mail_users
{
local @rv;
if ($config{'mail_system'} < 3) {
	# Postfix, Sendmail and Qmail all use Unix users
	local %found;
	setpwent();
	while(my (@uinfo) = getpwent()) {
		if (!$found{$uinfo[0]}++) {
			push(@rv, \@uinfo);
			}
		}
	endpwent();
	}
elsif ($config{'mail_system'} == 4) {
	# Qmail+LDAP uses an LDAP db
	local $ldap = &connect_qmail_ldap();
	local $rv = $ldap->search(base => $config{'ldap_base'},
			  filter => "(objectClass=qmailUser)");
	&error($rv->error) if ($rv->code);
	local $u;
	foreach $u ($rv->all_entries) {
		local @uinfo = &qmail_dn_to_user($u);
		next if (!$uinfo[10]);	# alias only
		push(@rv, \@uinfo);
		}
	$ldap->unbind();
	}
elsif ($config{'mail_system'} == 5) {
	# Get vpopmail user list for all domains
	opendir(DOMS, "$config{'vpopmail_dir'}/domains");
	foreach $d (readdir(DOMS)) {
		next if ($d =~ /^\./);
		push(@rv, &parse_vpopmail_users("-D $d"));
		}
	}
return @rv;
}

# parse_vpopmail_users(command)
sub parse_vpopmail_users
{
local %attr_map = ( "passwd" => 1,
		    "gecos" => 5,
		    "dir" => 7 );
local (@rv, $user);
open(UINFO, "$config{'vpopmail_dir'}/bin/vuserinfo $_[0] |");
while(<UINFO>) {
	s/\r|\n//g;
	if (/^([^:]+):\s+(.*)$/) {
		local ($attr, $value) = ($1, $2);
		if ($attr eq "name") {
			# Start of a new user
			$user = [ "$value\@$d" ];
			$user->[11] = $user->[0];
			push(@rv, $user);
			}
		local $amapped = $attr_map{$attr};
		$user->[$amapped] = $value if ($amapped);
		}
	}
close(UINFO);
return @rv;
}

# get_mail_user(name)
# Looks up a user by name
sub get_mail_user
{
if ($config{'mail_system'} < 3) {
	# Just find Unix user
	return getpwnam($_[0]);
	}
elsif ($config{'mail_system'} == 4) {
	# Lookup in LDAP DB
	local $ldap = &connect_qmail_ldap();
	local $rv = $ldap->search(base => $config{'ldap_base'},
			  filter => "(&(objectClass=qmailUser)(uid=$_[0]))");
	&error($rv->error) if ($rv->code);
	local ($u) = $rv->all_entries;
	local @uinfo = &qmail_dn_to_user($u);
	$ldap->unbind();
	return @uinfo;
	}
elsif ($config{'mail_system'} == 5) {
	# Find in vpopmail
	local @users = &parse_vpopmail_users($_[0]);
	return @{$users[0]};
	}
}

# get_mail_uid(name)
# Looks up a user by UID
sub get_mail_uid
{
if ($config{'mail_system'} < 3) {
	# Just find Unix user
	return getpwuid($_[0]);
	}
elsif ($config{'mail_system'} == 4) {
	# Lookup in LDAP DB
	local $ldap = &connect_qmail_ldap();
	local $rv = $ldap->search(base => $config{'ldap_base'},
		  filter => "(&(objectClass=qmailUser)(uidNumber=$_[0]))");
	&error($rv->error) if ($rv->code);
	local ($u) = $rv->all_entries;
	local @uinfo = &qmail_dn_to_user($u);
	$ldap->unbind();
	return @uinfo;
	}
elsif ($config{'mail_system'} == 5) {
	# Find in vpopmail
	return ( );	# not possible, since UIDs aren't used!
	}
}

# connect_qmail_ldap([return-error])
# Connect to the LDAP server used for Qmail. Returns an LDAP handle on success,
# or an error message on failure.
sub connect_qmail_ldap
{
eval "use Net::LDAP";
if ($@) {
	local $err = &text('ldap_emod', "<tt>Net::LDAP</tt>");
	if ($_[0]) { return $err; }
	else { &error($err); }
	}

# Connect to server
local $port = $config{'ldap_port'} || 389;
local $ldap = Net::LDAP->new($config{'ldap_host'}, port => $port);
if (!$ldap) {
	local $err = &text('ldap_econn',
			   "<tt>$config{'ldap_host'}</tt>","<tt>$port</tt>");
	if ($_[0]) { return $err; }
	else { &error($err); }
	}

# Start TLS if configured
if ($config{'ldap_tls'}) {
	$ldap->start_tls();
	}

# Login
local $mesg;
if ($config{'ldap_login'}) {
	$mesg = $ldap->bind(dn => $config{'ldap_login'},
			    password => $config{'ldap_pass'});
	}
else {
	$mesg = $ldap->bind(anonymous => 1);
	}
if (!$mesg || $mesg->code) {
	local $err = &text('ldap_elogin', "<tt>$config{'ldap_host'}</tt>",
		     $dn, $mesg ? $mesg->error : "Unknown error");
	if ($_[0]) { return $err; }
	else { &error($err); }
	}
return $ldap;
}

# qmail_dn_to_user(&dn)
sub qmail_dn_to_user
{
local $mms = &add_ldapmessagestore(
	scalar($_[0]->get_value("mailMessageStore")));
if (-d "$mms/Maildir") {
	$mms .= "/" if ($mms !~ /\/$/);
	$mms .= "Maildir";
	}
return ( scalar($_[0]->get_value("uid")),
	 scalar($_[0]->get_value("userPassword")),
	 scalar($_[0]->get_value("uidNumber")),
	 scalar($_[0]->get_value("gidNumber")),
	 scalar($_[0]->get_value("mailQuotaSize")),
	 scalar($_[0]->get_value("cn")),
	 scalar($_[0]->get_value("cn")),
	 scalar($_[0]->get_value("homeDirectory")),
	 scalar($_[0]->get_value("loginShell")),
	 undef,
	 $mms,
	 scalar($_[0]->get_value("mail")),
	 );
}

# add_ldapmessagestore(path)
sub add_ldapmessagestore
{
if (!$_[0]) {
	return $_[0];
	}
elsif ($_[0] =~ /^\//) {
	return $_[0];
	}
else {
	&foreign_require("qmailadmin", "qmail-lib.pl");
	local $pfx = &qmailadmin::get_control_file("ldapmessagestore");
	return $pfx."/".$_[0];
	}
}

# show_buttons(number, &folders, current-folder, &mail, user)
sub show_buttons
{
local ($num, $folders, $folder, $mail, $user) = @_;
local $spacer = "&nbsp;\n";
if (@$mail) {
	# Delete
	print "<input type=submit name=delete value=\"$text{'mail_delete'}\" ",
	      "onClick='return check_clicks(form)'>";
	if ($config{'show_delall'}) {
		print "<input type=submit name=deleteall value=\"$text{'mail_deleteall'}\">";
		}
	print $spacer;

	# Mark as
	print "<input type=submit name=mark$_[0] value=\"$text{'mail_mark'}\">";
	print "<select name=mode$_[0]>\n";
	print "<option value=1 checked>$text{'mail_mark1'}\n";
	print "<option value=0>$text{'mail_mark0'}\n";
	print "<option value=2>$text{'mail_mark2'}\n";
	print "</select>";
	print $spacer;

	if (&is_user($user)) {
		# Forward
		print "<input type=submit name=forward value=\"$text{'mail_forward'}\">";
		print $spacer;
		}

	# Move/copy
	print &movecopy_user_select($_[0], $folders, $folder, 1);
	print $spacer;

	# Show spam report buttons
	local @modules = &get_available_module_infos(1);
	local ($hasspam) = grep { $_->{'dir'} eq "spam" } @modules;
	if (&foreign_installed("spam") &&
	    $config{'spam_buttons'} =~ /list/ &&
	    &spam_report_cmd($user)) {
		if ($hasspam) {
			print "<input type=submit value=\"$text{'mail_black'}\" name=black>";
			}
		if ($config{'spam_del'}) {
			print "<input type=submit value=\"$text{'view_razordel'}\" name=razor>\n";
			}
		else {
			print "<input type=submit value=\"$text{'view_razor'}\" name=razor>";
			}
		print $spacer;
		}
	}

# Compose
if (&is_user($user)) {
	print "<input type=submit name=new value=\"$text{'mail_compose'}\">";
	}
print "<br>\n";
}

# get_signature(user)
# Returns the users signature, if any
sub get_signature
{
local $sf = &get_signature_file($_[0]);
$sf || return undef;
local $sig;
open(SIG, $sf) || return undef;
while(<SIG>) {
	$sig .= $_;
	}
close(SIG);
return $sig;
}

# get_signature_file(user)
# Returns the full path to the file that should contain the user's signature,
# or undef if none is defined
sub get_signature_file
{
return undef if ($config{'sig_file'} eq '*' || $config{'sig_file'} eq '');
local $sf = $config{'sig_file'};
if ($sf !~ /^\//) {
	local @uinfo = getpwnam($_[0]);
	$sf = "$uinfo[7]/$sf";
	}
return $sf;
}

1;

