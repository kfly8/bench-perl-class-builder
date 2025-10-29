use v5.40;
use experimental qw(class);

class Foo::FeatureClass {
    field $foo :param :reader :writer;
    field $bar :param :reader :writer;
    field $baz :param :reader :writer;
};

