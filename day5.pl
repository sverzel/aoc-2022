#!/usr/bin/perl -w

use strict;

my ($input) = $0 =~ /^([^.]+)/;
$input .= '_input';

my @values;
{
    local $/;
    open my $fh, "<$input" or die $!;
    push @values, split "\n", <$fh>;
}

my (@s1, @s2);
while (my $line = shift @values) {
    shift @values, last if $line =~ /^[\s\d]+$/;
    my @a = $line =~ /[\[ ](.)[\] ]\s?/g;
    for (my $i = 0; $i < @a; $i++) {
	next if $a[$i] eq ' ';
	unshift @{$_}, $a[$i] foreach $s1[$i], $s2[$i];
    }
}

foreach my $instr(@values) {
    my ($n, $f, $t) = $instr =~ /^move (\d+) from (\d+) to (\d+)$/;
    push @{$s1[$t-1]}, pop @{$s1[$f-1]} for 1 .. $n;
    push @{$s2[$t-1]}, splice @{$s2[$f-1]}, scalar(@{$s2[$f-1]})-$n, $n;
}

print 'Top of stack single move: ', join '', map($_->[-1], @s1), "\n";
print 'Top of stack multiple move: ', join '', map($_->[-1], @s2), "\n";
