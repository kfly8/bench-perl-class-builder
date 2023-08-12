use v5.38;

package Foo::ClassAccessorLite {
    use Class::Accessor::Lite (
        new => 1,
        ro  => [qw(foo)],
    );
}
