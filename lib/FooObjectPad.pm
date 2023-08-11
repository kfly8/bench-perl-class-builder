use v5.38;
use Object::Pad;

class FooObjectPad {
    field $a :param :reader;
    field $b :param :reader;
    field $c :param :reader;
    field $d :param :reader;

    method foo() {
        $a . $b . $c . $d;
    }
};
