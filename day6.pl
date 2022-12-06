#!/usr/bin/perl -w

use strict;
use File::Slurp;

my ($input) = $0 =~ /^([^.]+)/;
$input .= '_input';

my $s = read_file($input);

my $i = 0;
foreach my $t(4, 14) {
    while ($i < length($s)-$t) {
	my %h; @h{split //, substr($s, $i++, $t)} = 1;
	do { print "found type $t after ", $i+$t-1, " bytes\n"; last; } if scalar(keys %h) == $t;
    }
}
