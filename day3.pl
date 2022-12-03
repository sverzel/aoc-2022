#!/usr/bin/perl -w

use strict;
my ($input) = $0 =~ /^([^.]+)/;
$input .= '_input';

my @values;
{
    local $/;
    open my $fh, "<$input" or die $!;
    push @values, [split //] foreach split "\n", <$fh>;
}

my %p;
@p{'a'..'z'} = (1..26);
@p{'A'..'Z'} = (27..52);

sub intersect {
    my ($a, $b) = @_;
    my %h;
    map $h{$_} = 1, @$b;
    return do { my %s; grep $h{$_} && !$s{$_}++, @$a };
}

my $s;
foreach my $rs(@values) {
    my $l = scalar(@$rs);
    my @a = (@$rs)[0..$l/2-1];
    my @b = (@$rs)[$l/2..$l-1];
    $s += $p{$_} foreach intersect([@a], [@b]);
}

print "Sum of priorities: $s\n";

$s = 0;
for (my $i = 0; $i < @values; $i += 3) {
    my ($is) = intersect([intersect($values[$i], $values[$i+1])], $values[$i+2]);
    $s += $p{ $is };
}

print "Badge priorities: $s\n";
