#!/usr/bin/perl

# The Great Computer Language Shootout
# http://shootout.alioth.debian.org/
# k-nucleotide count benchmark
# contributed by Joel Hoffman, 2005-03-24

use strict;

my @keys;
my $sequence = "";

$/ = ">"; # Input Record Separator
while (defined(my $l = <>)) {
   if ($l =~ /^THREE/i) {
      chomp $l;
      my @l = split /\n+/, $l;
      $sequence = uc join("",grep $_ !~ /^;/, @l[1..$#l]);
      last;
   }
}

for my $n (1,2,3,4,6,12,18) {
   for my $i (0..(length $sequence) - $n) {
      $keys[$n]{substr($sequence,$i,$n)}++;
   }
}

for my $k (@keys[1,2]) {
   printf "%s %4.2f\n",$_,(100 * $k->{$_})/(length $sequence)
     for sort { $k->{$b} <=> $k->{$a} or $a cmp $b }
       keys %$k;
   print "\n";
}

printf "%d\t%s\n", $keys[length $_]{$_}, $_
   for qw<GGT GGTA GGTATT GGTATTTTAATT GGTATTTTAATTTATAGT>;
