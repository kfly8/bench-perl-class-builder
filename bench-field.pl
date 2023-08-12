use v5.38;
use Benchmark qw(:all);

use FooFeatureClass;
use FooObjectPad;
use FooClassAccessorLite;
use FooMouse;
use FooMoose;
use FooMoo;
use FooClassTiny;
use FooObjectTiny;
use FooBless;
use FooBlessArray;

say 'versions:';
say "Perl: $]";

for my $module (qw(
        Object::Pad
        Class::Accessor::Lite
        Mouse
        Moo
        Moose
        Class::Tiny
        Object::Tiny
    )) {
    say "$module: ", $module->VERSION;
}

say '----------';
say 'benchmarks:';

my $description_mapping   = {
    FooFeatureClass      => 'class feature',
    FooObjectPad         => 'Object::Pad',
    FooClassAccessorLite => 'Class::Accessor::Lite',
    FooMouse             => 'Mouse',
    FooMoo               => 'Moo',
    FooMoose             => 'Moose',
    FooClassTiny         => 'Class::Tiny',
    FooObjectTiny        => 'Object::Tiny',
    FooBless             => 'bless hashref',
    FooBlessArray        => 'bless arrayref',
};

my $rows = cmpthese(-1, {
    map {
        my $klass = $_;
        my $description = $description_mapping->{$klass};
        $description => sub {
            state $f = $klass->new(foo => 'foo!');
            $f->foo for 1..100;
        }
    } keys %$description_mapping,
}, 'none');

my $header = $rows->[0];

# find the index of the 'class feature' row
my ($x) = map { $header->[$_] eq 'class feature' ? ($_) : ()  } 0 .. $#$header;

for my $row (@$rows) {
    say join "\t",
        $row->[1], # Rate
        $row->[$x], # compare 'class feature'
        $row->[0]; # Name
}

# ❯ perl -Ilib bench-field.pl
# versions:
# Perl: 5.038000
# Object::Pad: 0.79
# Class::Accessor::Lite: 0.08
# Mouse: v2.5.10
# Moo: 2.005004
# Moose: 2.2206
# Class::Tiny: 1.008
# Object::Tiny: 1.09
# ----------
# benchmarks:
# Rate	class feature
# 79644/s	-35%	Object::Pad
# 91995/s	-25%	Class::Accessor::Lite
# 111708/s	-9%	Moo
# 113777/s	-7%	Moose
# 116081/s	-5%	bless hashref
# 117029/s	-4%	Class::Tiny
# 120302/s	-2%	bless arrayref
# 122530/s	--	class feature
# 143479/s	17%	Object::Tiny
# 206645/s	69%	Mouse
