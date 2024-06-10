use v5.40;

package Foo::Bless {
    sub new {
        my ($class, %args) = @_;
        bless \%args, $class;
    }

    sub foo($self) {
        $self->{foo}
    }

    sub bar($self) {
        $self->{bar}
    }

    sub baz($self) {
        $self->{baz}
    }
}

