<?php
// Copyright (c) Isaac Gouy 2005

// FUNCTIONS ///////////////////////////////////////////////////

function PackCSV($a){
   $s = "";
   foreach($a as $k => $v){ $s .= $k.','.$v.','; }
   return substr($s,0,-1);
}

function UnpackCSV($s){
   $a = explode(',',$s);
   $aa = array();
   $i = 0;
   while ($i<sizeof($a)-1){
      $k = $a[$i]; $v = $a[$i+1];
      if (is_string($k) && is_numeric($v)){ $aa[$k] = $v; }
      $i += 2;    
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
     
      if (isset($Incl[$test]) && isset($Incl[$lang]) 
            && !ExcludeData($row,$Langs,$Excl)){
                                                                      
         settype($row[DATA_ID],'integer');                        
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
               $range[$test][CPU_MAX] = $cpu; 
            }   
            else {   
               if ($cpu<$range[$test][CPU_MIN]){ $range[$test][CPU_MIN] = $cpu; }   
               if ($cpu>$range[$test][CPU_MAX]){ $range[$test][CPU_MAX] = $cpu; }   
            }   
         }                  
         
         $mem = $row[DATA_MEMORY];                        
         if ($mem > 0){       
            if (!isset($range[$test][MEM_MIN])){ 
               $range[$test][MEM_MIN] = $mem; 
               $range[$test][MEM_MAX] = $mem; 
            }   
            else {   
               if ($mem<$range[$test][MEM_MIN]){ $range[$test][MEM_MIN] = $mem; }   
               if ($mem>$range[$test][MEM_MAX]){ $range[$test][MEM_MAX] = $mem; }   
            }   
         } 
         
         $loc = $row[DATA_LINES];                         
         if ($loc > 0){       
            if (!isset($range[$test][LOC_MIN])){ 
               $range[$test][LOC_MIN] = $loc; 
               $range[$test][LOC_MAX] = $loc; 
            }   
            else {   
               if ($loc<$range[$test][LOC_MIN]){ $range[$test][LOC_MIN] = $loc; }   
               if ($loc>$range[$test][LOC_MAX]){ $range[$test][LOC_MAX] = $loc; }   
            }   
         }                                     
      }      
   }
   @fclose($f);                 
   
   foreach($data as $k => $test){
      foreach($test as $t => $v){
         if (isset($range[$t][CPU_MIN])){$r = $range[$t][CPU_MIN]; } else { $r = 0; }
         $cpuScore = LogScore($v[DATA_FULLCPU], $r);
         $data[$k][$t][DATA_FULLCPU] = $cpuScore;    
                       
         if (isset($range[$t][MEM_MIN])){$r = $range[$t][MEM_MIN]; } else { $r = 0; }                       
         $memScore = LogScore($v[DATA_MEMORY], $r);
         $data[$k][$t][DATA_MEMORY] = $memScore; 
                  
         if (isset($range[$t][LOC_MIN])){$r = $range[$t][LOC_MIN]; } else { $r = 0; }                  
         $locScore = LogScore($v[DATA_LINES], $r);
         $data[$k][$t][DATA_LINES] = $locScore;             
      }
   }
   return $data;  
}

function LogScore($x, $b){   
   if(($x==0)||($b==0)){ return 0.0; }
   $scale = 1.0;
   return 1 / (1 + $scale * log($x/$b)/log(2));
}


function Weights($Tests, $Action, $Vars, $CVars){
   $cookie = array();    
   if (isset($CVars['weights'])){ $cookie = UnpackCSV( $CVars['weights'] );}                        

   $w = array(); $wd = array();
   foreach($Tests as $t){
      $link = $t[TEST_LINK];  
      if (isset($Vars[$link])){ $x = $Vars[$link]; }              
      elseif (isset($cookie[$link])){ $x = $cookie[$link]; }          
      else { $x = $t[TEST_WEIGHT]; } 
               
      if (is_numeric($x)){ $w[$link] = $x; }
      $wd[$link] = $t[TEST_WEIGHT];                               
   }           
   
   $Metrics = array('xcpu' => 0, 'xfullcpu' => 1, 'xmem' => 0, 'xloc' => 0);       
   foreach($Metrics as $k => $v){  
      if (isset($Vars[$k])){ $x = $Vars[$k]; }                   
      elseif (isset($cookie[$k])){ $x = $cookie[$k]; }    
      else { $x = $v; }          
         
      if (is_numeric($x)){ $w[$k] = $x; }
      $wd[$k] = $v;                                
   }         
   
   if ($Action=='Reset'){ $w = $wd; }
   return $w;
}



?>