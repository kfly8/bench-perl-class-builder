use v5.38;

BEGIN {
    use Method::Generate::Accessor;
    $Method::Generate::Accessor::CAN_HAZ_XS = 1;
}

package Foo::MooXS {
    use Moo;
    use MooX::XSConstructor;

    has foo => (is => 'ro');
    has bar => (is => 'ro');
    has baz => (is => 'ro');
}

