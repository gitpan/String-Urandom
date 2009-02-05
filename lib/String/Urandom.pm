#----------------------------------------------------------------------------+
#
#  String::Urandom - An alternative to /dev/random
#
#  DESCRIPTION
#  Using output of /dev/urandom.  Simply convert bytes into 8-bit characters.
#
#  AUTHOR
#  Marc S. Brooks <mbrooks@cpan.org>
#
#  This module is free software; you can redistribute it and/or
#  modify it under the same terms as Perl itself.
#
#----------------------------------------------------------------------------+

package String::Urandom;

use strict;
use warnings;

our $VERSION = '0.08';

#----------------------------------------------------------------------------+
# General object constructor

sub new {
    my $proto = shift;
    my $class = ref($proto) || $proto;

    return bless( {
        LENGTH => 32,
        CHARS  => [ qw/ a b c d e f g h i j k l m n o p q r s t u v w x y z
                        A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
                        1 2 3 4 5 6 7 8 9                                 / ]
    }, $class );
}

#----------------------------------------------------------------------------+
# Set/Get the string length 

sub str_length {
    my ( $self, $value ) = @_;
    return $self->{LENGTH} unless ($value);
    return $self->{LENGTH} unless ($value =~ /^[\d]*$/);
    $self->{LENGTH} = $value;
    return $self->{LENGTH};
}

#----------------------------------------------------------------------------+
# Set/Get the string characters

sub str_chars {
    my ( $self, $value ) = @_;
    return $self->{CHARS} unless ($value);
    return $self->{CHARS} unless ($value =~ /^[\w\s]*$/);
    my @chars = split(/\s+/, $value);
    $self->{CHARS} = \@chars;
    return $self->{CHARS};
}

#----------------------------------------------------------------------------+
# Generate a random string

sub rand_string {
    my $self = shift;

    open (DEV, "/dev/urandom") or die "Cannot open file: $!";
    read (DEV, my $bytes, $self->{LENGTH});

    my $string;
    my @randoms = split(//, $bytes);
    foreach (@randoms) {
        $string .= @{ $self->{CHARS} }[ ord($_) % @{ $self->{CHARS} } ];
    }
    return $string;
}

1;

__END__

=head1 NAME

String::Urandom - An alternative to using /dev/random

=head1 SYNOPSIS 

  use String::Urandom;

  my $obj = new String::Urandom;

  # set the string length 
  $obj->str_length(255);

  # set the characters
  $obj->str_chars('a b c 1 2 3');

  # print the result
  print $obj->rand_string, "\n";

=head1 DESCRIPTION

Using output from /dev/urandom.  Simply convert bytes into 8-bit characters.

=head1 METHODS

=head2 str_length

This method will set/get the string character length.

The default value is: 32

  $obj->str_length(255);

=head2 str_chars

This method will set/get characters used when generating a string.

The default value is: a-z A-Z 0-9

  $obj->str_chars('a e i o u 1 2 3');

=head2 rand_string

This method generates a new random string.

  $obj->rand_string;

=head1 REQUIREMENTS

Any flavour of UNIX that supports /dev/urandom

=head1 NOTES

The /dev/urandom is an ("unlocked" random source) which reuses the internal pool to produce more pseudo-random bits.  Since this is the case, the read may contain less entropy than its counterpart /dev/random.  Knowing this, this module was intended to be used a pseudorandom string generator for less secure applications where response timing be of an issue.

=head1 SEE ALSO

urandom(4)

=head1 AUTHOR

Marc S. Brooks E<lt>mbrooks@cpan.orgE<gt> L<http://mbrooks.info>

=head1 LICENSE

This program is free software; you can redistribute it and/or modify it under the same terms as Perl itself.
