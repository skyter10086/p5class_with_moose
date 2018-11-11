package Employee;
use lib './';
use Moose;
use Moose::Util::TypeConstraints;
use Nation;

subtype 'IDNumber' ,
 as 'Str',
 where { $_ =~ /^[1-9]\d{5}(18|19|20)\d{2}((0[1-9])|(1[0-2]))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$/},
 message {"That is not an ID-Number!"};
=pod
subtype 'NationClass',
as 'Nation';


coerce 'NationClass' ,
    from 'Str' , via { Nation->new(key => $_ ) };
=cut    
subtype 'NationType' => as class_type('Nation');
coerce 'NationType'
    => from 'Str'
        => via { Nation->new(key=>$_) };




has 'name' => (
    is => 'rw',
    isa => 'Str',
    ); 

has 'sex' => (
    is => 'rw',
    isa => enum([qw/Male Female/]),
    );

has 'id' => (
    is => 'rw',
    isa => 'IDNumber',
);


has 'nation' => (
    is => 'rw',
    #isa => 'NationKey',
    coerce => 1,
    isa => 'NationType',
    handles => {
        nation_value => 'get_value',
    },
    required => 1,
);
=pod
around 'nation' => sub {
    my $orig = shift;
    my $self = shift;
 
    return $self->$orig()
        unless @_;
    
    my $nation_code = shift;
    Carp::cluck("you put the code $nation_code!");
    return $self->$orig(Nation->new(key=>$nation_code));
    
};

sub nation_value {
    my $self =shift;
    return Nation->new(key=>$self->nation)->get_value;
}
=cut
no Moose::Util::TypeConstraints;
no Moose;
1;

