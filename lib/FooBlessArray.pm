use v5.38;

package FooBlessArray {
    sub new {
        my ($class, %args) = @_;
        bless [ $args{foo} ], $class;
    }

    sub foo($self) {
        $self->[0]
    }
}
