# The Computer Language Benchmarks Game
# http://shootout.alioth.debian.org/

# Initial port from C by Steve Clark
# Rewrite by Kalev Soikonen
# Modified by Kuang-che Wu
# Multi-threaded by Andrew Rodland

use integer;
use threads;

sub fannkuch {
  my ($n, $last) = @_;
  my ($iter, $flips, $maxflips);
  my (@q, @p, @count);

  @p = (1 .. $last - 1, $last + 1 .. $n, $last);
  @count = (1..$n);

  TRY: while (1) {
    if ($p[0] != 1 && $p[-1] != $n) {
      @q = @p;
      for ($flips=0; $q[0] != 1; $flips++) {
        unshift @q, reverse splice @q, 0, $q[0];
      }
      $maxflips = $flips if $flips > $maxflips;
    }

    for my $i (1 .. $n - 2) {
      splice @p, $i, 0, shift @p;
      next TRY if (--$count[$i]);
      $count[$i] = $i + 1;
    }
    return $maxflips;
  }
}

sub print30 {
  my ($n, $iter) = @_;
  @p = @count = (1..$n);

  TRY: while (1) {
    print @p, "\n";
    return if ++$iter >= 30;
    for my $i (1 .. $n - 1) {
      splice @p, $i, 0, shift @p;
      next TRY if (--$count[$i]);
      $count[$i] = $i + 1;
    }
  }
}

my $n = shift || 7;

print30($n);

my @threads;
for my $i (1 .. $n) {
  push @threads, threads->create(\&fannkuch, $n, $i);
}

my $max = 0;
for my $thread (@threads) {
  my $val = $thread->join;
  $max = $val if $val > $max;
}
print "Pfannkuchen($n) = $max\n";
