=head1 DESCRIPTION

Benchmark of object constructor.

=head1 SYNOPSIS

    % carmel install
    % carmel exec -- perl -Ilib bench-new.pl

=head1 RESULT

    Rate	Compare	Title
    473/s	-61%	`Class::Tiny@1.008`
    636/s	-47%	`Moose@2.2206`
    675/s	-44%	`Moose@2.2206 (XSAccessor)`
    720/s	-40%	`Object::Pad@0.79`
    777/s	-35%	`Moo@2.005004`
    1053/s	-12%	`Moo@2.005004 (XSConstructor + XSAccessor)`
    1141/s	-5%	`Mouse@v2.5.10`
    1189/s	-1%	`bless arrayref`
    1199/s	--	`class feature (perl: 5.038000)`
    1658/s	38%	`bless hashref`
    1662/s	39%	`Class::Accessor::Lite@0.08`
    1690/s	41%	`Object::Tiny@1.09`

=cut

use v5.38;
use Foo;

# This logic is creaing many objects.
sub create_main_logic_coderef($benchmark_class) {
    return sub {
        for (1..1000) {
            my $f = $benchmark_class->new(
                foo => 'foo' . $_,
                bar => 'bar' . $_,
                baz => 'baz' . $_,
            );
        }
    }
}

Foo::run_benchmark(\&create_main_logic_coderef);

