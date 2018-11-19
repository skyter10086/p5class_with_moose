package Nation;
use lib './';
use utf8::all;
use Moose;
use Moose::Util::TypeConstraints;

with 'JSONable';
my $nation_pairs = {
    '01' => '汉族',
    '02' => '蒙古族',
    '03' => '回族',
    '04' => '藏族',
    '05' => '维吾尔族',

};

subtype 'NationCode' ,
    as 'Str',
    where {$nation_pairs->{$_}},
    message {"You give a wrong key of Nations!"};

has 'key' => (
    is => 'rw',
    isa => 'NationCode',
    clearer => 'clear_key',
    predicate => 'has_key',    
);



sub get_value {
    my $self = shift;

    return $nation_pairs->{$self->key};

}
no Moose::Util::TypeConstraints;
no Moose;
1;
