<? /* The Great Computer Language Shootout 
   http://shootout.alioth.debian.org/  
   contributed by Isaac Gouy 
*/

function ack($m, $n){
  if($m == 0) return $n+1;
  if($n == 0) return ack($m-1, 1);
  return ack($m - 1, ack($m, ($n - 1)));
}

function fib($n){ return ($n < 2) ? 1 : fib($n - 2) + fib($n - 1); }

function tak($x,$y,$z){
   return ($y<$x) ? tak( tak($x-1,$y,$z), tak($y-1,$z,$x), tak($z-1,$x,$y)) : $z; }


$n = $argv[1];
echo "Ack(3,$n): ", ack(3,$n),"\n";

$m = $n*4; echo "Fib($m): ", fib($m),"\n";
$m = $n+2; printf("Tak(%d,%d,%d): %d\n", $m*3,$m*2,$m, tak($m*3,$m*2,$m));

$m = $n*5; printf("Fib(%d): %.1f\n", $m, fib($m*1.0));
$m = $n+2; printf("Tak(%d,%d,%d): %.1f\n", $m*3,$m*2,$m, tak($m*3.0,$m*2.0,$m*1.0));
?>