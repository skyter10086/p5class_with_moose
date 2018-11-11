use lib './';
use Nation;
use Modern::Perl;

my $n_1 = Nation->new(key=>'02');
print $n_1->get_value;
print "\n";


