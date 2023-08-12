use v5.38;

package Foo {

    use Foo::FeatureClass;
    use Foo::ObjectPad;
    use Foo::ClassAccessorLite;
    use Foo::Mouse;
    use Foo::Moose;
    use Foo::Moo;
    use Foo::ClassTiny;
    use Foo::ObjectTiny;
    use Foo::Bless;
    use Foo::BlessArray;

    our $TITLE_MAPPING = {
        'Foo::FeatureClass'      => sprintf('class feature (perl: %s)', $]),
        'Foo::ObjectPad'         => sprintf('Object::Pad@%s', Object::Pad->VERSION),
        'Foo::ClassAccessorLite' => sprintf('Class::Accessor::Lite@%s', Class::Accessor::Lite->VERSION),
        'Foo::Mouse'             => sprintf('Mouse@%s', Mouse->VERSION),
        'Foo::Moo'               => sprintf('Moo@%s', Moo->VERSION),
        'Foo::Moose'             => sprintf('Moose@%s', Moose->VERSION),
        'Foo::ClassTiny'         => sprintf('Class::Tiny@%s', Class::Tiny->VERSION),
        'Foo::ObjectTiny'        => sprintf('Object::Tiny@%s', Object::Tiny->VERSION),
        'Foo::Bless'             => 'bless hashref',
        'Foo::BlessArray'        => 'bless arrayref',
    };
}
