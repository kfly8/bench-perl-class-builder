#!/usr/bin/env perl

=head1 DESCRIPTION

Update README.md with benchmark results.

=head1 SYNOPSIS

    perl update-readme.pl

=cut

use v5.38;
use strict;
use warnings;
use File::Spec;

# File paths
my $readme_file = 'README.md';
my $size_results = 'results/bench-size.txt';
my $new_results = 'results/bench-new.txt';
my $field_results = 'results/bench-field.txt';

# Read benchmark results from file
sub read_benchmark_results {
    my ($file) = @_;
    
    open my $fh, '<', $file or die "Cannot open $file: $!";
    my @lines = <$fh>;
    close $fh;
    
    return @lines;
}

# Calculate column widths for proper alignment
sub calculate_column_widths {
    my (@lines) = @_;
    my @widths;
    
    foreach my $line (@lines) {
        chomp $line;
        next if $line eq '';
        
        my @fields = split /\t/, $line;
        for my $i (0 .. $#fields) {
            my $len = length($fields[$i]);
            $widths[$i] = $len if !defined $widths[$i] || $len > $widths[$i];
        }
    }
    
    return @widths;
}

# Convert benchmark results to markdown table with proper alignment
sub convert_to_markdown_table {
    my (@lines) = @_;
    
    my @widths = calculate_column_widths(@lines);
    my @markdown_lines;
    my $is_header = 1;
    
    foreach my $line (@lines) {
        chomp $line;
        next if $line eq '';
        
        # Split by tab
        my @fields = split /\t/, $line;
        
        # Pad fields for alignment
        my @padded;
        for my $i (0 .. $#fields) {
            my $width = $widths[$i] // length($fields[$i]);
            $padded[$i] = sprintf("%-*s", $width, $fields[$i]);
        }
        
        # Convert to markdown table row
        push @markdown_lines, '| ' . join(' | ', @padded) . ' |';
        
        # Add separator line after header
        if ($is_header) {
            my @separators = map { '-' x $_ } @widths;
            push @markdown_lines, '| ' . join(' | ', @separators) . ' |';
            $is_header = 0;
        }
    }
    
    return @markdown_lines;
}

# Update README section
sub update_readme_section {
    my ($readme_content, $section_title, $new_table_lines) = @_;
    
    # Find the section
    my @lines = split /\n/, $readme_content;
    my $in_section = 0;
    my $section_start = -1;
    my $table_start = -1;
    my $table_end = -1;
    
    for my $i (0 .. $#lines) {
        if ($lines[$i] =~ /^## \Q$section_title\E\s*$/) {
            $section_start = $i;
            $in_section = 1;
            next;
        }
        
        if ($in_section && $lines[$i] =~ /^\|/) {
            if ($table_start == -1) {
                $table_start = $i;
            }
            $table_end = $i;
        }
        
        if ($in_section && $lines[$i] =~ /^##/ && $i > $section_start) {
            # Next section started
            last;
        }
        
        if ($in_section && $lines[$i] =~ /^This result/) {
            # End of table section
            last;
        }
    }
    
    if ($table_start != -1 && $table_end != -1) {
        # Replace table content
        splice @lines, $table_start, ($table_end - $table_start + 1), @$new_table_lines;
    }
    
    return join("\n", @lines);
}

# Main logic
sub main {
    # Check if result files exist
    my @missing;
    push @missing, $size_results unless -f $size_results;
    push @missing, $new_results unless -f $new_results;
    push @missing, $field_results unless -f $field_results;
    
    if (@missing) {
        die "Result files not found: " . join(", ", @missing) . "\nPlease run benchmarks first.\n";
    }
    
    # Read README
    open my $readme_fh, '<', $readme_file or die "Cannot open $readme_file: $!";
    my $readme_content = do { local $/; <$readme_fh> };
    close $readme_fh;
    
    # Update memory size section
    my @size_lines = read_benchmark_results($size_results);
    my @size_table = convert_to_markdown_table(@size_lines);
    $readme_content = update_readme_section($readme_content, 'Benchmark memory size', \@size_table);
    
    # Update object constructors section
    my @new_lines = read_benchmark_results($new_results);
    my @new_table = convert_to_markdown_table(@new_lines);
    $readme_content = update_readme_section($readme_content, 'Benchmark object constructors', \@new_table);
    
    # Update field access section
    my @field_lines = read_benchmark_results($field_results);
    my @field_table = convert_to_markdown_table(@field_lines);
    $readme_content = update_readme_section($readme_content, 'Benchmark access to object fields', \@field_table);
    
    # Write updated README
    open my $write_fh, '>', $readme_file or die "Cannot write to $readme_file: $!";
    print $write_fh $readme_content;
    close $write_fh;
    
    say "README.md updated successfully!";
}

main();
