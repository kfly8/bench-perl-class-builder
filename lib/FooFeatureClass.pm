use v5.38;
use experimental qw(class);

class FooFeatureClass {
    field $a :param;
    field $b :param;
    field $c :param;
    field $d :param;

    method foo() {
        $a . $b . $c . $d;
    }
};
