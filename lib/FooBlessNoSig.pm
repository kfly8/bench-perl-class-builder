use v5.38;

package FooBlessNoSig {
    sub new {
        my ($class, %args) = @_;
        bless \%args, $class;
    }

    sub foo {
        my $self = shift;
        $self->{a} . $self->{b} . $self->{c} . $self->{d};
    }
}
