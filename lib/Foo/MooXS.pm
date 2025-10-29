use v5.40;

BEGIN {
    use Method::Generate::Accessor;
    $Method::Generate::Accessor::CAN_HAZ_XS = 1;
}

package Foo::MooXS {
    use Moo;
    use MooX::XSConstructor;

    has foo => (is => 'rw');
    has bar => (is => 'rw');
    has baz => (is => 'rw');
}

