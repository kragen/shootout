#!/usr/bin/perl

# The Great Computer Language Shootout
# http://shootout.alioth.debian.org/
# k-nucleotide count benchmark
# contributed by Joel Hoffman, 2005-03-24

use strict;
use List::Util;

sub round_even { 
   my $ipart = int($_[0]);
   my $fpart = $_[0] - $ipart;
   return ($ipart + (($fpart == 0.5) ? 0 : ($fpart > 0.5)));
}

my @keys;
my $sequence = "";

$/ = ">"; # Input Record Separator
while (defined(my $l = <STDIN>)) {
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
    my $sum = List::Util::sum values %$k;

    printf "%s %4.2f\n",$_,round_even(10000 * $k->{$_} / $sum)/100
      for sort { $k->{$b} <=> $k->{$a} or $a cmp $b }
        keys %$k;
   print "\n";
}

printf "%d\t%s\n", $keys[length $_]{$_}, $_
   for qw<GGT GGTA GGTATT GGTATTTTAATT GGTATTTTAATTTATAGT>;
