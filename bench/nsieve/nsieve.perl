#!/usr/bin/perl -w

# 
# The Great Computer Language Shootout
# http://shootout.alioth.debian.org/
#
# Perl version of nseive benchmark
# written David Pyke, March 2005
# 

####################################################################################
sub nseive($)
{
	my ($m) = @_;
	my @a = ();

#	print "m = $m\n";

	my $count = 0;
	for (my $i = 2; $i < $m; $i++){
		if (!defined $a[$i] ) {
			for ($j = $i + $i; $j < $m; $j += $i){
				$a[$j] = 1;
			}
			$count++;
		}
	}
	return $count;
}

####################################################################################
sub nseive_test($)
{
	my($n) = @_;
#	print "n = $n\n";

	$m = 2**$n * 10000;

	my $ncount= nseive $m ;

	printf "Primes up to %8u %8u\n", $m, $ncount;
}
####################################################################################
#main
	my $N = ($ARGV[0] < 1) ? 1 : $ARGV[0];

	nseive_test $N ;

	nseive_test ($N-1)  if ($N >=1);
	nseive_test ($N-2)  if ($N >=2);
	exit;

#END OF FILE
