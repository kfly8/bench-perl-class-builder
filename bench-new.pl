=head1 DESCRIPTION

Benchmark of object constructor.

=head1 SYNOPSIS

    % carmel install
    % carmel exec -- perl -Ilib bench-new.pl

=head1 RESULT

    ❯ perl -Ilib bench-new.pl
    Rate	Compare	Title
    545/s	-57%	`Class::Tiny@1.008`
    739/s	-42%	`Moose@2.2206`
    777/s	-39%	`Moo@2.005004`
    807/s	-37%	`Object::Pad@0.79`
    977/s	-24%	`Mouse@v2.5.10`
    1280/s	--	`class feature (perl: 5.038000)`
    1321/s	3%	`bless arrayref`
    1410/s	10%	`Class::Accessor::Lite@0.08`
    1493/s	17%	`Object::Tiny@1.09`
    1534/s	20%	`bless hashref`

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

