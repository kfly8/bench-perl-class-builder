use v5.38;
use Benchmark qw(:all);

use FooObjectPad;
use FooFeatureClass;
use FooClassAccessorLite;
use FooMouse;
use FooMoose;
use FooMoo;
use FooClassTiny;
use FooObjectTiny;
use FooBless;
use FooBlessNoSig;
use FooBlessArray;
use FooBlessArrayNoSig;
use FooFunctionHash;
use FooFunctionHashNoSig;
use FooFunctionArray;
use FooFunctionArrayNoSig;

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

say 'benchmarks:';

my $rows = cmpthese(-1, {
    'class feature' => sub {
        state $f = FooFeatureClass->new(a => 'a', b => 'b', c => 'c', d => 'd');
        $f->foo;
    },

    'Object::Pad' => sub {
        state $f = FooObjectPad->new(a => 'a', b => 'b', c => 'c', d => 'd');
        $f->foo;
    },

    'Class::Accessor::Lite' => sub {
        state $f = FooClassAccessorLite->new(a => 'a', b => 'b', c => 'c', d => 'd');
        $f->foo;
    },

    'Mouse' => sub {
        state $f = FooMouse->new(a => 'a', b => 'b', c => 'c', d => 'd');
        $f->foo;
    },

    'Moo' => sub {
        state $f = FooMoo->new(a => 'a', b => 'b', c => 'c', d => 'd');
        $f->foo;
    },

    'Moose' => sub {
        state $f = FooMoose->new(a => 'a', b => 'b', c => 'c', d => 'd');
        $f->foo;
    },

    'Class::Tiny' => sub {
        state $f = FooClassTiny->new(a => 'a', b => 'b', c => 'c', d => 'd');
        $f->foo;
    },

    'Object::Tiny' => sub {
        state $f = FooObjectTiny->new(a => 'a', b => 'b', c => 'c', d => 'd');
        $f->foo;
    },

    'bless hashref and use subroutine signatures' => sub {
        state $f = FooBless->new(a => 'a', b => 'b', c => 'c', d => 'd');
        $f->foo;
    },

    'bless hashref and NOT use subroutine signatures' => sub {
        state $f = FooBlessNoSig->new(a => 'a', b => 'b', c => 'c', d => 'd');
        $f->foo;
    },

    'bless arrayref and use subroutine signatures' => sub {
        state $f = FooBlessArray->new(a => 'a', b => 'b', c => 'c', d => 'd');
        $f->foo;
    },

    'bless arrayref and NOT use subroutine signatures' => sub {
        state $f = FooBlessArrayNoSig->new(a => 'a', b => 'b', c => 'c', d => 'd');
        $f->foo;
    },

    'function and hash arguments and use subroutine signatures' => sub {
        FooFunctionHash::foo(a => 'a', b => 'b', c => 'c', d => 'd');
    },

    'function and hash arguments and NOT use subroutine signatures' => sub {
        FooFunctionHashNoSig::foo(a => 'a', b => 'b', c => 'c', d => 'd');
    },

    'function and array arguments and use subroutine signatures' => sub {
        FooFunctionArray::foo('a', 'b', 'c', 'd');
    },

    'function and array arguments and NOT use subroutine signatures' => sub {
        FooFunctionArrayNoSig::foo('a', 'b', 'c', 'd');
    },
}, 'none');


for my $row (@$rows) {
    say join "\t", $row->[1], $row->[2], $row->[0];
}

# ❯ perl -Ilib bench.pl
# versions:
# Perl: 5.038000
# Object::Pad: 0.79
# Class::Accessor::Lite: 0.08
# Mouse: v2.5.10
# Moo: 2.005004
# Moose: 2.2206
# Class::Tiny: 1.008
# Object::Tiny: 1.09
# benchmarks:
# Rate	Class::Accessor::Lite
# 1542023/s	--	Class::Accessor::Lite
# 1787345/s	16%	Moo
# 1787345/s	16%	Moose
# 1803742/s	17%	Class::Tiny
# 2143701/s	39%	Object::Tiny
# 2548621/s	65%	function and hash arguments and NOT use subroutine signatures
# 2707833/s	76%	function and hash arguments and use subroutine signatures
# 3744913/s	143%	Mouse
# 4721290/s	206%	function and array arguments and use subroutine signatures
# 4766254/s	209%	Object::Pad
# 5698783/s	270%	function and array arguments and NOT use subroutine signatures
# 6612641/s	329%	class feature
# 6616615/s	329%	bless hashref and use subroutine signatures
# 6672756/s	333%	bless hashref and NOT use subroutine signatures
# 7561845/s	390%	bless arrayref and NOT use subroutine signatures
# 7561845/s	390%	bless arrayref and use subroutine signatures

