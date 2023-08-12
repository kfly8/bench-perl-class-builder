use v5.38;
use experimental qw(class);

class Foo::FeatureClass {
    field $foo :param;

    method foo() { $foo }
};
