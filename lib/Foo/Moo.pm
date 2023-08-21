use v5.38;

$ENV{MOO_XS_DISABLE} = 1;

package Foo::Moo {
    use Moo;

    has foo => (is => 'ro');
    has bar => (is => 'ro');
    has baz => (is => 'ro');
}

undef $ENV{MOO_XS_DISABLE};

