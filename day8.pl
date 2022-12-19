#!/usr/bin/perl -w

use strict;
use Data::Dumper qw/Dumper/;

my $g;
{
    local $/;
    open my $fh, ($0 =~ /^([^.]+)/)[0] . '_input' or die $!;
    push @{$g}, map [split //], split "\n", <$fh>;
}

my ($nv, $mvd) = (0, 0);
for (my $i = 1; $i < @{$g->[0]}-1; $i++) {
    for (my $x = 1; $x < @{$g->[$i]}; $x++) {
	$nv++ if scalar(grep $_ >= $g->[$i][$x], @{$g->[$i]}[0..$x-1])>0
	    && scalar(grep $_ >= $g->[$i][$x], @{$g->[$i]}[$x+1..@{$g->[$i]}-1])>0
	    && scalar(grep $_ >= $g->[$i][$x], map($_->[$x], @{$g}[0..$i-1]))>0
	    && scalar(grep $_ >= $g->[$i][$x], map($_->[$x], @{$g}[$i+1..@$g-1]))>0;

	my $l = 1; $l++ while $x-$l >= 0 && $g->[$i][$x-$l] < $g->[$i][$x];
	my $r = 1; $r++ while $x+$r < @{$g->[$i]} && $g->[$i][$x+$r] < $g->[$i][$x];
	my $u = 1; $u++ while $i-$u >= 0 && $g->[$i-$u][$x] < $g->[$i][$x];
	my $d = 1; $d++ while $i+$d < @$g && $g->[$i+$d][$x] < $g->[$i][$x];
	$mvd = ($l-1) * $r * ($u-1) * ($d-1) if ($l-1) * $r * ($u-1) * ($d-1) > $mvd;
    }
}

print "Visible trees: ", @$g*@{$g->[0]}-$nv, "\n";
print "Maximum viewing distance: $mvd\n";
