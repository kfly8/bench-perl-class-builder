use v5.40;
use Mojolicious;

package Foo::Mojo {
    use Mojo::Base -base;

    has [ 'foo', 'bar', 'baz' ];
}
