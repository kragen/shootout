<?php
// Copyright (c) Isaac Gouy 2005-2011


function Weights($Tests, $Action, $Vars){
   $w = array(); $wd = array();
   foreach($Tests as $t){
      $link = $t[TEST_LINK];

      if (isset($Vars[$link]) && (strlen($Vars[$link]) == 1)
            && (ereg("^[0-9]$",$Vars[$link]))){ $x = intval($Vars[$link]); }
      else { $x = intval($t[TEST_WEIGHT]); }

      $w[$link] = $x;
      $wd[$link] = intval($t[TEST_WEIGHT]);
   }


   $Metrics = array('xfullcpu' => 1, 'xmem' => 0, 'xloc' => 0);
   foreach($Metrics as $k => $v){

      if (isset($Vars[$k]) && (strlen($Vars[$k]) == 1)
            && (ereg("^[0-9]$",$Vars[$k]))){ $x = intval($Vars[$k]); }
      else { $x = $v; }

      $w[$k] = $x;
      $wd[$k] = $v;
   }

   if ($Action=='reset'){ $w = $wd; }

   // normalize weights
   $minWeight = 0;
   $maxWeight = 5;

   foreach($w as $k => $v){
      if ($v > $maxWeight){ $w[$k] = $maxWeight; }
      elseif ($v < $minWeight){ $w[$k] = $minWeight; }
   }
   return $w;
}


// Data filtering and summary ///////////////////////////////////////////

function ValidRowsAndMins($FileName,$Tests,$Langs,$Incl,$Excl,$HasHeading=TRUE){
   $mins = array();
   foreach($Tests as $k => $v){ $mins[$k] = array(); }
   $data = array();

   $lines = @file($FileName) or die ('Cannot open $FileName');
   if ($HasHeading){ unset($lines[0]); } // remove header line
   // expect to encounter more than one DATA_TESTVALUE for each test
   foreach($lines as $line) {
      $row = explode( ',', $line);
      if (!is_array($row)){ continue; }

      $test = $row[DATA_TEST];
      $lang = $row[DATA_LANG];
      settype($row[DATA_ID],'integer');
      settype($row[DATA_TESTVALUE],'integer');
      settype($row[DATA_GZ],'integer');
      settype($row[DATA_FULLCPU],'double');
      settype($row[DATA_MEMORY],'integer');
      settype($row[DATA_STATUS],'integer');
      settype($row[DATA_ELAPSED],'double');

      $id = $row[DATA_ID];
      $testvalue = $row[DATA_TESTVALUE];
      $key = $test.$lang.strval($id);

      // accumulate all acceptable datarows, exclude duplicates

      if (isset($Incl[$test]) && isset($Incl[$lang]) &&
               isset($Langs[$lang]) &&
                  !isset($Excl[$key])){

            if ($row[DATA_STATUS] == 0 && (
                  ($row[DATA_TIME] > 0 && (!isset($data[$lang][$test][$testvalue]) ||
                     $row[DATA_TIME] < $data[$lang][$test][$testvalue][DATA_TIME])))){

               $data[$lang][$test][$testvalue] = $row;
               
               if ($row[DATA_TIME] > 0.0){
                  if (!isset($mins[$test][$testvalue][CPU_MIN])){
                     $mins[$test][$testvalue][CPU_MIN] = $row[DATA_TIME];
                  } else {
                     if ($row[DATA_TIME] < $mins[$test][$testvalue][CPU_MIN]){
                        $mins[$test][$testvalue][CPU_MIN] = $row[DATA_TIME];
                     }
                  }
               }
               if ($row[DATA_MEMORY] > 0.0){
                  if (!isset($mins[$test][$testvalue][MEM_MIN])){
                     $mins[$test][$testvalue][MEM_MIN] = $row[DATA_MEMORY];
                  } else {
                     if ($row[DATA_MEMORY] < $mins[$test][$testvalue][MEM_MIN]){
                        $mins[$test][$testvalue][MEM_MIN] = $row[DATA_MEMORY];
                     }
                  }
               }
               if ($row[DATA_GZ] > 0.0){
                 if (!isset($mins[$test][$testvalue][GZ_MIN])){
                     $mins[$test][$testvalue][GZ_MIN] = $row[DATA_GZ];
                  } else {
                     if ($row[DATA_GZ] < $mins[$test][$testvalue][GZ_MIN]){
                        $mins[$test][$testvalue][GZ_MIN] = $row[DATA_GZ];
                     }
                  }
               }
            }

      }
   }
   return array($data,$mins);
}



