use v5.40;

package Foo::MooseXS {
    use Moose;
    use MooseX::XSAccessor;

    has foo => (is => 'ro');
    has bar => (is => 'ro');
    has baz => (is => 'ro');

    __PACKAGE__->meta->make_immutable;
}

