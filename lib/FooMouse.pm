use v5.38;

package FooMouse {
    use Mouse;

    has a => (is => 'ro');
    has b => (is => 'ro');
    has c => (is => 'ro');
    has d => (is => 'ro');

    sub foo($self) {
        $self->a . $self->b . $self->c . $self->d;
    }
}
