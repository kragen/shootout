<?php
// Copyright (c) Isaac Gouy 2005-2009


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

function ValidRowsAndMins($FileName,&$Tests,&$Langs,&$Incl,&$Excl,$HasHeading=TRUE){
   // expect to encounter more than one DATA_TESTVALUE for each test
   $f = @fopen($FileName,'r') or die ('Cannot open $FileName');
   if ($HasHeading){ $row = @fgetcsv($f,1024,','); }

   $mins = array();
   foreach($Tests as $k => $v){ $mins[$k] = array(); }

   $data = array();

   while (!@feof ($f)){
      $row = @fgetcsv($f,1024,',');
      if (!is_array($row)){ continue; }

      $test = $row[DATA_TEST];
      $lang = $row[DATA_LANG];
      settype($row[DATA_ID],'integer');
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
   @fclose($f);
   return array($data,$mins);
}



function FullWeightedData($FileName,&$Tests,&$Langs,&$Incl,&$Excl,&$W,$HasHeading=TRUE){
   list($data,$mins) = ValidRowsAndMins($FileName,$Tests,$Langs,$Incl,$Excl,$HasHeading);

   /*
   When there are multiple N values this doesn't seem quite right - we might
   have taken times from different programs for different N values for the
   same language implementation - but it's completely negligible.
   */

   $score = array();
   foreach($data as $k => $test){
      if (sizeof($test)/sizeof($Tests) > 0.5){

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
         if ($include > 0){ $score[$k] = array(1.0,exp($s/$ws),sizeof($Tests)-sizeof($test)); }

      }
   }
   uasort($score, 'CompareMeanScore');
   $ratio = array();
   foreach($score as $k => $v){
      if (!isset($first)){ $first = $v[SCORE_MEAN]; }
      if ($first==0){ $r = 0.0; } else { $r = $v[SCORE_MEAN]/$first; }
      $score[$k][SCORE_RATIO] = $r;
      $ratio[] = $r;   // for chart
   }

   return array($score,$ratio);
}



function TimeSizeShapes($FileName,&$Tests,&$Langs,&$Incl,&$Excl,$HasHeading=TRUE){
   list($data,$mins) = ValidRowsAndMins($FileName,$Tests,$Langs,$Incl,$Excl,$HasHeading);

   /*
   When there are multiple N values this doesn't seem quite right - we might
   have taken times from different programs for different N values for the
   same language implementation - but it's completely negligible.
   */

   $shapes = array(); $medians = array(); $include = 0;

   foreach($data as $k => $test){
      // javasteady source code includes an extra loop
      if ((sizeof($test)/sizeof($Tests) > 0.5) && $k != 'javasteady'){

         $points = array(); $xs = array(); $ys = array();
         unset($minpoint);
         foreach($test as $t => $testvalues){

            // wait until now to filter so sizeof($test) is consistent with FullWeightedData
            if ($Tests[$t][TEST_WEIGHT]>0){

               // normalized source code size on X, normalized measured time on Y
               foreach($testvalues as $tv => $v){
                  $x = $v[DATA_GZ]/$mins[$t][$tv][GZ_MIN];
                  $y = $v[DATA_TIME]/$mins[$t][$tv][CPU_MIN];

                  if ($v[DATA_TIME] > 0){
                     $points[] = array($x,$y);
                     $xs[] = $x; // collect for k-median
                     $ys[] = $y; // collect for k-median
                     $include++;
                  }
               }
            }
         }

         if ($include > 0){
            $shapes[$k] = $points;
            sort($xs);
            $xm = Median($xs);
            sort($ys);
            $ym = Median($ys);
            $medians[$k] = array($xm,$ym); // k-median
         }
      }
   }
   return array($shapes,$medians);
}



function FullUnweightedData($FileName,&$Tests,&$Langs,&$Incl,&$Excl,&$SLangs,$HasHeading=TRUE){
   // expect to encounter more than one DATA_TESTVALUE for each test
   $f = @fopen($FileName,'r') or die ('Cannot open $FileName');
   if ($HasHeading){ $row = @fgetcsv($f,1024,','); }

   $mins = array();
   foreach($Tests as $k => $v){ $mins[$k] = array(); }

   $data = array();
   //$timeout = array();
   while (!@feof ($f)){
      $row = @fgetcsv($f,1024,',');
      if (!is_array($row)){ continue; }

      $test = $row[DATA_TEST];
      $lang = $row[DATA_LANG];
      settype($row[DATA_ID],'integer');
      $id = $row[DATA_ID];
      $testvalue = $row[DATA_TESTVALUE];
      $key = $test.$lang.strval($id);

      // accumulate all acceptable datarows, exclude duplicates

      if (isset($Incl[$test]) && isset($Incl[$lang]) && isset($Langs[$lang]) &&
                  !isset($Excl[$key])){

            if ($row[DATA_STATUS] == 0 && (
                  ($row[DATA_TIME] > 0 && (!isset($data[$lang][$test][$testvalue]) ||
                     $row[DATA_TIME] < $data[$lang][$test][$testvalue][DATA_TIME])))){

               $data[$lang][$test][$testvalue] = $row;

               if (!isset($mins[$test][$testvalue])){
                  $mins[$test][$testvalue] = $row[DATA_TIME];
               } else {
                  if ($row[DATA_TIME] < $mins[$test][$testvalue]){
                     $mins[$test][$testvalue] = $row[DATA_TIME];
                  }
               }
            }
      }
   }
   @fclose($f);

   
   /*
   When there are multiple N values this doesn't seem quite right - we might
   have taken times from different programs for different N values for the
   same language implementation - but it's completely negligible.
   */

   $score = array();
   foreach($data as $k => $test){
      if (sizeof($test)/sizeof($Tests) > 0.5){

         $s = array(); $include = 0.0;
         foreach($test as $t => $testvalues){

            // wait until now to filter so sizeof($test) is consistent with FullWeightedData
            if ($Tests[$t][TEST_WEIGHT]>0){

               foreach($testvalues as $tv => $v){
                  $val = $v[DATA_TIME];
                  if ($val > 0){
                     $s[] = $val/$mins[$t][$tv];
                     $include += $val;
                  }
               }
            }
         }
         if ($include > 0){ $score[$k] = Percentiles($s); }
      }
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


function CompareMeanScore($a, $b){
   if ($a[SCORE_MEAN] == $b[SCORE_MEAN]) return 0;
   return  ($a[SCORE_MEAN] < $b[SCORE_MEAN]) ? -1 : 1;
}

function CompareMedian($a, $b){
   if ($a[STAT_MEDIAN] == $b[STAT_MEDIAN]) return 0;
   return  ($a[STAT_MEDIAN] < $b[STAT_MEDIAN]) ? -1 : 1;
}

function CompareTheta($a, $b){
   if ($a[2] == $b[2]) return 0;
   return  ($a[2] < $b[2]) ? -1 : 1;
}

function DataRows($FileName,&$Tests,&$Langs,&$Incl,&$Excl,$HasHeading=TRUE){
   // expect to encounter more than one DATA_TESTVALUE for each test
   $f = @fopen($FileName,'r') or die ('Cannot open $FileName');
   if ($HasHeading){ $row = @fgetcsv($f,1024,','); }

   $data = array();
   //$timeout = array();
   while (!@feof ($f)){
      $row = @fgetcsv($f,1024,',');
      if (!is_array($row)){ continue; }

      $test = $row[DATA_TEST];
      $lang = $row[DATA_LANG];
      settype($row[DATA_ID],'integer');
      $id = $row[DATA_ID];
      $testvalue = $row[DATA_TESTVALUE];
      $key = $test.$lang.strval($id);

      // accumulate all acceptable datarows, exclude duplicates

      if (isset($Incl[$test]) && isset($Incl[$lang]) && isset($Langs[$lang]) &&
                  !isset($Excl[$key])){

            if ($row[DATA_STATUS] == 0 && (
                  ($row[DATA_TIME] > 0 && (!isset($data[$lang][$test][$testvalue]) ||
                     $row[DATA_TIME] < $data[$lang][$test][$testvalue][DATA_TIME])))){

               $data[$lang][$test][$testvalue] = $row;
            }

      }
   }
   @fclose($f);


   $rows = array();
   foreach($data as $k => $test){
      foreach($test as $t => $testvalues){

         // wait until now to filter so sizeof($test) is consistent with FullWeightedData
         //if ($Tests[$t][TEST_WEIGHT]>0){

            foreach($testvalues as $tv => $v){
               $v[N_TEST] = $Tests[ $v[N_TEST] ][TEST_NAME];
               $v[N_LANG] = $Langs[ $v[N_LANG] ][LANG_FULL];
               $rows[] = $v;
            }
      }
   }
   return $rows;
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
