package databaseconnect;
use DBI;
sub new 
{
my ($class)=@_;

my $self={

 _Hostname=>undef,
 _Database=>undef,
 _DatabaseType=>undef,
 _Username=>undef,
 _Password=>undef,
 _Link=>undef,
 _Sth=>undef




};
bless $self,$class;

return $self;

}



sub myquery
{
my ($self,$dbres,$getquery)=@_;
if(defined $dbres and defined $getquery)
{
$self->{_Sth}=$dbres->prepare($getquery) or die("cannot prepare query");

$self->{_Sth}->execute() or die("cannot execute query");
return $self->{_Sth};

}




}


sub connectit
{
my ($self,$hostname,$databasetype,$databasename,$username,$password)=@_;

$self->{_Hostname}=$hostname;
$self->{_Database}=$databasename;
$self->{_Username}=$username;
$self->{_Password}=$password;
$self->{_DatabaseType}=$databasetype;
$self->{_Link}=DBI->connect("dbi:$self->{_DatabaseType}:$self->{_Database}:$self->{_Hostname}",$self->{_Username},$self->{_Password}) or die("cannot connect to database");


return $self->{_Link};

}
1;
