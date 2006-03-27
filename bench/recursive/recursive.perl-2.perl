# The Computer Language Shootout
# http://shootout.alioth.debian.org/
# recursive test, by Justin Ossevoort, Mar 27 2006

sub Ack { my ($x, $y) = @_;     return $x ? ($y ? Ack($x - 1, Ack($x, $y - 1)) : Ack($x - 1, 1)) : $y + 1;                      }
sub Fib { my ($n) = @_;         return $n < 2 ? 1 : Fib($n - 2) + Fib($n - 1);                                                  } 
sub Tak { my ($x, $y, $z) = @_; return $y < $x ? Tak(Tak($x - 1.0, $y, $z), Tak($y - 1.0, $z, $x), Tak($z - 1.0, $x, $y)) : $z; }

my $n = $ARGV[0]; printf "Ack(3,%d): %d\nFib(%.1f): %.1f\nTak(%d,%d,%d): %d\nFib(3): %d\nTak(3.0,2.0,1.0): %.1f\n", $n + 1, Ack(3, $n+1), 28.0 + $n, Fib(28.0 + $n), $n * 3, $n * 2, $n, Tak($n * 3, $n * 2, $n), Fib(3), Tak(3.0, 2.0, 1.0);
