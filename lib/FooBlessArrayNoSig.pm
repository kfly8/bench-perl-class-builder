use v5.38;

package FooBlessArrayNoSig {
    sub new {
        my ($class, %args) = @_;
        bless [ $args{a}, $args{b}, $args{c}, $args{d} ], $class;
    }

    sub a { $_[0]->[0] }
    sub b { $_[0]->[1] }
    sub c { $_[0]->[2] }
    sub d { $_[0]->[3] }

    sub foo {
        my $self = shift;
        $self->a . $self->b . $self->c . $self->d;
    }
}
