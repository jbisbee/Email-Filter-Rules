# -*- perl -*-

# t/001_load.t - check module loading and create testing directory

use Test::More tests => 2;

BEGIN { use_ok( 'Email::Filter::Rules' ); }

my $object = Email::Filter::Rules->new(rules => "mbox to:cc testing");
isa_ok ($object, 'Email::Filter::Rules');


