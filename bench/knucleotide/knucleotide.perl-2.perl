# The Computer Language Shootout
# http://shootout.alioth.debian.org/
# k-nucleotide count benchmark
# contributed by Joel Hoffman, 2005-03-24

# speeded up and shortened by Kjetil Skotheim, 2005-11-29


use List::Util 'sum';

my @n=qw<GGT GGTA GGTATT GGTATTTTAATT GGTATTTTAATTTATAGT>;

$/ = ">"; # Input Separator
/^THREE/i and $seq = uc(join "", grep !/^(?:;|THREE)/, split /\n+/) while <>;

for my $n (1, 2, map length,@n) {
  my %h;
  $h{substr($seq,$_,$n)}++ for 0..length($seq)-$n;
  $keys[$n]=\%h;
}

for my $k (@keys[1,2]) {
    my $sum = sum values %$k;

    printf "$_ %4.3f\n", 100 * $$k{$_} / $sum
      for sort { $$k{$b} <=> $$k{$a} or $a cmp $b } keys %$k;

    print "\n";
}

printf "%d\t%s\n", $keys[length]{$_}, $_ for @n;
