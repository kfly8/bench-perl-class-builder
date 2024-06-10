use v5.40;

BEGIN {
    use Method::Generate::Accessor;
    $Method::Generate::Accessor::CAN_HAZ_XS = 0;
}

package Foo::Moo {
    use Moo;

    has foo => (is => 'ro');
    has bar => (is => 'ro');
    has baz => (is => 'ro');
}

