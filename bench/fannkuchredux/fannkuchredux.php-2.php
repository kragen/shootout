<? /* The Computer Language Benchmarks Game
   http://shootout.alioth.debian.org/
   
   contributed by Isaac Gouy
*/

function Fannkuch($n){
   $check = 0;
   $perm = array();
   $perm1 = array();
   $count = array();
   $maxPerm = array();
   $maxFlipsCount = 0;
   $m = $n - 1;
   $permCount = 0;
   $checksum = 0;

   for ($i=0; $i<$n; $i++) $perm1[$i] = $i;
   $r = $n;

   while (TRUE) {

      while ($r != 1){ $count[$r-1] = $r; $r--; } 
       
      for($i=0; $i<$n; $i++) $perm[$i] = $perm1[$i]; 
      $flipsCount = 0;

      while ( !(($k=$perm[0]) == 0) ) {
         $k2 = ($k+1) >> 1;
         for($i=0; $i<$k2; $i++) {
            $temp = $perm[$i]; $perm[$i] = $perm[$k-$i]; $perm[$k-$i] = $temp;
         }
         $flipsCount++;
      }

      if ($flipsCount > $maxFlipsCount) {
         $maxFlipsCount = $flipsCount;
         for($i=0; $i<$n; $i++) $maxPerm[$i] = $perm1[$i];
      }

      $checksum += ($permCount % 2 == 0) ? $flipsCount : -$flipsCount;  
 

      while (TRUE) {        
         if ($r == $n){
            echo $checksum, "\n";
            return $maxFlipsCount;
         }
         $perm0 = $perm1[0];
         $i = 0;
         while ($i < $r) {
            $j = $i + 1;
            $perm1[$i] = $perm1[$j];
            $i = $j;
         }
         $perm1[$r] = $perm0;

         $count[$r] = $count[$r] - 1;
         if ($count[$r] > 0) break;
         $r++;
      }

      $permCount++;
      if ($permCount == 1048576){ $permCount = 0; }

   }
}

$n = $argv[1];
printf("Pfannkuchen(%d) = %d", $n, Fannkuch($n));
?>