function FullWeightedData($FileName,$Tests,$Langs,$Incl,$Excl,$W,$SLangs,$HasHeading=TRUE){
   list($data,$mins) = ValidRowsAndMins($FileName,$Tests,$Langs,$Incl,$Excl,$HasHeading);

   /*
   When there are multiple N values this doesn't seem quite right - we might
   have taken times from different programs for different N values for the
   same language implementation - but it's completely negligible.
   */

   $weightedTestsCount = 0;
   foreach($W as $k => $v){
      if ($v>0){ $weightedTestsCount++; }
   }

   $score = array();
   foreach($data as $k => $test){
      if ($weightedTestsCount>0 && (sizeof($test)/$weightedTestsCount > 0.5)){

         $s = 0.0; $ws = 0.0; $include = 0.0;
         foreach($test as $t => $testvalues){
            foreach($testvalues as $tv => $v){

               $w1 = $W[$t] * $W['xfullcpu'];
               $w2 = $W[$t] * $W['xmem'];
               $w3 = $W[$t] * $W['xloc'];

               if ($w1>0){
                 $val = $v[DATA_TIME];
                 if ($val > 0){
                    $s += log($val/$mins[$t][$tv][CPU_MIN])*$w1;
                    $ws += $w1;
                    $include += $val;
                 }
               }
               if ($w2>0){
                 $val = $v[DATA_MEMORY];
                 if ($val > 0){
                    $s += log($val/$mins[$t][$tv][MEM_MIN])*$w2;
                    $ws += $w2;
                    $include += $val;
                 }
               }
               if ($w3>0){
                 $val = $v[DATA_GZ];
                 if ($val > 0){
                    $s += log($val/$mins[$t][$tv][GZ_MIN])*$w3;
                    $ws += $w3;
                    $include += $val;
                 }
               }
            }
         }
         if ($ws == 0.0){ $ws = 1.0; }
         if ($include > 0){ $score[$k] = array(1.0,exp($s/$ws),$weightedTestsCount-sizeof($test)); }

      }
   }
   uasort($score, 'CompareMeanScore');

   $labels = array();
   $ratio = array();
   $allowed = array();
   $count = 0; $max = 15;
   foreach($score as $k => $v){
      if (!isset($first)){ $first = $v[SCORE_MEAN]; }
      if ($first==0){ $r = 0.0; } else { $r = $v[SCORE_MEAN]/$first; }
      $score[$k][SCORE_RATIO] = $r;

      if (isset($SLangs[$k])){
         $labels[] = $k;
         $ratio[] = $r;  
         $allowed[$k] = 1;
         $count++;
      }
      if ($count == $max){ break; }
   }
   return array($score,$labels,$ratio,$allowed);
}

function CompareMeanScore($a, $b){
   if ($a[SCORE_MEAN] == $b[SCORE_MEAN]) return 0;
   return  ($a[SCORE_MEAN] < $b[SCORE_MEAN]) ? -1 : 1;
}

// Formating ///////////////////////////////////////////

function PBlank($d){
   if ($d>0){ return number_format($d); }
   else { return "&nbsp;"; }
}


function MkDataSetMenu($DataSet){
   $dataSelected = "";
   $ndataSelected = "";
   if ($DataSet=='data'){ $dataSelected = 'selected="selected"'; }
   else { $ndataSelected = 'selected="selected"'; }

   echo '<select name="d">', "\n";
   printf('<option value="data" %s>data for largest N</option>',
      $dataSelected); echo "\n";
   printf('<option value="ndata" %s>full data - smaller and largest N</option>',
      $ndataSelected); echo "\n";
   echo '</select>', "\n";
}



?>
