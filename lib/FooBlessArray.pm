use v5.38;

package FooBlessArray {
    sub new {
        my ($class, %args) = @_;
        bless [ $args{a}, $args{b}, $args{c}, $args{d} ], $class;
    }

    sub a($self) { $self->[0] }
    sub b($self) { $self->[1] }
    sub c($self) { $self->[2] }
    sub d($self) { $self->[3] }

    sub foo($self) {
        $self->a . $self->b . $self->c . $self->d;
    }
}
