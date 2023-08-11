use v5.38;

package FooBlessArrayNoSig {
    sub new {
        my ($class, %args) = @_;
        bless [ $args{a}, $args{b}, $args{c}, $args{d} ], $class;
    }

    sub foo {
        my $self = shift;
        $self->[0] . $self->[1] . $self->[2] . $self->[3];
    }
}
