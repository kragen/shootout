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

   $data = array();   
   while (!@feof ($f)){
      $row = @fgetcsv($f,1024,',');
      if (!is_array($row)){ continue; }

      $test = $row[DATA_TEST];
      $lang = $row[DATA_LANG];
      settype($row[DATA_ID],'integer');

      if (isset($Incl[$test]) && isset($Incl[$lang])
            && NoExclude($row,$Langs,$Excl)){

         if (isset( $data[$lang][$test])){         
            // IF THERE ARE MULTIPLE IMPLEMENTATIONS RANK ON FULLCPU

            if (($row[DATA_FULLCPU] > PROGRAM_TIMEOUT) && (
                  ($data[$lang][$test][DATA_FULLCPU] <= PROGRAM_TIMEOUT) ||                             
                  ($row[DATA_FULLCPU] < $data[$lang][$test][DATA_FULLCPU]))){

               $data[$lang][$test] = $row;
            }
         }
         else {            
            $data[$lang][$test] = $row;                    
         }
                  
         if (!isset($range[$test])){ $range[$test] = array(); }
         

         $cpu = $row[DATA_FULLCPU];
         if ($cpu > 0){       
            if (!isset($range[$test][CPU_MIN])){
               $range[$test][CPU_MIN] = $cpu;
               //$range[$test][CPU_MAX] = $cpu;
            }   
            else {
               if ($cpu<$range[$test][CPU_MIN]){ $range[$test][CPU_MIN] = $cpu; }   
               //if ($cpu>$range[$test][CPU_MAX]){ $range[$test][CPU_MAX] = $cpu; }
            }   
         }                  
         
         $mem = $row[DATA_MEMORY];                        
         if ($mem > 0){       
            if (!isset($range[$test][MEM_MIN])){ 
               $range[$test][MEM_MIN] = $mem; 
               //$range[$test][MEM_MAX] = $mem;
            }   
            else {   
               if ($mem<$range[$test][MEM_MIN]){ $range[$test][MEM_MIN] = $mem; }
               //if ($mem>$range[$test][MEM_MAX]){ $range[$test][MEM_MAX] = $mem; }
            }   
         } 
         
         $loc = $row[DATA_LINES];                         
         if ($loc > 0){       
            if (!isset($range[$test][LOC_MIN])){ 
               $range[$test][LOC_MIN] = $loc; 
               //$range[$test][LOC_MAX] = $loc;
            }   
            else {
               if ($loc<$range[$test][LOC_MIN]){ $range[$test][LOC_MIN] = $loc; }   
               //if ($loc>$range[$test][LOC_MAX]){ $range[$test][LOC_MAX] = $loc; }
            }   
         }

         $gz = $row[DATA_GZ];                         
         if ($gz > 0){       
            if (!isset($range[$test][GZ_MIN])){ 
               $range[$test][GZ_MIN] = $gz;
               //$range[$test][GZ_MAX] = $gz;
            }
            else {   
               if ($gz<$range[$test][GZ_MIN]){ $range[$test][GZ_MIN] = $gz; }   
               //if ($gz>$range[$test][GZ_MAX]){ $range[$test][GZ_MAX] = $gz; }
            }
         }
      }
   }
   @fclose($f);

   foreach($data as $k => $test){
      foreach($test as $t => $v){
         if (isset($range[$t][CPU_MIN])){$r = $range[$t][CPU_MIN]; } else { $r = 0; }
         $cpuScore = RatioScore($v[DATA_FULLCPU], $r);
         $data[$k][$t][DATA_FULLCPU] = $cpuScore;    
                       
         if (isset($range[$t][MEM_MIN])){$r = $range[$t][MEM_MIN]; } else { $r = 0; }                       
         $memScore = RatioScore($v[DATA_MEMORY], $r);
         $data[$k][$t][DATA_MEMORY] = $memScore; 
                  
         if (isset($range[$t][LOC_MIN])){$r = $range[$t][LOC_MIN]; } else { $r = 0; }                  
         $locScore = RatioScore($v[DATA_LINES], $r);
         $data[$k][$t][DATA_LINES] = $locScore;

         if (isset($range[$t][GZ_MIN])){$r = $range[$t][GZ_MIN]; } else { $r = 0; }
         $gzScore = RatioScore($v[DATA_GZ], $r);
         $data[$k][$t][DATA_GZ] = $gzScore;
      }
   }
   return $data;
}

function LogScore($x, $b){
   if(($x==0)||($b==0)){ return 0.0; }
   $scale = 1.0;
   return 1 / (1 + $scale * log($x/$b)/log(2));
}

function LinearScore($x, $b){   
   if(($x==0)||($b==0)){ return 0.0; }
   $scale = 100.0;
   return ($b/$x)*$scale;
}

function RatioScore($x, $b){
   if(($x==0)||($b==0)){ return 0.0; }
   return $x/$b;
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
