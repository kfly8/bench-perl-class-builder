=head1 DESCRIPTION

Compare size of objects.

=head1 SYNOPSIS

    % carmel install
    % carmel exec -- perl -Ilib bench-size.pl

=head1 RESULT

    Size	Compare	Title
    135.8 KB	--	`class feature (perl: 5.038000)`
    257.9 KB	89.9%	`bless arrayref`
    265.7 KB	95.6%	`Object::Pad@0.79`
    359.5 KB	164.8%	`bless hashref`
    359.5 KB	164.8%	`Moo@2.005004`
    359.5 KB	164.8%	`Class::Accessor::Lite@0.08`
    359.5 KB	164.8%	`Moose@2.2206`
    359.5 KB	164.8%	`Moo@2.005004 (XSConstructor + XSAccessor)`
    359.5 KB	164.8%	`Object::Tiny@1.09`
    359.5 KB	164.8%	`Mouse@v2.5.10`
    359.5 KB	164.8%	`Moose@2.2206 (XSAccessor)`
    359.5 KB	164.8%	`Class::Tiny@1.008`

=cut

use v5.38;
use Foo;

# This logic is creaing a list consists of many objects.
sub create_main_logic_coderef($benchmark_class) {
    return sub {
        my @list = map {
            $benchmark_class->new(
                foo => 'foo' . $_,
                bar => 'bar' . $_,
                baz => 'baz' . $_,
            )
        } 1 .. 1000;
        return \@list;
    }
}

Foo::run_memory_consumption_benchmark(\&create_main_logic_coderef);

