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
use Benchmark qw(:all);
use Foo;

my $title_mapping = $Foo::TITLE_MAPPING;

my $rows = cmpthese(-1, {
    map {
        my $klass = $_;
        my $title = $title_mapping->{$klass};
        $title => sub {
            state $f = $klass->new(foo => 'foo!');
            $f->foo for 1..100;
        }
    } keys %$title_mapping,
}, 'none');

my $header = shift @$rows;

# find the index of the 'class feature' row
my ($x) = map { $header->[$_] =~ /^class feature/ ? ($_) : ()  } 0 .. $#$header;

say join "\t", qw(Rate Compare Title);
for my $row (@$rows) {
    say join "\t",
        $row->[1], # Rate
        $row->[$x], # compare 'class feature'
        $row->[0]; # Name
}

