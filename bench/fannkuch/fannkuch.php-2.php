<? 
/* The Computer Language Benchmarks Game
http://shootout.alioth.debian.org/
contributed by anon
 */


function Fannkuch($n){
   $check = 0;
   $perm = array();
   $perm1 = array();
   $count = array();
   $maxFlipsCount = 0;
   $m = $n - 1;

   $perm1 = range(0, $n-1);
   $r = $n;

   while (TRUE) {
      // write-out the first 30 permutations
      if ($check < 30){

         foreach($perm1 as $v) echo $v+1;
         echo "\n";
         $check++;
      }

      while ($r !== 1){
         $count[$r-1] = $r--;
      }
      if ($perm1[0] !== 0 && $perm1[$m] !== $m){
         $perm = $perm1;
         $flipsCount = 0;

         $k = $perm[0];
         do {
            $i = 1;
            $j = $k - 1;
            while ($i < $j) {
               $tmp = $perm[$i];
               $perm[$i++] = $perm[$j];
               $perm[$j--] = $tmp;
            }
            ++$flipsCount;
            $tmp = $perm[$k];
            $perm[$k] = $k;
         } while ($k = $tmp);

         if ($flipsCount > $maxFlipsCount) {
            $maxFlipsCount = $flipsCount;
         }
      }

      do {
         if ($r === $n) return $maxFlipsCount;
         $perm0 = $perm1[0];
         $i = 0;
         while ($i < $r) {
            $perm1[$i++] = $perm1[$i];
         }
         $perm1[$r] = $perm0;

         if (--$count[$r] > 0) break;
         ++$r;
      } while(TRUE);
   }
}

$n = (int) $argv[1];
printf("Pfannkuchen(%d) = %d\n", $n, Fannkuch($n));

