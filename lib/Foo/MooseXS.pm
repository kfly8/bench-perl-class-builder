use v5.42;

package Foo::MooseXS {
    use Moose;
    use MooseX::XSAccessor;

    has foo => (is => 'rw');
    has bar => (is => 'rw');
    has baz => (is => 'rw');

    __PACKAGE__->meta->make_immutable;
}

