use v5.40;

package Foo::BlessArray {
    sub new {
        my ($class, %args) = @_;
        bless [ @args{qw(foo bar baz)} ], $class;
    }

    sub foo($self) {
        $self->[0]
    }

    sub bar($self) {
        $self->[1]
    }

    sub baz($self) {
        $self->[2]
    }
}

