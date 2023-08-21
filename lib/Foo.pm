use v5.38;

package Foo {
    use Benchmark qw(cmpthese);
    use Devel::Size qw(total_size);

    use Foo::FeatureClass;
    use Foo::ObjectPad;
    use Foo::ClassAccessorLite;
    use Foo::Mouse;
    use Foo::Moose;
    use Foo::MooseXS;
    use Foo::Moo;
    use Foo::ClassTiny;
    use Foo::ObjectTiny;
    use Foo::Bless;
    use Foo::BlessArray;

    my $TITLE_MAPPING = {
        'Foo::FeatureClass'      => sprintf('`class feature (perl: %s)`', $]),
        'Foo::ObjectPad'         => sprintf('`Object::Pad@%s`', Object::Pad->VERSION),
        'Foo::ClassAccessorLite' => sprintf('`Class::Accessor::Lite@%s`', Class::Accessor::Lite->VERSION),
        'Foo::Mouse'             => sprintf('`Mouse@%s`', Mouse->VERSION),
        'Foo::Moo'               => sprintf('`Moo@%s`', Moo->VERSION),
        'Foo::Moose'             => sprintf('`Moose@%s`', Moose->VERSION),
        'Foo::MooseXS'           => sprintf('`Moose@%s (XSAccessor)`', Moose->VERSION),
        'Foo::ClassTiny'         => sprintf('`Class::Tiny@%s`', Class::Tiny->VERSION),
        'Foo::ObjectTiny'        => sprintf('`Object::Tiny@%s`', Object::Tiny->VERSION),
        'Foo::Bless'             => '`bless hashref`',
        'Foo::BlessArray'        => '`bless arrayref`',
    };

    sub run_benchmark($create_main_logic_coderef) {
        my $title_mapping = $TITLE_MAPPING;

        my $rows = cmpthese(-1, {
            map {
                my $benchmark_class = $_;
                my $title = $title_mapping->{$benchmark_class};
                $title => $create_main_logic_coderef->($benchmark_class);
            } keys %$title_mapping,
        }, 'none');

        my $header = shift @$rows;

        # find the index of the 'class feature' row
        my ($x) = map { $header->[$_] =~ /class feature/ ? ($_) : ()  } 0 .. $#$header;

        say join "\t", qw(Rate Compare Title);
        for my $row (@$rows) {
            say join "\t",
                $row->[1], # Rate
                $row->[$x], # compare 'class feature'
                $row->[0]; # Title
        }
    }

    sub run_memory_consumption_benchmark($create_main_logic_coderef) {
        my $title_mapping = $TITLE_MAPPING;

        my %result;
        for my $benchmark_class (keys %$title_mapping) {
            my $title = $title_mapping->{$benchmark_class};

            my $logic = $create_main_logic_coderef->($benchmark_class);
            my $result = $logic->();
            my $total_size = total_size($result);

            $result{$title} = $total_size;
        }

        my ($size_of_feature_class) = map { $_ =~ /class feature/ ? ($result{$_}) : ()  } keys %result;

        my @report;
        for my $title (sort { $result{$a} <=> $result{$b} } keys %result) {
            my $total_size = $result{$title};
            my $readable_size = sprintf("%.1f KB", $total_size / 1024);

            my $size_rate = (($total_size - $size_of_feature_class) / $size_of_feature_class) * 100;
            my $readable_size_rate = $size_rate == 0 ? '--'
                                   : $size_rate <  0 ? sprintf('-%.1f%%', $size_rate)
                                   :                   sprintf('%.1f%%', $size_rate);

            push @report => [ $readable_size, $readable_size_rate, $title ];
        }

        say join("\t", 'Size', 'Compare', 'Title');
        for my $report (@report) {
            say join("\t", @$report);
        }
    }
}

