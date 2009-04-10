<?
/* 
   The Computer Language Benchmarks Game
   http://shootout.alioth.debian.org/

   contributed by Peter Baltruschat
   multicore by anon
 */

function bottomUpTree($item, $depth)
{
   if($depth)
   {
      --$depth;
      $newItem = $item<<1;
      return array(
         bottomUpTree($newItem - 1, $depth),
         bottomUpTree($newItem, $depth),
         $item
      );
   }
   return array(NULL, NULL, $item);
}

function itemCheck($treeNode)
{
   $check = 0;
   do {
      $check += $treeNode[2];
      if(NULL == $treeNode[0])
      {
         return $check;
      }
      $check -= itemCheck($treeNode[1]);
      $treeNode = $treeNode[0];
   }
   while(TRUE);
}

function getProcs() {
   $procs = 1;
   if (file_exists('/proc/cpuinfo')) {
      $procs = preg_match_all('/^processor\s/m', file_get_contents('/proc/cpuinfo'), $discard);
   }
   $procs <<= 1;
   return $procs;
}

$minDepth = 4;

$n = ($argc == 2) ? $argv[1] : 1;
$maxDepth = max($minDepth + 2, $n);
$stretchDepth = $maxDepth + 1;

$stretchTree = bottomUpTree(0, $stretchDepth);
printf("stretch tree of depth %d\t check: %d\n",
   $stretchDepth, itemCheck($stretchTree));
unset($stretchTree);

$longLivedTree = bottomUpTree(0, $maxDepth);

// # of processes to run
$procs = getProcs();
if ($procs > (($maxDepth - $minDepth + 2) >> 1)) {
   $procs = ($maxDepth - $minDepth + 2) >> 1;
}

// queue jobs
$tok = ftok(__FILE__, chr(time() & 255));
$queue = msg_get_queue($tok);
for ($d = $minDepth; $d <= $maxDepth; $d+=2) {
   $errcode = 0;
   if (!msg_send($queue, 1, (string) $d, FALSE, FALSE, $errcode)) {
      if ($errcode == MSG_EAGAIN) {
         echo "EAGAIN\n";
      }
      var_dump(msg_stat_queue($queue));
      exit(1);
   }
}

// create processes
$parent = TRUE;
for ($i = 1; $i < $procs; ++$i) {
   $pid = pcntl_fork();
   if ($pid === -1) {
      die('could not fork');
   } else if ($pid) {
      continue;
   }
   $parent = FALSE;
   break;
}

// run jobs
ob_start();

$d = 0;
while (msg_receive($queue, 1, $msgtype, 16, $d, FALSE, MSG_IPC_NOWAIT)) {
   $d = (int) $d;
   $iterations = 1 << ($maxDepth - $d + $minDepth);
   $check = 0;
   for($i = 1; $i <= $iterations; ++$i)
   {
      $t = bottomUpTree($i, $d);
      $check += itemCheck($t);
      unset($t);
      $t = bottomUpTree(-$i, $d);
      $check += itemCheck($t);
      unset($t);
   }

   printf("%d\t trees of depth %d\t check: %d\n",
      $iterations<<1, $d, $check);

}

if (!$parent) {
   msg_send($queue, 2, ob_get_clean(), FALSE);
   exit(0);
}

// gather & output results
$s = 0;
$output = array(explode("\n", ob_get_clean()));
for ($i = 1; $i < $procs; ++$i) {
   msg_receive($queue, 2, $msgtype, 4096, $o, FALSE);
   $output[] = explode("\n", $o);
   pcntl_wait($s);
}

msg_remove_queue($queue);

$output = call_user_func_array('array_merge', $output);
$output = array_filter($output, 'strlen');
rsort($output, SORT_NUMERIC);
echo implode("\n", $output), "\n";

printf("long lived tree of depth %d\t check: %d\n",
   $maxDepth, itemCheck($longLivedTree));

