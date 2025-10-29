package Foo::ObjectMeta;
    use parent 'Object::Meta';

    sub new {
        my ($class, %args) = @_;

        $class->SUPER::new(%args);
    }

    sub foo {
        $_[0]->get('foo')
    }

    sub set_foo {
        $_[0]->set('foo', $_[1])
    }

    sub bar {
        $_[0]->get('bar')
    }

    sub set_bar {
        $_[0]->set('bar', $_[1])
    }

    sub baz {
        $_[0]->get('baz')
    }

    sub set_baz {
        $_[0]->set('baz', $_[1])
    }

1;
