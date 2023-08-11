use v5.38;

package FooObjectTiny {
    use Object::Tiny qw(a b c d);

    sub foo($self) {
        $self->a . $self->b . $self->c . $self->d;
    }
}
