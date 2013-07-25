use Test::More qw(no_plan);

BEGIN { use_ok('Email::Filter'); }
BEGIN { use_ok('Email::Filter::Rules'); }

my $efr = Email::Filter::Rules->new( rules => "" );
ok( !$efr );

$efr = Email::Filter::Rules->new( rules => $0 );
isa_ok( $efr, 'Email::Filter::Rules' );

$efr = Email::Filter::Rules->new(
    rules => ["inbox to jbisbee","/dev/null body Last Line"] );
isa_ok( $efr, 'Email::Filter::Rules' );

$efr = Email::Filter::Rules->new(
    rules => ["inbox to"] );
isa_ok( $efr, 'Email::Filter::Rules' );

$efr = Email::Filter::Rules->new(
    rules => [] );
ok( !$efr, 'Fail if no rules' );

$efr = Email::Filter::Rules->new(
    rules => [ '#', "inbox too jbisbee", "/dev/null subject Last Line" ],
    debug => 1,
);
isa_ok( $efr, 'Email::Filter::Rules' );

my $email_text = "From: jbisbee\@cpan.org\nTo: jbisbee\@cpan.org\n\nHi";
my $email = Email::Filter->new( data => $email_text );
isa_ok( $email, "Email::Filter" );
ok( !$efr->apply_rules($email), "Did not return folder name" );

$email_text = "From: jbisbee\@cpan.org\nTo: jbisbee\@cpan.org\nSubject: "
    . "Last Line\n\nHi";
$email = Email::Filter->new( data => $email_text );
isa_ok( $email, "Email::Filter" );
ok( $efr->apply_rules($email), "Return folder name" );
