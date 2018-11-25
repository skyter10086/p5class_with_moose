package DBish;

our $VERSION = '0.0.01';

use Moose::Role;
use DBI;
use Data::Printer;
use Template;

requires 'DSN','STRUCT_TEMPLATE','TABLE';



sub dbh {
    my ($class) = @_;
    my $dsn = $class->DSN;
    my $db = DBI->connect_cached($dsn) 
             or die $DBI::errstr;;
}

sub _init_tab {
    my ($class) = @_;
    my $meta = $class->meta;
    my $dbh = $class->dbh;
    my $temp = $class->STRUCT_TEMPLATE;
    my $pack = $class->TABLE;
    my $tt = Template->new;
    my $out = '';
    my $vars = { table => $pack};
    $tt->process(\$temp, $vars, \$out) || die $tt->error(), "\n";
    #p $out;
    #my $fields = $class->FIELDS;
    return $dbh->do($out) 
           or die $dbh->errstr;
}



sub connection {
    my ($class) = @_;
    my $pack_name = $class->TABLE;
    
    print $pack_name," connecting ...\t";
    if ($class->dbh) {
        print "The DataBase is ready.\n";
        my $sth = $class->dbh->table_info('','main',$pack_name,"TABLE");
        my @table_info = $sth->fetchall_arrayref;
        #p @table_info;
        if (  $table_info[0][0][2] eq $pack_name) {
            
            
        print " No Need for Create Table.\n";
        } else {
            $class->_init_tab;
        }
    } else {
        die "The DataBase went wrong, check your settings.";
    }
    
   
}

sub _insert {
    my $self = shift;
    my $kvs = shift;
    my $table = $self->TABLE;
    my @keys = keys %$kvs;
    my @vals = values %$kvs;
    
    my $sql = sprintf 'INSERT INTO %s(%s) VALUES(%s)', $table, join(",", @keys), join(",", "?" x @keys) ;
    
    my $dbh = $self->dbh;
    
    return dbh->query($sql, @vals) 
        or die $dbh->errstr;

}

sub _update {
    ...
}

sub _get {
    ...
}

no Moose::Role;
1;

__END__



