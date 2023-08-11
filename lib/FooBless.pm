use v5.38;

package FooBless {
    sub new {
        my ($class, %args) = @_;
        bless \%args, $class;
    }

    sub foo($self) {
        $self->{foo}
    }
}
