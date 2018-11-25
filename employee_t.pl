use lib './';
use Employee;
use Person;


my $emp = Employee->new(
    name => '曾理',
    sex => 'Male',
    id => '411302198310203835',
    nation => '01',
    
);
print "民族: ",$emp->nation_value,"\n";
print "姓名: ",$emp->name,"\n";


if ('411302198310203835' =~ /^[1-9]\d{5}(18|19|20)\d{2}((0[1-9])|(1[0-2]))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$/) {
    print "Done!\n";
} else {
    print "None!\n";
}

my $json_text = $emp->get_json;
print $json_text,"\n";


my $jhon = Person->new(
    id => '412924197402283235',
    name => 'JhonLee',
    sex => '01',
    nation => '01',
    birth => '1974-02-28',
    zipcode => '473132',
);
print "\njhon's age is ", $jhon->age, ".\n";
print "jhon's detail is ", $jhon->get_json, "\n";
print "jhon is a " ,$jhon->get_nation,"\n";
my $jj = Person->set_json('{"nation":"02","id":"412924197502163222","name":"jjj","birth":"1975-02-16","sex":"01","zipcode":"473100"}');
print "jj is in ",$jj->get_zip,".\n";
print "jj's detail now is ", $jj->get_json, "\n";

$jj->connection;
__END__
