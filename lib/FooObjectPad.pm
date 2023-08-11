use v5.38;
use Object::Pad;

class FooObjectPad {
    field $a :param;
    field $b :param;
    field $c :param;
    field $d :param;

    method foo() {
        $a . $b . $c . $d;
    }
};
