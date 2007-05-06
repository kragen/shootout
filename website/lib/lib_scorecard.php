<?php
// Copyright (c) Isaac Gouy 2005-2007

// FUNCTIONS ///////////////////////////////////////////////////

function PackCSV($a){
   $s = "";
   foreach($a as $k => $v){ $s .= $k.','.$v.','; }
   return substr($s,0,-1);
}

function UnpackCSV($csv){
   $aa = array();
   if (is_string($csv)){   
      $s = substr($csv,0,1024); // be defensive, limit acceptable length

      $a = explode(',',$s);
      $i = 0;
      while ($i<sizeof($a)-1){
         $k = $a[$i]; $v = $a[$i+1];
         if (is_string($k) && is_numeric($v)){
            $k = substr($k,0,64); // be defensive, limit acceptable length
            $aa[$k] = $v;
         }
         $i += 2;    
      }
   }
   return $aa;
}

function ScoreData($FileName,&$Tests,&$Langs,&$Incl,&$Excl,$HasHeading=TRUE){
   $f = @fopen($FileName,'r') or die ('Cannot open $FileName');
   if ($HasHeading){ $row = @fgetcsv($f,1024,','); }

   $mins = array();
   foreach($Tests as $k => $v){ $mins[$k] = array(1000000,1000000,1000000); }

   $data = array();
   while (!@feof ($f)){
      $row = @fgetcsv($f,1024,',');
      if (!is_array($row)){ continue; }

      $test = $row[DATA_TEST];
      $lang = $row[DATA_LANG];
      settype($row[DATA_ID],'integer');
      $id = $row[DATA_ID];
      $key = $test.$lang.strval($id);

      // accumulate all acceptable datarows, exclude duplicates

      if (isset($Incl[$test]) && isset($Incl[$lang]) &&
            $row[DATA_FULLCPU] > 0 &&
               isset($Langs[$lang]) &&
                  !isset($Excl[$key])){

            if (!isset($data[$lang][$test]) ||
                  $row[DATA_FULLCPU] < $data[$lang][$test][DATA_FULLCPU]){

               $data[$lang][$test] = $row;

               $mt = &$mins[$test];
               if ($row[DATA_FULLCPU] < $mt[CPU_MIN]){
                  $mt[CPU_MIN] = $row[DATA_FULLCPU];
               }
               if ($row[DATA_MEMORY] < $mt[MEM_MIN]){
                  $mt[MEM_MIN] = $row[DATA_MEMORY];
               }
               if ($row[DATA_GZ] < $mt[GZ_MIN]){
                  $mt[GZ_MIN] = $row[DATA_GZ];
               }
            }
      }
   }
   @fclose($f);

   return array($data,$mins);
}


function Weights($Tests, $Action, $Vars, $CVars){
   $cookie = array();    
   if (isset($CVars['weights'])){ $cookie = UnpackCSV( $CVars['weights'] );}                        

   $w = array(); $wd = array();
   foreach($Tests as $t){
      $link = $t[TEST_LINK];  
      if (isset($Vars[$link]) && is_numeric($Vars[$link])){ $x = $Vars[$link]; }              
      elseif (isset($cookie[$link])){ $x = $cookie[$link]; }          
      else { $x = $t[TEST_WEIGHT]; } 
               
      if (is_numeric($x)){ $w[$link] = $x; }
      $wd[$link] = $t[TEST_WEIGHT];                               
   }           
   
   $Metrics = array('xcpu' => 0, 'xfullcpu' => 1, 'xmem' => 0, 'xloc' => 0);
   foreach($Metrics as $k => $v){ 
      if (isset($Vars[$k]) && is_numeric($Vars[$k])){ $x = $Vars[$k]; }                   
      elseif (isset($cookie[$k])){ $x = $cookie[$k]; }    
      else { $x = $v; }          
         
      if (is_numeric($x)){ $w[$k] = $x; }
      $wd[$k] = $v;                                
   }         
   
   if ($Action=='Reset'){ $w = $wd; }
   return $w;
}


function MedianScores(&$Scores, &$Weights){
   $arraysOfScores = array(); 
   foreach($Scores as $lang => $test){
      foreach($test as $t => $v){
         $w = $Weights[$t]>0.0 ? 1.0 : 0.0;
         $arraysOfScores[$lang]['xfullcpu'][] = $v[DATA_FULLCPU] * $w;
         $arraysOfScores[$lang]['xmem'][] = $v[DATA_MEMORY] * $w;
         $arraysOfScores[$lang]['xloc'][] = $v[DATA_LINES] * $w;
      }
   }

   $medianScores = array(); 
   foreach($arraysOfScores as $lang => $measure){
      $medianSum = 0.0;
      foreach($measure as $m => $a){
         sort($a);
         $n = sizeof($a);
         $mid = $n/2;
         $median = ($n%2!=0) ? $a[$mid] : ($a[$mid]+$a[$mid-1])/2.0;
         $medianSum += $median * $Weights[$m];
      }
      $medianScores[$lang] = $medianSum;
   }
   unset($arraysOfScores);
   return $medianScores;
}

function PBlank($d){
   if ($d>0){ return number_format($d); }   
   else { return "&nbsp;"; }
}

?>
