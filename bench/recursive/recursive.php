<? /* The Great Computer Language Shootout 
   http://shootout.alioth.debian.org/  
   contributed by Isaac Gouy 
*/

function ack($m, $n){
   return $m == 0 ? $n + 1 :
      ($n == 0 ? ack($m-1, 1) : ack($m-1, ack($m, $n-1)) ); }

function fib($n){ return ($n < 2) ? 1 : fib($n - 2) + fib($n - 1); }

function tak($x,$y,$z){
   return ($y<$x) ? tak( tak($x-1,$y,$z), tak($y-1,$z,$x), tak($z-1,$x,$y)) : $z; }

$n = $argv[1]; 
echo "Ack(3,$n): ", ack(3,$n),"\n";
printf("Fib(%.1f): %.1f\n", 28.0+$n, fib(28.0+$n));
$n--; printf("Tak(%d,%d,%d): %d\n", 3*$n,2*$n,$n, tak(3*$n,2*$n,$n));

printf("Fib(3): %d\n", fib(3));
printf("Tak(3.0,2.0,1.0): %.1f\n", tak(3.0,2.0,1.0));
?>
