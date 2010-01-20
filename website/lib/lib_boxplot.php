<?php
// Copyright (c) Isaac Gouy 2010


function SelectedLangs($Langs, $Action, $Vars){
   $w = array(); $wd = array();
   foreach($Langs as $lang){
      $link = $lang[LANG_LINK];
      if (isset($Vars[$link])){ $w[$link] = 1; }
      if ($lang[LANG_SELECT]){ $wd[$link] = 1; }
   }
   if ($Action=='reset'||sizeof($w)<=0){ $w = $wd; }
   return $w;
}


// Data filtering and summary ///////////////////////////////////////////


function FullUnweightedData($FileName,$Tests,$Langs,$Incl,$Excl,$SLangs,$HasHeading=TRUE){

   return FullScores( $SLangs, FullRatios($FileName,$Tests,$Langs,$Incl,$Excl,$SLangs,$HasHeading) );
}

function FullRatios($FileName,$Tests,$Langs,$Incl,$Excl,$SLangs,$HasHeading=TRUE){
   $time_mins = array();
   foreach($Tests as $k => $v){ $time_mins[$k] = 360000.0; } // 100 hours
   $data = array();

   $lines = @file($FileName) or die ('Cannot open $FileName');
   if ($HasHeading){ unset($lines[0]); } // remove header line

   foreach($lines as $line) {
      $row = explode( ',', $line);
      $test = $row[DATA_TEST];
      $lang = $row[DATA_LANG];
      $key = $test.$lang.$row[DATA_ID];

      // accumulate all acceptable datarows, exclude duplicates
      if (isset($Incl[$test]) && isset($Incl[$lang]) && isset($Langs[$lang]) &&
                  !isset($Excl[$key])){

            settype($row[DATA_STATUS],'integer');
            settype($row[DATA_TIME],'double');
            $row_time = $row[DATA_TIME];

            if ($row[DATA_STATUS] == 0 && (
                  ($row_time > 0.0 && (!isset($data[$lang][$test]) ||
                     $row_time < $data[$lang][$test][DATA_TIME])))){

               $data[$lang][$test] = $row;

               if ($row_time < $time_mins[$test]){
                  $time_mins[$test] = $row_time;
               }
            }
      }
   }
   unset($lines);

   $ratios = array();
   foreach($data as $k => $test){
      if (sizeof($test)/sizeof($Tests) > 0.5){
         $s = array();
         foreach($test as $t => $row){
            // wait until now to filter so sizeof($test) is consistent with FullWeightedData
            if ($Tests[$t][TEST_WEIGHT]>0){
                  $s[] = $row[DATA_TIME]/$time_mins[$t];
            }
         }
         if (!empty($s)){ $ratios[$k] = $s; }
      }
   }
   return $ratios;
}


function FullScores($SLangs,$ratios){
  $score = array();
  foreach($ratios as $k => $s){
     $score[$k] = Percentiles($s);
  }
   uasort($score,'CompareMedian');

   $labels = array();
   $stats = array();
   $allowed = array();
   $count = 0; $max = 15;
   foreach($score as $k => $test){
      if (isset($SLangs[$k])){
         $labels[] = $k;
         $stats[] = $test;
         $allowed[$k] = 1;
         $count++;
      }
      if ($count == $max){ break; }
   }
   return array($score,$labels,$stats,$allowed);
}


function CompareMedian($a, $b){
   return ($a[STAT_MEDIAN] < $b[STAT_MEDIAN]) ? -1 :
      (($b[STAT_MEDIAN] < $a[STAT_MEDIAN]) ? 1 : 0);
}

function Percentiles($a){
   sort($a);
   $n = sizeof($a);
   $mid = floor($n / 2);
   if ($n % 2 != 0){
      $median = $a[$mid];
      $lower = Median( array_slice($a,0,$mid+1) ); // include median in both quartiles
      $upper = Median( array_slice($a,$mid) );
   } else {
      $median = ($a[$mid-1] + $a[$mid]) / 2.0;
      $lower = Median( array_slice($a,0,$mid) );
      $upper = Median( array_slice($a,$mid) );
   }
   $maxwhisker = ($upper - $lower) * 1.5;
   $xlower = ($lower - $maxwhisker < $a[0]) ? $a[0]: $lower - $maxwhisker;
   $xupper = ($upper + $maxwhisker > $a[$n-1]) ? $a[$n-1] : $upper + $maxwhisker;

   return array($a[0],$xlower,$lower,$median,$upper,$xupper,$a[$n-1],$n);
}

function Median($a){
   $n = sizeof($a);
   $mid = floor($n / 2);
   return ($n % 2 != 0) ? $a[$mid] : ($a[$mid-1] + $a[$mid]) / 2.0;
}


?>
