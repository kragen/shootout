# The Computer Language Benchmarks Game
# http://shootout.alioth.debian.org/
#
# Contributed by Bradford Powell
# Fixed slow print substr-solution, by Kjetil Skotheim
# Changed input reading method and avoid a sub call by Bruno Vecchi

use strict;
use feature 'say';

local $/ = ">";
while (my $entry = <STDIN>) {
    chomp $entry;

    my ($header, $seq) = split /\n/, $entry, 2;
    next unless $header;

    {
        local $/ = "\n";
        say ">", $header;

        $seq =~ s/\n//g;
        $seq =  reverse $seq;
        $seq =~ tr{wsatugcyrkmbdhvnATUGCYRKMBDHV}
                  {WSTAACGRYMKVHDBNTAACGRYMKVHDB};

        my $lines   = length($seq)/60;
        my $current = 0;

        say substr($seq, $current++*60, 60)
            while $current < $lines;
    }
}
