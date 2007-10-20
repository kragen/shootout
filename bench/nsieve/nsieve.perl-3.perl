# The Computer Language Benchmarks Game
# http://shootout.alioth.debian.org/
#
# contributed by David Pyke, March 2005
# optimized by Steffen Mueller, Sept 2007
# optimized by Laimonas Vėbra, Oct 2007

use integer;
use strict;

sub nsieve {
	my ($m) = @_;
	my @a;
	my $i = 2;	
	my $j = 0;
	my $count = 0;
	
	$a[$m] = 0;	

   for($i; $i < $m; $i++) {
      if (!$a[$i]) {
         for ($j = $i + $i; $j < $m; $j += $i){
            $a[$j] = 1;
         }
         ++$count;
      }
   }
   return $count;
}


sub nsieve_test {
   my($n) = @_;

   my $m = (1<<$n) * 10000;
   my $ncount= nsieve($m);
   printf "Primes up to %8u %8u\n", $m, $ncount;
}

my $N = ($ARGV[0] < 1) ? 1 : $ARGV[0];

nsieve_test($N);
nsieve_test($N-1)  if $N >= 1;
nsieve_test($N-2)  if $N >= 2;
