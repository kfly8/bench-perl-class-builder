use v5.40;
use experimental qw(class);

class Foo::FeatureClass {
    field $foo :param :reader;
    field $bar :param :reader;
    field $baz :param :reader;
};

