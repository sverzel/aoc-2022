#!/usr/bin/perl -w

use strict;

my ($input) = $0 =~ /^([^.]+)/;
$input .= '_input';

my @values;
{
    local $/;
    open my $fh, "<$input" or die $!;
    @values = split "\n\n", <$fh>;
}

my $max = 0;
my @elves_calories;
foreach my $set(@values) {
    my $sum;
    $sum += $_ foreach split "\n", $set;
    $max = $sum if $max < $sum;
    push @elves_calories, $sum;
}

print "Max calories: $max\n";

@elves_calories = sort {$a <=> $b} @elves_calories;

my $top_3_sum;
$top_3_sum += $_ foreach @elves_calories[-3 .. -1];

print "Top 3 sum calories: $top_3_sum\n";
