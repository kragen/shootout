# The Computer Language Benchmarks Game
# http://shootout.alioth.debian.org/
# implemented by Greg Buchholz
# streamlined by Kalev Soikonen
# parallelised by Philip Boulain
use warnings; use strict; use threads;

use constant ITER     => 50;
use constant LIMITSQR => 2.0 ** 2;

my ($w, $h);
$w = $h = shift || 80;
my $threads = 4; # (workers; ideally matches number of processors)

# Generate pixel data for a single dot
sub dot($$) {
   my ($Zr, $Zi, $Tr, $Ti) = (0.0,0.0,0.0,0.0);
   my $i = ITER;
   my $Cr = 2 * $_[0] / $w - 1.5;
   my $Ci = 2 * $_[1] / $h - 1.0;
   (
      $Zi = 2.0 * $Zr * $Zi + $Ci,
      $Zr = $Tr - $Ti + $Cr,
      $Ti = $Zi * $Zi,
      $Tr = $Zr * $Zr
   ) until ($Tr + $Ti > LIMITSQR || !$i--);
   return ($i == -1);
}

# Generate pixel data for range of lines, inclusive
sub lines($$) {
   map { my $y = $_;
      pack 'B*', pack 'C*', map dot($_, $y), 0..$w-1;
   } $_[0]..$_[1];
}

# Decide upon roughly equal batching of workload
$threads = $h if $threads > $h;
my $each = $h / $threads;
my $y = 0;
my @workers;
# Spawn the workers to each work on a batch of lines
for (1..$threads) {
   my $y2 = $y + $each;
   $y2 = $h if $_ == $threads;
   push @workers, threads->create('lines', $y, $y2 - 1);
   $y = $y2;
}
# Output the result of each worker, blocking for each to finish
print "P4\n$w $h\n";
foreach (@workers) {
   print $_->join();
}

