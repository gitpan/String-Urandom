#!/usr/bin/perl

use String::Urandom;

my $su = new String::Urandom;

$su->str_length('255');
$su->str_chars('a b c 1 2 3');

my $length = $su->str_length;
my $chars  = $su->str_chars;
my $string = $su->rand_string;

print <<RESULTS;
   Length: $length
   Chars:  @$chars
   Result: $string
RESULTS


