use v5.42;

package Foo::ClassAccessorLite {
    use Class::Accessor::Lite (
        new => 1,
        rw  => [qw(foo bar baz)],
    );
}

