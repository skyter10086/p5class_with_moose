package Person;


use lib './';

use utf8::all;
use DateTime;
use Moose;
use Moose::Util::TypeConstraints;

use Nation;

with 'JSONable';
with  'DBish';

my $SEX = {'01'=>'男', '02'=>'女'};
my $ZIP = {
    '473132' =>'河南南阳官庄镇油田',
    '473100' => '河南南阳卧龙区',
    '474780' => '河南南阳桐柏县',
};

subtype 'ZipCode' ,
    as 'Str',
    where { $ZIP->{$_} };

subtype 'DateText' ,
    as 'Str',
    where {$_ =~ /^((((19|20)\d{2})-(0?[13-9]|1[012])-(0?[1-9]|[12]\d|30))|(((19|20)\d{2})-(0?[13578]|1[02])-31)|(((19|20)\d{2})-0?2-(0?[1-9]|1\d|2[0-8]))|((((19|20)([13579][26]|[2468][048]|0[48]))|(2000))-0?2-29))$/};

subtype 'IDNum' ,
    as 'Str',
    where { $_ =~ /^[1-9]\d{5}(18|19|20)\d{2}((0[1-9])|(1[0-2]))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$/},
    message {"That is not an ID-Number!"};

subtype 'SexCode' => 
    as enum([qw/01 02/]);
    

has 'id' => (
    is => 'rw',
    isa => 'IDNum',
    required => 1,
);

has 'name' => (
    isa => 'Str',
    is  => 'rw',
    required => 1,
);

has 'sex' => (
    isa => 'SexCode',
    is => 'rw', 
    required =>1  , 
);

has 'nation' => (
    isa => 'NationCode',
    is => 'rw',
    required => 1,

);

has 'birth' => (
    isa => 'DateText',
    is => 'rw',
    required =>1,
);

has 'address' => (
    isa => 'Str',
    is => 'rw',
    );

has 'zipcode' => (
    isa => 'ZipCode',
    is => 'rw',
    
    );

has 'phone' => (
    isa => 'Str',
    is => 'rw',
);

sub TABLE {
    'Person';
}

sub DSN {
    return 'dbi:SQLite:dbname=file.dat';
}

sub STRUCT_TEMPLATE {
    return 'CREATE TABLE [% table %] (
        id CHAR(18) PRIMARY KEY,
        name VARCHAR(20) NOT NULL,
        sex VARCHAR(2) NOT NULL,
        nation VARCHAR(2) NOT NULL,
        birth DATE NOT NULL,
        address VARCHAR(60),
        zipcode CHAR(6),
        phone VARCHAR(25)
    );';
}

sub age {
    my $self = shift;
    my $dur = DateTime->today() - str_to_date($self->birth);
    return $dur->in_units('years');
}

sub get_sex {
    my $self = shift;
    return $SEX->{$self->sex};
}

sub get_nation {
    my $self = shift;
    return Nation->new(key=>$self->nation)->get_value;
}

sub get_zip {
    my $self = shift;
    return $ZIP->{$self->zipcode};
}

sub str_to_date {
	
	my $date_str =shift;
    #my $seprater = sub {return '-' if $date_str =~ /^\d+\-\d+\-\d+$/ ; return '.' if $date_str =~ /^\d+\.\d+\.\d+$/ ; return '/' if $date_str =~ /^\d+\/\d+\/\d+$/ ; }
	my @array = split(/-/,$date_str);
	my @a = map {$_+0} @array;
	#print @a;

	my $hr = {
		year => $a[0],
		month => $a[1],
		day => $a[2],
	};
	#print ref $a[1],"\n";
	return DateTime->new($hr);

}

no Moose::Util::TypeConstraints;
no Moose;

1;
