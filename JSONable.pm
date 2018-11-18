package JSONable;

#use strict;
use utf8::all;
use JSON;
use Moose::Role;
use Data::Printer;



# 对象转换为hashref
sub _to_hash {
    my $self  = shift;
    my $meta = $self->meta;
    my %obj_hash;
    for my $attr ($meta->get_all_attributes) {
        my $reader = $attr->get_read_method;
        my $attr_val = $self->$reader;
        if (ref $attr_val && $attr_val->does('JSONable')) {
		    $obj_hash{$attr->name}= $attr_val->_to_hash;
		} else {
        $obj_hash{$attr->name} = $attr_val;
	    }
	    #p %obj_hash;

    }
   # p %obj_hash;
       #my $json_obj = JSON::MaybeXS->new(utf8=>1, pretty=>1);
        return \%obj_hash ;
       #return


}
sub _from_hash {
	my $class = shift;
	
	my $hr = shift;
	return $class->new($hr);
}

	

# 对象转换为JSON
sub get_json {
    my $self  = shift;
    #my $json = JSON::MaybeXS->new(utf8 => 1, pretty => 1);
    return encode_json($self->_to_hash);
}

sub set_json {
    my $self = shift;
    my $json = 	shift;
    my $hr = decode_json($json);
    return $self->_from_hash($hr);
    

}

no Moose::Role;
1;
