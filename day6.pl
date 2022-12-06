#!/usr/bin/perl -w

use strict;
use File::Slurp;

my ($input) = $0 =~ /^([^.]+)/;
$input .= '_input';

my $s = read_file($input);

my $b = '';
my $i = 0;
foreach my $t(4, 14) {
    do {
	$b = substr($s, $i++, $t);
	my %h;
	@h{split //, $b} = 1;
	if (scalar(keys %h) == $t) {
	    print "found type $t: '$b' after ", $i+$t-1, " byte\n";
	    $b = '';
	}
    } while (length($b) == $t);
}
