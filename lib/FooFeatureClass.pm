use v5.38;
use experimental qw(class);

class FooFeatureClass {
    field $foo :param;

    method foo() { $foo }
};
