use v5.38;

package FooClassTiny {
    use Class::Tiny qw(a b c d);

    sub foo($self) {
        $self->a . $self->b . $self->c . $self->d;
    }
}
