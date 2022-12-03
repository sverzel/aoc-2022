#!/usr/bin/perl -w

use strict;
use List::Util qw(sum);

my ($input) = $0 =~ /^([^.]+)/;
$input .= '_input';

my @values;
{
    local $/;
    open my $fh, "<$input" or die $!;
    push @values, [split //] foreach split "\n", <$fh>;
}

my %p; @p{'a'..'z', 'A'..'Z'} = (1..52);

sub intersect {
    my %h; map $h{$_} = 1, @{$_[1]};
    return do { my %s; grep $h{$_} && !$s{$_}++, @{$_[0]} };
}

print "Sum of priorities: ", sum(map $p{ (intersect([(@$_)[0..@$_/2-1]], [(@$_)[@$_/2..@$_-1]]))[0] }, @values), "\n";

my $s = 0; $s += $p{ (intersect([intersect(pop @values, pop @values)], pop @values))[0] } while @values;
print "Badge priorities: $s\n";
