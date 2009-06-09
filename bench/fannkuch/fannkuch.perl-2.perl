# The Computer Language Benchmarks Game
# http://shootout.alioth.debian.org/
# Initial port from C by Steve Clark
# Rewrite by Kalev Soikonen
# Modified by Kuang-che Wu
# Modified by David Golden

use integer;

sub fannkuch {
    my ($n) = shift;
    my ($iter, $flips, $maxflips, $i);
    my ($q, $f, $p, @count);

    $iter = $maxflips = 0;
    @count = (1..$n); 
    $p = pack "c*", @count;
    my $m = $n - 1;

    TRY: {
        if ($iter < 30) {
            print join("", unpack("c*",$p)) . "\n";
            $iter++;
        }

        if (ord(substr($p,0)) != 1 && ord(substr($p,$m)) != $n) {
            $q = $p;
            $flips=0;
            while ( ($f = ord(substr($q,0))) != 1 ) {
                $flips++;
                substr( $q, 0, $f, reverse( substr($q,0,$f) ) );
            }
            $maxflips = $flips if ($flips > $maxflips);
        }

        for my$i(1..$m) {
            substr $p, $i, 0, (substr($p,0,1,""));
            redo TRY if (--$count[$i]);
            $count[$i] = $i + 1;
        }
        return $maxflips;
    }
}

for (shift || 7) {
    print "Pfannkuchen($_) = ".fannkuch($_)."\n";
}
