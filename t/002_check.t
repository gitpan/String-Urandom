# -*- perl -*-

# t/002_check.t - check for the device /dev/urandom

use Test::More tests => 1;

ok( -c '/dev/urandom', 'The device /dev/urandom does not exist' );


