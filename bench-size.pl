=head1 DESCRIPTION

Compare size of objects.

=head1 SYNOPSIS

    % carmel install
    % carmel exec -- perl -Ilib bench-size.pl

=head1 RESULT

    total_size	size_rate
    135.8 KB	--	class feature
    148.5 KB	9.3%	bless arrayref
    171.9 KB	26.6%	Object::Pad
    218.8 KB	61.1%	Object::Tiny
    218.8 KB	61.1%	Moo
    218.8 KB	61.1%	Class::Tiny
    218.8 KB	61.1%	Mouse
    218.8 KB	61.1%	Class::Accessor::Lite
    218.8 KB	61.1%	bless hashref
    257.9 KB	89.9%	Moose


    versions:
    Perl: 5.038000
    Object::Pad: 0.79
    Class::Accessor::Lite: 0.08
    Mouse: v2.5.10
    Moo: 2.005004
    Moose: 2.2206
    Class::Tiny: 1.008
    Object::Tiny: 1.09

=cut

use v5.38;
use Devel::Size qw(total_size);

use FooFeatureClass;
use FooObjectPad;
use FooClassAccessorLite;
use FooMouse;
use FooMoose;
use FooMoo;
use FooClassTiny;
use FooObjectTiny;
use FooBless;
use FooBlessArray;

my $description_mapping   = {
    FooFeatureClass      => 'class feature',
    FooObjectPad         => 'Object::Pad',
    FooClassAccessorLite => 'Class::Accessor::Lite',
    FooMouse             => 'Mouse',
    FooMoo               => 'Moo',
    FooMoose             => 'Moose',
    FooClassTiny         => 'Class::Tiny',
    FooObjectTiny        => 'Object::Tiny',
    FooBless             => 'bless hashref',
    FooBlessArray        => 'bless arrayref',
};

my %result;
for my $klass (keys %$description_mapping) {
    my $description = $description_mapping->{$klass};

    # create many objects
    my @list = map { $klass->new(foo => 'foo' . $_) } 1 .. 1000;
    my $total_size = total_size(\@list);

    $result{$description} = $total_size;
}

my $size_of_feature_class = $result{'class feature'};

my @report;
for my $description (sort { $result{$a} <=> $result{$b} } keys %result) {
    my $total_size = $result{$description};
    my $readable_size = sprintf("%.1f KB", $total_size / 1024);

    my $size_rate = (($total_size - $size_of_feature_class) / $size_of_feature_class) * 100;
    my $readable_size_rate = $size_rate == 0 ? '--'
                           : $size_rate <  0 ? sprintf('-%.1f%%', $size_rate)
                           :                   sprintf('%.1f%%', $size_rate);

    push @report => [ $readable_size, $readable_size_rate, $description ];
}

say join("\t", 'total_size', 'size_rate', '');
for my $report (@report) {
    say join("\t", @$report);
}

say "\n";
say 'versions:';
say "Perl: $]";

for my $module (qw(
        Object::Pad
        Class::Accessor::Lite
        Mouse
        Moo
        Moose
        Class::Tiny
        Object::Tiny
    )) {
    say "$module: ", $module->VERSION;
}


