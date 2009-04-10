<? 
/* 
   The Computer Language Benchmarks Game
   http://shootout.alioth.debian.org/

   contributed by Isaac Gouy
   multicore by anon
 */

function Fannkuch($n,$_i,$print){
   $check = 0;
   $perm = array();
   $perm1 = array();
   $count = array();
   $maxFlipsCount = 0;
   $m = $n - 1;

   $perm1 = range(0, $n-1);
   $r = $n;

   if (!$print) {
      $perm1[$_i] = $n - 1;
      $perm1[$n-1] = $_i;
   }

   while (TRUE) {
      // write-out the first 30 permutations
      if ($print){

         foreach($perm1 as $v) echo $v+1;
         echo "\n";
         if (++$check >= 30) {
            return Fannkuch($n, $_i, FALSE);
         }
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
         if ($r >= $m) return $maxFlipsCount;
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
function pipe() {
   // socketpair(2), alternative to pipe(2)
   return stream_socket_pair(STREAM_PF_UNIX, STREAM_SOCK_STREAM, 0);
}

$n = (int) $argv[1];

// fork() one process for each $n
$pipes = array();
for ($i = 1; $i < $n - 1; ++$i) {
   $pipe = pipe();
   $pipes[] = $pipe[0];
   $pipe = $pipe[1];
   $pid = pcntl_fork();
   if ($pid === -1) {
      die('could not fork');
   } else if ($pid) {
      continue;
   }
   $result = Fannkuch($n,$i,FALSE);
   fwrite($pipe, pack('N', $result));
   exit(0);
}

$result = Fannkuch($n,0,TRUE);

// gather & print result
foreach($pipes as $pipe) {
   $data = fread($pipe, 4);
   $data = unpack('N', $data);
   $data = $data[1];

   if ($data > $result) {
      $result = $data;
   }

   pcntl_wait($s);
}

printf("Pfannkuchen(%d) = %d\n", $n, $result);

