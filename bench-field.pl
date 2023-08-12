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

my $rows = cmpthese(-1, {
    'class feature' => sub {
        state $f = FooFeatureClass->new(foo => 'foo!');
        $f->foo for 1..100;
    },

    'Object::Pad' => sub {
        state $f = FooObjectPad->new(foo => 'foo!');
        $f->foo for 1..100;
    },

    'Class::Accessor::Lite' => sub {
        state $f = FooClassAccessorLite->new(foo => 'foo!');
        $f->foo for 1..100;
    },

    'Mouse' => sub {
        state $f = FooMouse->new(foo => 'foo!');
        $f->foo for 1..100;
    },

    'Moo' => sub {
        state $f = FooMoo->new(foo => 'foo!');
        $f->foo for 1..100;
    },

    'Moose' => sub {
        state $f = FooMoose->new(foo => 'foo!');
        $f->foo for 1..100;
    },

    'Class::Tiny' => sub {
        state $f = FooClassTiny->new(foo => 'foo!');
        $f->foo for 1..100;
    },

    'Object::Tiny' => sub {
        state $f = FooObjectTiny->new(foo => 'foo!');
        $f->foo for 1..100;
    },

    'bless hashref and use subroutine signatures' => sub {
        state $f = FooBless->new(foo => 'foo!');
        $f->foo for 1..100;
    },

    'bless arrayref and use subroutine signatures' => sub {
        state $f = FooBlessArray->new(foo => 'foo!');
        $f->foo for 1..100;
    },

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

#❯ perl -Ilib bench-field.pl
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
# 80388/s	-36%	Object::Pad
# 91167/s	-27%	Class::Accessor::Lite
# 112733/s	-10%	Moo
# 112734/s	-10%	Moose
# 115924/s	-7%	bless hashref and use subroutine signatures
# 117108/s	-6%	Class::Tiny
# 122530/s	-2%	bless arrayref and use subroutine signatures
# 124842/s	--	class feature
# 143479/s	15%	Object::Tiny
# 197283/s	58%	Mouse
