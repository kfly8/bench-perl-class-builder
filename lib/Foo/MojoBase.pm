use v5.42;
use Mojolicious;

package Foo::MojoBase {
    use Mojo::Base -base, -signatures;

    has 'foo';
    has 'bar';
    has 'baz';
}
