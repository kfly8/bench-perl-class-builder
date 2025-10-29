use v5.40;

package Foo::ClassAccessorLite {
    use Class::Accessor::Lite (
        new => 1,
        rw  => [qw(foo bar baz)],
    );
}

