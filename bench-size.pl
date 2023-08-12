=head1 DESCRIPTION

Compare size of objects.

=head1 SYNOPSIS

    % carmel install
    % carmel exec -- perl -Ilib bench-size.pl

=head1 RESULT

    Size	Compare	Title
    135.8 KB	--	class feature (perl: 5.038000)
    148.5 KB	9.3%	bless arrayref
    171.9 KB	26.6%	Object::Pad@0.79
    218.8 KB	61.1%	Object::Tiny@1.09
    218.8 KB	61.1%	Mouse@v2.5.10
    218.8 KB	61.1%	Class::Accessor::Lite@0.08
    218.8 KB	61.1%	Class::Tiny@1.008
    218.8 KB	61.1%	bless hashref
    218.8 KB	61.1%	Moo@2.005004
    257.9 KB	89.9%	Moose@2.2206

=cut

use v5.38;
use Devel::Size qw(total_size);
use Foo;

my $title_mapping = $Foo::TITLE_MAPPING;

my %result;
for my $klass (keys %$title_mapping) {
    my $title = $title_mapping->{$klass};

    # create many objects
    my @list = map { $klass->new(foo => 'foo' . $_) } 1 .. 1000;
    my $total_size = total_size(\@list);

    $result{$title} = $total_size;
}

my ($size_of_feature_class) = map { $_ =~ /^class feature/ ? ($result{$_}) : ()  } keys %result;

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

