#!/usr/bin/perl
# The Great Computer Language Shootout
# http://shootout.alioth.debian.org/
#
# Contributed by Bradford Powell

use strict;

sub print_revcomp {
   my ($desc, $s) = @_;
   print $desc, "\n";
   $s =~ tr/wsatugcyrkmbdhvnATUGCYRKMBDHVN/WSTAACGRYMKVHDBNTAACGRYMKVHDBN/;
   $s = reverse $s;
   while ($s) {
      print substr($s, 0, 60), "\n";
      $s = substr($s, 60);
   }
}

my ($desc, $seq) = ('', '');
while (<STDIN>) {
   chomp;
   if (/^>/) {
      if ($desc) {
         print_revcomp($desc, $seq);
         $seq = '';
      }
      $desc = $_;
   } else {
      $seq .= $_;
   }
}
if ($desc) {
   print_revcomp($desc, $seq);
}
