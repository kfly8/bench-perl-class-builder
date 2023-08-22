=head1 DESCRIPTION

Benchmark of object constructor.

=head1 SYNOPSIS

    % carmel install
    % carmel exec -- perl -Ilib bench-new.pl

=head1 RESULT

    Rate	Compare	Title
    86.1/s	-96%	Moose@2.2206
    763/s	-67%	Class::Tiny@1.008
    1309/s	-44%	Object::Pad@0.79
    1395/s	-40%	Moo@2.005004
    1896/s	-18%	Mouse@v2.5.10
    2262/s	-3%	bless arrayref
    2327/s	--	class feature (perl: 5.038000)
    2560/s	10%	Class::Accessor::Lite@0.08
    2595/s	12%	bless hashref
    2715/s	17%	Object::Tiny@1.09

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

