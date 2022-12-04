#!/usr/bin/perl -w

use strict;
use List::Util qw(sum);

my ($input) = $0 =~ /^([^.]+)/;
$input .= '_input';

my @values;
{
    local $/;
    open my $fh, "<$input" or die $!;
    push @values, [map [split '-'], split ','] foreach split "\n", <$fh>;
}

print "Number of fully covering pairs: ", sum(map $_->[0][0] <= $_->[1][0] && $_->[0][1] >= $_->[1][1] || $_->[1][0] <= $_->[0][0] && $_->[1][1] >= $_->[0][1] ? 1 : 0, @values), "\n";
print "Number of partly covering pairs: ", sum(map {my %h; map $h{$_} = 1, $_->[0][0]..$_->[0][1]; scalar(grep $h{$_}, $_->[1][0]..$_->[1][1])>0 ? 1 : 0} @values), "\n";
