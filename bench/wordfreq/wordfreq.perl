#!/usr/bin/perl
# $Id: wordfreq.perl,v 1.1 2004-05-19 18:14:17 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/

# Tony Bowden suggested using tr versus lc and split(/[^a-z]/)

use strict;

my %count = ();
while (read(STDIN, $_, 4095) and $_ .= <STDIN>) {
    tr/A-Za-z/ /cs;
    ++$count{$_} foreach split(' ', lc $_);
}

my @lines = ();
my ($w, $c);
push(@lines, sprintf("%7d\t%s\n", $c, $w)) while (($w, $c) = each(%count));
print sort { $b cmp $a } @lines;
