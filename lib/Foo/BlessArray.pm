use v5.40;

package Foo::BlessArray {
    use Const::Fast qw(const);

    const my $foo => 0;
    const my $bar => 1;
    const my $baz => 2;

    sub new {
        my ($class, %args) = @_;
        bless [ @args{qw(foo bar baz)} ], $class;
    }

    sub foo {
        $_[0]->[$foo]
    }

    sub set_foo {
        $_[0]->[$foo] = $_[1];
    }

    sub bar {
        $_[0]->[$bar]
    }

    sub set_bar {
        $_[0]->[$bar] = $_[1];
    }

    sub baz {
        $_[0]->[$baz]
    }

    sub set_baz {
        $_[0]->[$baz] = $_[1];
    }

}

