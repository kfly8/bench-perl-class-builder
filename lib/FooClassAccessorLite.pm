use v5.38;

package FooClassAccessorLite {
    use Class::Accessor::Lite (
        new => 1,
        ro  => [qw(foo)],
    );
}
