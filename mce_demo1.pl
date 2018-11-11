# Construction using the Core API
 
use MCE;
 
my $mce = MCE->new(
   max_workers => 5,
   user_func => sub {
      my ($mce) = @_;
      $mce->say("Hello from " . $mce->wid);
   }
);
 
$mce->run;
 
# Construction using a MCE model
 
use MCE::Flow max_workers => 5;
 
mce_flow sub {
   my ($mce) = @_;
   MCE->say("Hello from " . MCE->wid);
};