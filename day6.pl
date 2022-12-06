#!/usr/bin/perl -w

use strict;
use File::Slurp;

my ($s, $i) = (read_file(($0 =~ /^([^.]+)/)[0] . '_input'), 0);

foreach my $t(4, 14) {
    1 while substr($s, $i++, $t) =~ /(.).*\1/;
    print "found type $t after ", $i+$t-1, " bytes\n"
}
