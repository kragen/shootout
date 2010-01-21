<?php
// Copyright (c) Isaac Gouy 2010


// FUNCTIONS ///////////////////////////////////////////////////

function BenchmarkData($FileName,$Test,$Langs,$Incl,$Excl,$Sort,$HasHeading=TRUE){
   $lines = @file($FileName) or die ('Cannot open $FileName');
   if ($HasHeading){ unset($lines[0]); } // remove header line

   $prefix = substr($Test,1).',';
   $succeeded = array();
   $failed = array();
   $special = array();

   $time_min = 360000.0; // 100 hours
   $mem_min = 1024000000;
   $DATA_TIME_SORT = $Sort=='fullcpu' ? DATA_FULLCPU : DATA_TIME;

   foreach($lines as $line) {
      if (strpos($line,$prefix)){
         $row = explode( ',', $line);
         $lang = $row[DATA_LANG];

         if (isset($Incl[$lang])){
            $exclude = $Excl[ $Test.$lang.$row[DATA_ID] ];
            if ($exclude[EXCL_USE]==EXCLUDED){
               continue;
            }

            settype($row[DATA_ID],'integer');
            settype($row[DATA_TESTVALUE],'integer');
            settype($row[DATA_GZ],'integer');
            settype($row[DATA_FULLCPU],'double');
            settype($row[DATA_MEMORY],'integer');
            settype($row[DATA_STATUS],'integer');
            settype($row[DATA_ELAPSED],'double');

            if ($exclude){
               $special[] = $row;
            } elseif ($row[DATA_STATUS]){
               $failed[] = $row;
            } else {
               $succeeded[] = $row;
               
               $row_time = $row[$DATA_TIME_SORT];
               if ($row_time > 0.0 && $row_time < $time_min){
                  $time_min = $row_time;
               }
               $row_mem = $row[DATA_MEMORY];
               if ($row_mem > 0 && $row_mem < $mem_min){
                  $mem_min = $row_mem;
               }

            }
         }
      }
   }
   
   if ($Sort=='fullcpu'){
      usort($succeeded, 'CompareFullCpuTime');
      usort($special, 'CompareFullCpuTime');
   } elseif ($Sort=='kb'){
      usort($succeeded, 'CompareMemoryUse');
      usort($special, 'CompareMemoryUse');
   } elseif ($Sort=='gz'){
      usort($succeeded, 'CompareGz');
      usort($special, 'CompareGz');
   } elseif ($Sort=='elapsed'){
      usort($succeeded, 'CompareElapsed');
      usort($special, 'CompareElapsed');
   }

   $time_ratios = array();
   $mem_ratios = array();
   
   if ($mem_min < 200){ $mem_min = 200; }
   settype($mem_min,'double');

   foreach($succeeded as $row){
      $row_time = $row[$DATA_TIME_SORT];
      $time_ratios[] = $row_time > 0.0 ? $row_time/$time_min : 1.0;
      $row_mem = $row[DATA_MEMORY];
      $mem_ratios[] = $row_mem > 200 ? $row_mem/$mem_min : 1.0;
   }

   return array($succeeded,$failed,$special,$time_ratios,$mem_ratios);
}


function CompareFullCpuTime($a, $b){
   return  ($a[DATA_FULLCPU] < $b[DATA_FULLCPU]) ? -1 :
      ($a[DATA_FULLCPU] > $b[DATA_FULLCPU] ? 1 : 0);
}

function CompareMemoryUse($a, $b){
   return  ($a[DATA_MEMORY] < $b[DATA_MEMORY]) ? -1 :
      ($a[DATA_MEMORY] > $b[DATA_MEMORY] ? 1 : 0);
}

function CompareGz($a, $b){
   return  ($a[DATA_GZ] < $b[DATA_GZ]) ? -1 :
      ($a[DATA_GZ] > $b[DATA_GZ] ? 1 : 0);
}

function CompareElapsed($a, $b){
   return  ($a[DATA_ELAPSED] < $b[DATA_ELAPSED]) ? -1 :
      ($a[DATA_ELAPSED] > $b[DATA_ELAPSED] ? 1 : 0);
}

?>
