# The Great Computer Language Shootout
#   http://shootout.alioth.debian.org/
#
#   contributed by Robert Bradshaw


use Math::BigInt;


$k = 0;
$z = [Math::BigInt->new(1), Math::BigInt->new(0), Math::BigInt->new(0), Math::BigInt->new(1)];

sub next_digit {
  while (($y = extract_digit(3)) != extract_digit(4)) { # y not safe
    consume(next_lft());
  }
  produce($y);
  return $y;
}

sub next_lft {
  $k++;
  return [$k, 4*$k+2, 0, 2*$k+1];
}

sub extract_digit {
  my ($x) = @_;
  return int( ($z->[0] * $x + $z->[1]) / ( $z->[2] * $x + $z->[3]) );
}

sub produce {
  $z = compose([10, -10*shift(@_), 0, 1], $z);
}

sub consume {
  $z = compose($z, shift(@_));
}

sub compose {
  my ($z, $w) = @_;
  return [ $z->[0] * $w->[0] + $z->[1] * $w->[2], 
           $z->[0] * $w->[1] + $z->[1] * $w->[3],
           $z->[2] * $w->[0] + $z->[3] * $w->[2],
           $z->[2] * $w->[1] + $z->[3] * $w->[3] ];
}


# main loop

$n = $ARGV[0];

for($i=1; $i<=$n; $i++) {
  print next_digit();
  if ($i % 10 == 0) {  print "\t:$i\n";  }
}
if ($n % 10 != 0) {
  for($j=$n % 10; $j<=10; $j++) {  print " ";  }
  print "\t:$n\n";
}
