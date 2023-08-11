use v5.38;

package FooFunctionHash {
    sub foo(%args) {
        $args{a} . $args{b} . $args{c} . $args{d};
    }
}
