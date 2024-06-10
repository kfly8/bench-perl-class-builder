use v5.40;

package Foo::ClassAccessorLite {
    use Class::Accessor::Lite (
        new => 1,
        ro  => [qw(foo bar baz)],
    );
}

