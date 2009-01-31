# -*- perl -*-

# t/001_load.t - check module loading and create testing directory

use Test::More tests => 2;

BEGIN { use_ok('String::Urandom') }

my $object = new String::Urandom;

isa_ok ( $object, 'String::Urandom' );


