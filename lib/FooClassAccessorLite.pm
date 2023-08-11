use v5.38;

package FooClassAccessorLite {
    use Class::Accessor::Lite (
        new => 1,
        ro  => [qw(a b c d)],
    );

    sub foo($self) {
        $self->a . $self->b . $self->c . $self->d;
    }
}
