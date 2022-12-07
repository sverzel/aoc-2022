#!/usr/bin/perl -w

use strict;
use List::Util qw/sum/;

my @values;
{
    local $/;
    open my $fh, ($0 =~ /^([^.]+)/)[0] . '_input' or die $!;
    push @values, split "\n", <$fh>;
}

my $c = '';
my %fs;
while (my $line = shift @values) {
    $fs{$c} = 0 unless $fs{$c};

    next if $line =~ /^\$\sls|^dir\s/;
    if ($line =~ /^\$/) {
	my ($cmd, $arg) = $line =~ /\$\s([\S]+)(?:\s(\S+))?$/;
	if ($cmd eq 'cd') {
	    if ($arg =~ m[^/]) {
		$c = $arg;
	    }
	    elsif ($arg eq '..') {
		($c) = $c =~ m{^(.*)/[^/]+$};
	    }
	    else {
		$c .= ($c eq '/' ? '' : '/') . $arg;
	    }
	}
    }
    else {
	$fs{$c} += (split /\s+/, $line)[0];
    }
}

# best of luck to you to understand the following :-D
foreach my $path(sort { ($b =~ tr[/][]) <=> ($a =~ tr[/][]) || length($b) <=> length($a) } keys %fs) {
    if ($path =~ m{^/.+}) {
	my ($x) = $path =~ m{^(.*)/[^/]+$};
	$x = '/' unless $x;
	$fs{$x} += $fs{$path};
    }
}

print "Sum of <= 100k directories: ", sum(map $fs{$_}, grep $fs{$_} <= 100000 ? $fs{$_} : 0, keys %fs), "\n";

my $r = 30000000 - (70000000 - $fs{'/'});

foreach my $path(sort {$fs{$a} <=> $fs{$b}} keys %fs) {
    if ($fs{$path} >= $r) {
	print "Found path '$path' of size $fs{$path}\n";
	exit;
    }
}
