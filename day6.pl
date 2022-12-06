#!/usr/bin/perl -w

use strict;
use File::Slurp;

my ($input) = $0 =~ /^([^.]+)/;

my ($s, $i) = (read_file($input . '_input'), 0);

foreach my $t(4, 14) {
    while ($i < length($s)-$t) {
	my %h; @h{split //, substr($s, $i++, $t)} = 1;
	do { print "found type $t after ", $i+$t-1, " bytes\n"; last; } if scalar(keys %h) == $t;
    }
}
