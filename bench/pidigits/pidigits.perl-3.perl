# The Computer Language Shootout
#   http://shootout.alioth.debian.org/
#
#   contributed by Robert Bradshaw
#      modified by Ruud H.G.van Tol

use Math::BigInt lib => 'GMP';

$k = 0;
$z = [ Math::BigInt->new('1')
     , Math::BigInt->new('0')
     , Math::BigInt->new('1') ];

sub next_digit {
  while (0
       || ($z->[0] > $z->[2])
       || (($y = extract_digit(3)) != extract_digit(4))
        ) { # y not safe
    ++$k;
    compose([$k, 4*$k+2, 2*$k+1]);
  }
  compose([10, -10 * $y, 1], 1);
  return $y;
}

sub extract_digit {
  return scalar int( ($z->[0] * $_[0] + $z->[1]) / $z->[2] );
}

sub compose {
  $z->[1] = defined($_[1]) ? $_[0]->[0] * $z->[1] + $_[0]->[1] * $z->[2]
                           : $_[0]->[1] * $z->[0] + $_[0]->[2] * $z->[1];
  $z->[0]->bmul($_[0]->[0]);
  $z->[2]->bmul($_[0]->[2]);
  return;
}

# main loop

$n = $ARGV[0];

{ local ($,, $\) = ("\t", "\n");

  for $i (1..$n) {
    $s .= next_digit();
    if ($i % 10 == 0) {  print $s, ":$i"; undef($s)}
  }
  if ($i = $n % 10) {
    $s .= '.'x(10-$i);
  }
  print $s, ":$n" if $s;
}
