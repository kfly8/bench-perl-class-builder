use v5.40;

BEGIN {
    use Method::Generate::Accessor;
    $Method::Generate::Accessor::CAN_HAZ_XS = 0;
}

package Foo::Moo {
    use Moo;

    has foo => (is => 'rw');
    has bar => (is => 'rw');
    has baz => (is => 'rw');
}

