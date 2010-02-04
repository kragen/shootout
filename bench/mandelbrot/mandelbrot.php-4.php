<?php
/* The Computer Language Benchmarks Game
   http://shootout.alioth.debian.org/
   contributed by Thomas GODART (based on Greg Buchholz's C program) 
   modified by Vincent NEGRIER (parallel workers) */

function compute_data($y_start, $y_end) 
{
   global $w, $h, $iter, $limit2;
   
   for ($y = $y_start ; $y < $y_end ; ++$y)
   {
      for ($x = 0 ; $x < $w ; ++$x)
      {
         $Zr = $Zi = $Tr = 0; $Ti = 0.0;

         $Cr = (2.0 * $x / $w - 1.5); $Ci = (2.0 * $y / $h - 1.0);

         for ($i = 0 ; $i < $iter and ($Tr + $Ti <= $limit2) ; ++$i)
         {
            $Zi = 2.0 * $Zr * $Zi + $Ci;
            $Zr = $Tr - $Ti + $Cr;
            $Tr = $Zr * $Zr;
            $Ti = $Zi * $Zi;
         }

         $byte_acc = $byte_acc << 1;
         if ($Tr + $Ti <= $limit2) $byte_acc = $byte_acc | 1;

         ++$bit_num;

         if ($bit_num === 8)
         {
            $out_buf .= chr ($byte_acc);
            $byte_acc = $bit_num = 0;
         }
         else if ($x === $w - 1)
         {
            $byte_acc = $byte_acc << (8 - $w % 8);
            $out_buf .= chr ($byte_acc);
            $byte_acc = $bit_num = 0;
         }
      }
   }
   return $out_buf;
}

function worker_exit()
{
   global $data;

   echo $data;
   exit(0);
}

function master_wait()
{
   global $n_workers, $workers;

   if (!--$n_workers)
   {
      foreach ($workers as $pid)
      {
         posix_kill($pid, SIGUSR1);
         pcntl_waitpid($pid, $status);
      }
      exit(0);
   }
}

$n_workers = 8;
$workers = array();
$m_pid = posix_getpid();
$w = 0; $h = 0; $bit_num = 0;
$byte_acc = 0;
$i = 0; $iter = 50;
$x = 0; $y = 0; $limit2 = 4;
$Zr = 0; $Zi = 0; $Cr = 0; $Ci = 0; $Tr = 0; $Ti = 0;

@$h = ($argc == 2) ? $argv[1] : 600;
$w = $h;
$worker_block = $w / $n_workers;

printf ("P4\n%d %d\n", $w, $h);

$out_buf = "";

for ($a = 0; $a < $n_workers; $a++) 
{
   $pid = pcntl_fork();

   if ($pid === 0)
   {
      $data = compute_data($a * $worker_block, (($a + 1) * $worker_block));
      pcntl_signal(SIGUSR1, "worker_exit");
      posix_kill($m_pid, SIGUSR1);
      declare (ticks=1)
      {
         while (true) sleep(1);
      }
   } 
   else
   {
      $workers[] = $pid;
   }
}

pcntl_signal(SIGUSR1, "master_wait");

declare (ticks=1)
{
   while (true) sleep(1);
}

?>
