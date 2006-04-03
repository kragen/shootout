# The Computer Language Shootout
# http://shootout.alioth.debian.org/
# recursive test, by Justin Ossevoort, Apr 03 2006

# This is the nice-"perlish" version

### Don't use warnings because at N=4 the Ack() method will
### start complaining about deep recursion (though it'll still
### function as expected)

use strict;
# use warnings;

sub Ack
{
	my ($x, $y) = @_;

	return $y + 1         if $x == 0;
	return Ack($x - 1, 1) if $y == 0;

	return Ack($x - 1, Ack($x, $y - 1));
}

sub Fib
{
	my ($n) = @_;

	return 1 if $n < 2;

	return Fib($n - 2) + Fib($n - 1);
}

sub Tak
{
	my ($x, $y, $z) = @_;

	return Tak(Tak($x - 1.0, $y, $z), Tak($y - 1.0, $z, $x), Tak($z - 1.0, $x, $y)) if $y < $x;

	return $z;
}

my $n = ($ARGV[0] || 0);
printf "Ack(%d,%d): %d\nFib(%.1f): %.1f\nTak(%d,%d,%d): %d\nFib(%d): %d\nTak(%.1f,%.1f,%.1f): %.1f\n",
	3, $n, Ack(3, $n),
	27.0 + $n, Fib(27.0 + $n--),
	$n * 3, $n * 2, $n, Tak($n * 3, $n * 2, $n),
	3, Fib(3),
	3.0, 2.0, 1.0, Tak(3.0, 2.0, 1.0)
	;
