#!/usr/bin/perl

# Straightforward port of C version
# Contributed by Steve Clark

sub fannkuch {
    my $n = shift;
    my @p;
    my @q;
    my $tmp;
    my $maxflips = 0;
    my $flips;

    for ($i=0; $i < $n; $i++) { $p[$i] = 1 + $i; }

  BRK: for (;;) {

    	if ($p[0] != 1) {

    	    @q = @p;

    	    for ($flips = 0; ($k = $q[0]) != 1; $flips++) {
    	    	for ($k--,$i=0; $i < $k; $i++, $k--) {
    	    	    $tmp = $q[$i];
    	    	    $q[$i] = $q[$k];
    	    	    $q[$k] = $tmp;
    	    	}
    	    }
    	    $maxflips = $flips if ($flips > $maxflips);
    	}

    	$k = $j = 0;
    	for ($i=1; $i < $n; $i++) {
    	    $j = $i if ($p[$i-1] < $p[$i]);
    	    $k = $i if ($j && $p[$i] > $p[$j-1]);
    	}
    	last BRK if (!$j);

    	$tmp = $p[$j-1];
    	$p[$j-1] = $p[$k];
    	$p[$k] = $tmp;

    	for ($i=$j,$j=$n-1; $i < $j; $i++, $j--) {
    	    $tmp = $p[$j];
    	    $p[$j] = $p[$i];
    	    $p[$i] = $tmp;
    	}
    }

    return $maxflips;
}

my $NUM = $ARGV[0];
$NUM = 1 if ($NUM < 1);
print "Pfannkuchen($NUM) = ".fannkuch ($NUM)."\n";
