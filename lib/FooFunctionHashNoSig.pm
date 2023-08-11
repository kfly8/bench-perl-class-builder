use v5.38;

package FooFunctionHashNoSig {
    sub foo {
        my %args = @_;
        $args{a} . $args{b} . $args{c} . $args{d};
    }
}
