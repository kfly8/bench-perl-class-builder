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
#
# versions:
# Perl: 5.038000
# Object::Pad: 0.79
# Class::Accessor::Lite: 0.08
# Mouse: v2.5.10
# Moo: 2.005004
# Moose: 2.2206
# Class::Tiny: 1.008
# Object::Tiny: 1.09
#
# benchmarks:
# Rate	Class::Accessor::Lite
# 1542023/s	--	Class::Accessor::Lite
# 1755429/s	14%	Moo
# 1764431/s	14%	bless hashref and use subroutine signatures
# 1799026/s	17%	Moose
# 1854792/s	20%	Class::Tiny
# 1890462/s	23%	bless arrayref and use subroutine signatures
# 2143700/s	39%	bless hashref and NOT use subroutine signatures
# 2143701/s	39%	Object::Tiny
# 2254309/s	46%	bless arrayref and NOT use subroutine signatures
# 2595484/s	68%	function and hash arguments and NOT use subroutine signatures
# 2672341/s	73%	function and hash arguments and use subroutine signatures
# 3709584/s	141%	Mouse
# 4766254/s	209%	Object::Pad
# 4812084/s	212%	function and array arguments and use subroutine signatures
# 5625983/s	265%	function and array arguments and NOT use subroutine signatures
# 6616614/s	329%	class feature
