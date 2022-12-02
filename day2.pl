#!/usr/bin/perl -w

use strict;
use List::Util qw(sum);

my ($input) = $0 =~ /^([^.]+)/;
$input .= '_input';

my @values;
{
    local $/;
    open my $fh, "<$input" or die $!;
    push @values, join '', /(\w) (\w)/ foreach (split "\n", <$fh>);
}

print "Score part1: ", sum(map {AX => 4, AY => 8, AZ => 3, BX => 1, BY => 5, BZ => 9, CX => 7, CY => 2, CZ => 6}->{$_}, @values), "\n";
print "Score part2: ", sum(map {AX => 3, AY => 4, AZ => 8, BX => 1, BY => 5, BZ => 9, CX => 2, CY => 6, CZ => 7}->{$_}, @values), "\n";
