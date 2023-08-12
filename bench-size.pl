=head1 DESCRIPTION

Compare size of objects.

=head1 SYNOPSIS

    % carmel install
    % carmel exec -- perl -Ilib bench-size.pl

=head1 RESULT

    Size	Compare	Title
    135.8 KB	--	class feature (perl: 5.038000)
    148.5 KB	9.3%	bless arrayref
    171.9 KB	26.6%	Object::Pad@0.79
    218.8 KB	61.1%	Object::Tiny@1.09
    218.8 KB	61.1%	Mouse@v2.5.10
    218.8 KB	61.1%	Class::Accessor::Lite@0.08
    218.8 KB	61.1%	Class::Tiny@1.008
    218.8 KB	61.1%	bless hashref
    218.8 KB	61.1%	Moo@2.005004
    257.9 KB	89.9%	Moose@2.2206

=cut

use v5.38;
use Foo;

# This logic is creaing a list consists of many objects.
sub create_main_logic_coderef($benchmark_class) {
    return sub {
        my @list = map { $benchmark_class->new(foo => 'foo' . $_) } 1 .. 1000;
        return \@list;
    }
}

Foo::run_memory_consumption_benchmark(\&create_main_logic_coderef);
