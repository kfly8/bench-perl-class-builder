=head1 DESCRIPTION

Benchmark of object field access.

=head1 SYNOPSIS

    % carmel install
    % carmel exec -- perl -Ilib bench-field.pl

=head1 RESULT

    Rate	Compare	Title
    85163/s	-40%	`Object::Pad@0.79`
    103322/s	-27%	`Class::Accessor::Lite@0.08`
    117507/s	-17%	`Class::Tiny@1.008`
    118154/s	-17%	`bless hashref`
    120250/s	-15%	`Moose@2.2206`
    130326/s	-8%	`Moo@2.005004`
    132332/s	-7%	`bless arrayref`
    141835/s	--	`class feature (perl: 5.038000)`
    159288/s	12%	`Object::Tiny@1.09`
    229681/s	62%	`Mouse@v2.5.10`

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

