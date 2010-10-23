<?
/* The Computer Language Benchmarks Game
   http://shootout.alioth.debian.org/

   contributed by Sergey Khripunov
*/
function Fannkuch($n) {
    $a=range(1,$n);
    $c=array_fill(0,$n,$t=$s=1);
    $sum=$max=0;
    do {
        // flip
        $b=$a[$i=0];
        if ($s)
            $a[0]=$a[1];
        else
            do { $a[$i]=$a[$i+1]; } while (++$i<$t);
        $a[$t]=$b;

        if ($c[$t]++<$t+1) {
            if ($a[0]>$t=1) {
                // rotate
                $fl=1;$f=$a;
                while (1!==$f[$j=$f[$i=0]-1]) {
                    do { $b=$f[$i];$f[$i]=$f[$j];$f[$j]=$b; } while (++$i<--$j);
                    $fl++;
                }
                if ($fl>$max) $max=$fl;
                if ($s) $sum-=$fl; else $sum+=$fl;
            }
            $s=!$s;
        } else
            $c[$t++]=1;
    } while ($t<$n);
    printf("%d\nPfannkuchen(%d) = %d", $sum, $n, $max);
}

Fannkuch($argv[1]);
?>
