use v5.38;

package FooBlessNoSig {
    sub new {
        my ($class, %args) = @_;
        bless \%args, $class;
    }

    sub a { $_[0]->{a} }
    sub b { $_[0]->{b} }
    sub c { $_[0]->{c} }
    sub d { $_[0]->{d} }

    sub foo {
        my $self = shift;
        $self->a . $self->b . $self->c . $self->d;
    }
}
