#!/usr/bin/perl

# The Great Computer Language Shootout
# http://shootout.alioth.debian.org/
# reverse-complement benchmark
# contributed by Joel Hoffman, 2005-03-24

use POSIX qw<ceil>;
use strict;

$/=">";

while (defined(my $l = <>)) {
   chomp $l; 
   next unless $l;

   my $rv = "";

   for ( split /\n/, '>'.$l ) {
      if (/^[;>]/) {
         print $_,"\n";
      } else {
         $rv = (reverse uc $_) . $rv;
      }
   }

   $rv =~ tr/ACGTUMRWSYKVHDBN/TGCAAKYWSRMBDHVN/;

   print substr($rv,$_*60,60),"\n" for 0..ceil(length($rv) / 60 - 1); 
}

