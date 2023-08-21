use v5.38;
use experimental qw(class);

class Foo::FeatureClass {
    field $foo :param;
    field $bar :param;
    field $baz :param;

    method foo() { $foo }
    method bar() { $bar }
    method baz() { $baz }
};

