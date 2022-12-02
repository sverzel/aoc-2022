#!/usr/bin/perl -w

use strict;

my ($input) = $0 =~ /^([^.]+)/;
$input .= '_input';

my @values;
{
    local $/;
    open my $fh, "<$input" or die $!;
    @values = split "\n", <$fh>;
}

sub sum {
	my $r = shift;
	my $s = 0;
	foreach (@values) {
		chomp; s/ //;
		$s += $r->{ $_ };
	}
	
	return $s;
}

print "Score: ", sum({AX => 4, AY => 8, AZ => 3, BX => 1, BY => 5, BZ => 9, CX => 7, CY => 2, CZ => 6}), "\n";

print "Score: ", sum({AX => 3, AY => 4, AZ => 8, BX => 1, BY => 5, BZ => 9, CX => 2, CY => 6, CZ => 7}), "\n";
