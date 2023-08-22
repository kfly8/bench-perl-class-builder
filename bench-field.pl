=head1 DESCRIPTION

Benchmark of object field access.

=head1 SYNOPSIS

    % carmel install
    % carmel exec -- perl -Ilib bench-field.pl

=head1 RESULT

    Rate	Compare	Title
    81146/s	-41%	`Object::Pad@0.79`
    97206/s	-29%	`Class::Accessor::Lite@0.08`
    111203/s	-19%	`Moose@2.2206`
    117507/s	-14%	`Moo@2.005004`
    119218/s	-13%	`bless hashref`
    121662/s	-11%	`bless arrayref`
    130453/s	-4%	`Class::Tiny@1.008`
    136532/s	--	`class feature (perl: 5.038000)`
    165414/s	21%	`Object::Tiny@1.09`
    214369/s	57%	`Moose@2.2206 (XSAccessor)`
    229681/s	68%	`Mouse@v2.5.10`
    273066/s	100%	`Moo@2.005004 (XSConstructor + XSAccessor)`

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

