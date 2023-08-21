=head1 DESCRIPTION

Benchmark of object field access.

=head1 SYNOPSIS

    % carmel install
    % carmel exec -- perl -Ilib bench-field.pl

=head1 RESULT

    Rate	Compare	Title
    79644/s	-35%	Object::Pad@0.79
    92839/s	-24%	Class::Accessor::Lite@0.08
    113778/s	-7%	Moo@2.005004
    114688/s	-6%	Moose@2.2206
    115924/s	-5%	bless hashref
    118154/s	-4%	Class::Tiny@1.008
    120302/s	-2%	bless arrayref
    122530/s	--	class feature (perl: 5.038000)
    142175/s	16%	Object::Tiny@1.09
    208523/s	70%	Mouse@v2.5.10

=cut

use v5.38;
use Foo;

# This logic is accessing to object field many times.
sub create_main_logic_coderef($benchmark_class) {
    return sub {
        state $object = $benchmark_class->new(
            foo => 'foo!',
            bar => 'bar?',
            baz => 'baz.',
        );
        $object->foo for 1..50;
        $object->baz for 1..50;
    }
}

Foo::run_benchmark(\&create_main_logic_coderef);

