use v5.40;

package Foo::BlessArray {
    use constant {
        FOO => 0,
        BAR => 1,
        BAZ => 2,
    };

    sub new {
        my ( $class, %args ) = @_;
        bless [ @args{qw(foo bar baz)} ], $class;
    }

    sub foo {
        $_[0]->[FOO];
    }

    sub set_foo {
        $_[0]->[FOO] = $_[1];
    }

    sub bar {
        $_[0]->[BAR];
    }

    sub set_bar {
        $_[0]->[BAR] = $_[1];
    }

    sub baz {
        $_[0]->[BAZ];
    }

    sub set_baz {
        $_[0]->[BAZ] = $_[1];
    }

}

