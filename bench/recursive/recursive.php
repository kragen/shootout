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
$m = $n+4; 
echo "Ack(3,$m): ", ack(3,$m),"\n";

$m = $n+9; 
echo "Fib($m): ", fib($m),"\n";
$m = $n+32; 
printf("Fib(%d): %.1f\n", $m, fib($m*1.0));

printf("Tak(%d,%d,%d): %d\n", $n*3,$n*2,$n, tak($n*3,$n*2,$n));
$m = $n+2;
printf("Tak(%d,%d,%d): %.1f\n", $m*3,$m*2,$m, tak($m*3.0,$m*2.0,$m*1.0));
?>
