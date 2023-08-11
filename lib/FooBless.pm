use v5.38;

package FooBless {
    sub new {
        my ($class, %args) = @_;
        bless \%args, $class;
    }

    sub a($self) { $self->{a} }
    sub b($self) { $self->{b} }
    sub c($self) { $self->{c} }
    sub d($self) { $self->{d} }

    sub foo($self) {
        $self->a . $self->b . $self->c . $self->d;
    }
}
