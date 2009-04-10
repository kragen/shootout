<?
/* 
   The Computer Language Benchmarks Game
   http://shootout.alioth.debian.org/

   contributed by Danny Sauer
   modified by Josh Goldfoot
   multicore by anon
 */

# regexp matches

#ini_set("memory_limit","40M");

function getProcs() {
   $procs = 1;
   if (file_exists('/proc/cpuinfo')) {
      $procs = preg_match_all('/^processor\s/m', file_get_contents('/proc/cpuinfo'), $discard);
   }
   $procs <<= 1;
   return $procs;
}

function count_matches(&$contents, &$variants) {
   $results = array();
   foreach($variants as $regex) {
      $discard = array();
      $results[$regex] = preg_match_all("/$regex/", $contents, $discard);
   }
   return $results;
}

$variants = array(
   'agggtaaa|tttaccct',
   '[cgt]gggtaaa|tttaccc[acg]',
   'a[act]ggtaaa|tttacc[agt]t',
   'ag[act]gtaaa|tttac[agt]ct',
   'agg[act]taaa|ttta[agt]cct',
   'aggg[acg]aaa|ttt[cgt]ccct',
   'agggt[cgt]aa|tt[acg]accct',
   'agggta[cgt]a|t[acg]taccct',
   'agggtaa[cgt]|[acg]ttaccct',
);

# IUB replacement parallel arrays
$IUB = array(); $IUBnew = array();
$IUB[]='/B/';     $IUBnew[]='(c|g|t)';
$IUB[]='/D/';     $IUBnew[]='(a|g|t)';
$IUB[]='/H/';     $IUBnew[]='(a|c|t)';
$IUB[]='/K/';     $IUBnew[]='(g|t)';
$IUB[]='/M/';     $IUBnew[]='(a|c)';
$IUB[]='/N/';     $IUBnew[]='(a|c|g|t)';
$IUB[]='/R/';     $IUBnew[]='(a|g)';
$IUB[]='/S/';     $IUBnew[]='(c|g)';
$IUB[]='/V/';     $IUBnew[]='(a|c|g)';
$IUB[]='/W/';     $IUBnew[]='(a|t)';
$IUB[]='/Y/';     $IUBnew[]='(c|t)';

# sequence descriptions start with > and comments start with ;
#my $stuffToRemove = '^[>;].*$|[\r\n]';
$stuffToRemove = '^>.*$|\n'; # no comments, *nix-format test file...

# read in file
$contents = file_get_contents('php://stdin');
$initialLength = strlen($contents);

# remove things
$contents = preg_replace("/$stuffToRemove/m", '', $contents);
$codeLength = strlen($contents);

# do regexp counts

// queue jobs
$tok = ftok(__FILE__, chr(time() & 255));
$queue = msg_get_queue($tok);
foreach ($variants as $id => $variant) {
   $errcode = 0;
   if (!msg_send($queue, 1, (string) $id, FALSE, FALSE, $errcode)) {
      if ($errcode == MSG_EAGAIN) {
         echo "EAGAIN\n";
      }
      var_dump(msg_stat_queue($queue));
      exit(1);
   }
}

// # of processes to run
$procs = getProcs();
if ($procs > count($variants)) {
   $procs = count($variants);
}

// create proceses
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
while (msg_receive($queue, 1, $msgtype, 16, $variant_id, FALSE, MSG_IPC_NOWAIT)) {

   $regex = $variants[$variant_id];
   $result = array($variant_id, preg_match_all("/$regex/i", $contents, $discard));
   msg_send($queue, 2, $result, TRUE);
}

if (!$parent) {
   exit(0);
}

// gather & output results
$results = array();
foreach($variants as $variant) {
   msg_receive($queue, 2, $msgtype, 4096, $result, TRUE);
   $results[$result[0]] = $result[1];
}
ksort($results);

foreach($results as $variant_id => $result) {
   echo $variants[$variant_id] . ' ' . $result . "\n";
}

while (--$procs) {
   pcntl_wait($s);
}

msg_remove_queue($queue);

# do replacements
$contents = preg_replace($IUB, $IUBnew, $contents);

print "\n" .
   $initialLength . "\n" .
   $codeLength . "\n" .
   strlen($contents) . "\n" ;

