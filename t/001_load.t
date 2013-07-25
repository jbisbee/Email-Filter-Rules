#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 9;

BEGIN { use_ok( 'Email::Filter' ); }
BEGIN { use_ok( 'Email::Filter::Rules' ); }

my $rules = Email::Filter::Rules->new(rules => "inbox to jbisbee\n/dev/null body Last Line");
isa_ok($rules, 'Email::Filter::Rules');

my $mail_text = "From: jbisbee\@cpan.org\nTo: jbisbee\@cpan.org\n\nHi";
my $mail = Email::Filter->new(data => $mail_text);
isa_ok($mail, "Email::Filter");

is($rules->apply_rules($mail),"inbox","Testing basic rule");

my $mail_text2 = "From: biz\@cpan.org\nTo: biz\@cpan.org\n\nHi";
my $mail2 = Email::Filter->new(data => $mail_text2);
isa_ok($mail2, "Email::Filter");
isnt($rules->apply_rules($mail2),"inbox","Testing basic rule failure");

my $mail_text3 = "From: biz\@cpan.org\nTo: biz\@cpan.org\n\nHi\nBye\nLast Line";
my $mail3 = Email::Filter->new(data => $mail_text3);
isa_ok($mail3, "Email::Filter");
is($rules->apply_rules($mail3),"/dev/null","Testing /s for body");
