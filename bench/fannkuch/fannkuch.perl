#!/usr/bin/perl
# The Computer Language Shootout
# http://shootout.alioth.debian.org/
# Straightforward port of C version
# Contributed by Steve Clark
# Modified by Sokolov Yura

sub fannkuch {
    my $n = shift;
    my @p;
    my @q;
    my $tmp;
    my $maxflips = 0;
    my $flips;
    my @count;
    my $r = $n;
    my $first = 0;
    for ($i=0; $i < $n; $i++) { $p[$i] = 1 + $i; }

  BRK: for (;;) {

    	if ($first < 30){
    	    print @p,"\n";
    	    $first += 1;
    	}

        for (; $r != 1; $r--) { $count[$r-1] = $r; }

    	if ($p[0] != 1 && $p[$n-1] != $n-1) {

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

        PERM: for(;;){
            last BRK if ($r == $n);
            @p = (@p[1..$r],$p[0],@p[$r+1..@p-1]);
            last PERM if (($count[$r] -= 1)>0);
            $r += 1;
        }
    }

    return $maxflips;
}

my $NUM = $ARGV[0];
$NUM = 1 if ($NUM < 1);
print "Pfannkuchen($NUM) = ".fannkuch ($NUM)."\n";
