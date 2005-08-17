#!/usr/bin/perl
# The Great Computer Language Shootout
# http://shootout.alioth.debian.org/
#
# Contributed by Bradford Powell
# Modified by Chris Currivan
# Modified by Doug King

use strict;

sub print_revcomp {
   my ($desc, $s) = @_;
   print $desc, "\n";
   $s =~ tr/wsatugcyrkmbdhvnATUGCYRKMBDHVN/WSTAACGRYMKVHDBNTAACGRYMKVHDBN/;
   $s = reverse $s;
   while ($s) {
      print substr($s, 0, 60, ""), "\n";
   }
}

my $desc = '';
my @seq = ();
while (<STDIN>) {
   chomp;
   if (/^>/) {
      if ($desc) {
         print_revcomp($desc, join('',@seq));
         @seq = ();
      }
      $desc = $_;
   } else {
      push @seq, $_;
   }
}
if ($desc) {
   print_revcomp($desc, join('',@seq));
}
