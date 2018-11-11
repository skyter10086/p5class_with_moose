use lib './';
use Employee;

my $emp = Employee->new(
    name => '曾理',
    sex => 'Male',
    id => '411302198310203835',
    nation => '01',
    
);
print "民族: ",$emp->nation_value,"\n";
print "姓名: ",$emp->name,"\n";
=pod

if ('411302198310203835' =~ /^[1-9]\d{5}(18|19|20)\d{2}((0[1-9])|(1[0-2]))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$/) {
    print "Done!\n";
} else {
    print "None!\n";
}
=cut