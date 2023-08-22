use v5.38;

package Foo::Moose {
    use Moose;

    has foo => (is => 'ro');

    __PACKAGE__->meta->make_immutable;
}

