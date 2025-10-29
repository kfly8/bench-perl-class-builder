use v5.40;
use experimental qw(class);

class Foo::FeatureClass {
    field $foo :param :reader;
    field $bar :param :reader;
    field $baz :param :reader;

    method set_foo( $value ) { $foo = $value; }
    method set_bar( $value ) { $bar = $value; }
    method set_baz( $value ) { $baz = $value; }
};

