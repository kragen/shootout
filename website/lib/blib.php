<?php
// Copyright (c) Isaac Gouy 2004

// DATA LAYOUT ///////////////////////////////////////////////////

define('TEST_USE',0);
define('TEST_LINK',1);
define('TEST_NAME',2);
define('TEST_TAG',3);
define('TEST_WEIGHT',4);
define('TEST_DATE',5);         


define('LANG_USE',0);
define('LANG_LINK',1);
define('LANG_FAMILY',2);
define('LANG_NAME',3);
define('LANG_FULL',4);
define('LANG_HTML',5);
define('LANG_TAG',6);
define('LANG_DATE',7);         


define('DATA_USE',0);
define('DATA_TEST',1);
define('DATA_LANG',2);
define('DATA_ID',3);
define('DATA_TESTVALUE',4);
define('DATA_CPU',5);
define('DATA_FULLCPU',6);
define('DATA_MEMORY',7);
define('DATA_LINES',8);
define('DATA_DATE',9);


// CONSTANTS ///////////////////////////////////////////////////

define('INCLUDED','+');
define('EXCLUDED','X');
define('SPECIAL','&');

define('PROGRAM_TIMEOUT',-1);
define('PROGRAM_ERROR',-2);
define('EXCLUDED_LANGUAGE',-3);
define('PROGRAM_SPECIAL','-4');


define('N_LANG',0);
define('N_ID',1);
define('N_NAME',2);
define('N_FULL',3);
define('N_HTML',4);
define('N_FULLCPU',5);
define('N_MEMORY',6);
define('N_CPU_MAX',7);
define('N_MEMORY_MAX',8);
define('N_COLOR',9);

define('CPU_MIN',0);
define('CPU_MAX',1);
define('MEM_MIN',2);
define('MEM_MAX',3);
define('LOC_MIN',4);
define('LOC_MAX',5);


// FUNCTIONS ///////////////////////////////////////////////////


function ReadUniqueArrays($FileName,$HasHeading=TRUE){
   if (file_exists('./'.$FileName)){
      $f = @fopen('./'.$FileName,'r') or die('Cannot open '.$FileName);
   } else {
      $f = @fopen(DATA_PATH.$FileName,'r') or die('Cannot open '.$FileName);
   }

   if ($HasHeading){ $row = @fgetcsv($f,1024,','); }

   while (!@feof ($f)){
      $row = @fgetcsv($f,1024,',');
      if (!is_array($row)){ continue; }
      if (DEV||($row[0] == INCLUDED)){ $rows[ $row[1] ] = $row; }      
   }
   @fclose($f);
   return $rows;
}



function ReadSelectedDataArrays($FileName,$Value,$HasHeading=TRUE){
   $f = @fopen($FileName,'r') or die ('Cannot open $FileName');

   if ($HasHeading){ $row = @fgetcsv($f,1024,','); }

   $rows = array();
   while (!@feof ($f)){
      $row = @fgetcsv($f,1024,',');
      if (!is_array($row)){ continue; }
      if ((DEV||($row[0] != EXCLUDED))&&($row[DATA_TEST]==$Value)){ 
         settype($row[DATA_ID],'integer');

         if (isset($rows[$row[DATA_LANG]])){
            array_push( $rows[$row[DATA_LANG]], $row);
         } else {
            $rows[$row[DATA_LANG]] = array($row);
         }
      }
   }
   @fclose($f); 
   return $rows;
}



function CompareCpuTime($a, $b){
   if ($a[DATA_CPU] == $b[DATA_CPU]) return 0;
   return  ($a[DATA_CPU] < $b[DATA_CPU]) ? -1 : 1;
}

function CompareFullCpuTime($a, $b){
   if ($a[DATA_FULLCPU] == $b[DATA_FULLCPU]) return 0;
   return  ($a[DATA_FULLCPU] < $b[DATA_FULLCPU]) ? -1 : 1;
}

function CompareMemoryUse($a, $b){
   if ($a[DATA_MEMORY] == $b[DATA_MEMORY]) return 0;
   return  ($a[DATA_MEMORY] < $b[DATA_MEMORY]) ? -1 : 1;
}

function CompareCodeLines($a, $b){
   if ($a[DATA_LINES] == $b[DATA_LINES]) return 0;
   return  ($a[DATA_LINES] < $b[DATA_LINES]) ? -1 : 1;
}




function CompareLangName($a, $b){
   return strcasecmp($a[LANG_FULL],$b[LANG_FULL]);
}

function CompareTestName($a, $b){
   return strcasecmp($a[TEST_NAME],$b[TEST_NAME]);
}

function CompareTestValue($a, $b){
   if ($a[DATA_LANG] == $b[DATA_LANG]){
      if ($a[DATA_ID] == $b[DATA_ID]){
         if ($a[DATA_TESTVALUE] == $b[DATA_TESTVALUE]) return 0;
         return ($a[DATA_TESTVALUE] < $b[DATA_TESTVALUE]) ? -1 : 1;
      }
      else {
         return ($a[DATA_ID] < $b[DATA_ID]) ? -1 : 1;      
      }
   }
   else {
      return ($a[DATA_LANG] < $b[DATA_LANG]) ? -1 : 1;      
   }   
}

function CompareNName($a, $b){
   return strcasecmp($a[N_FULL],$b[N_FULL]);
}

function CompareMaxCpu($a, $b){
   if ($a[N_CPU_MAX] == $b[N_CPU_MAX]) return 0;
   return  ($a[N_CPU_MAX] > $b[N_CPU_MAX]) ? -1 : 1;
}

function CompareMaxMemory($a, $b){
   if ($a[N_MEMORY_MAX] == $b[N_MEMORY_MAX]) return 0;
   return  ($a[N_MEMORY_MAX] > $b[N_MEMORY_MAX]) ? -1 : 1;
}


function SortName($sort){
   if ($sort=='cpu'){ return 'CPU Time'; }
   elseif ($sort=='fullcpu'){ return 'Full CPU Time'; }
   else { return 'Memory use'; }
}


function IdName($id){
   if ($id>0){ return ' #'.$id; } else { return ''; }
}


function ExcludeData(&$d,&$langs){
   if( !isset($langs[$d[DATA_LANG]]) ) { return EXCLUDED_LANGUAGE; }
   if( $d[DATA_USE] == SPECIAL ) { return PROGRAM_SPECIAL; }    
   if( $d[DATA_FULLCPU] == PROGRAM_TIMEOUT ) { return PROGRAM_TIMEOUT; }
   if( $d[DATA_FULLCPU] == PROGRAM_ERROR ) { return PROGRAM_ERROR; }  
   return FALSE;
}


function FilterAndSortData($langs,$data,$sort){
   $Accepted = array();
   $Rejected = array();   
   $Special = array();  
 
   // $data is an associative array keyed by language
   // Each value is itself an array of one or more data records
   
   foreach($data as $ar){   
      foreach($ar as $d){  
         $x = ExcludeData($d,$langs);         
         if ($x==PROGRAM_SPECIAL){ 
            $Special[] = $d;
         } elseif ($x) {         
            $Rejected[] = $d;
         } else {
            $Accepted[] = $d; 
         }
      }         
   }

   if ($sort=='cpu'){    
      usort($Accepted, 'CompareCpuTime');
   } elseif ($sort=='fullcpu'){ 
      usort($Accepted, 'CompareFullCpuTime');  
   } elseif ($sort=='kb'){ 
      usort($Accepted, 'CompareMemoryUse'); 
   } 

   return array($Accepted,$Rejected,$Special);
}



function ComparisonData($langs,$data,$sort,$p){
   list($Accepted) = FilterAndSortData($langs,$data,$sort);

// SELECTION DEPENDS ON THIS SORT ORDER
 
   uasort($Accepted,'CompareTestValue');

// TRANSFORM SELECTED DATA

   $lang = ""; $id = ""; 
   $NData = array(); $TestValues = array();

   foreach($Accepted as $d){
      if (($lang != $d[DATA_LANG])||($id != $d[DATA_ID])){
         $lang = $d[DATA_LANG];
         $id = $d[DATA_ID]; 

         $NData[] = array(
              $lang
            , $id
            , ''
            , $langs[$lang][LANG_FULL].IdName($id)
            , $langs[$lang][LANG_HTML].IdName($id)
            , array()
            , array()
            , 0
            , 0
            , 0
            );

         $i = sizeof($NData)-1;         
      } 
      $NData[$i][N_FULLCPU][] = $d[DATA_FULLCPU];
      $NData[$i][N_MEMORY][] = $d[DATA_MEMORY];    
      $TestValues[ $d[DATA_TESTVALUE] ] = $d[DATA_TESTVALUE];
   }


// SUB-SELECT DATA FOR SPECIFIC PROGRAMS

   $plang = array(); $pid = array();
   foreach($p as $pdash){  
      list($a, $b) = explode('-', $pdash);   
      $plang[] = $a; 
      $pid[] = $b;  
   }

   $Selected = array();
   foreach($NData as $d){
      if ((($plang[0]==$d[N_LANG])&&($pid[0]==$d[N_ID])) ||
          (($plang[1]==$d[N_LANG])&&($pid[1]==$d[N_ID])) ||
          (($plang[2]==$d[N_LANG])&&($pid[2]==$d[N_ID])) ||
          (($plang[3]==$d[N_LANG])&&($pid[3]==$d[N_ID]))){
         $Selected[] = $d;
      }
   }

// MAX AND NAME FOR SPECIFIC PROGRAMS

   for ($i=0; $i<sizeof($Selected); $i++){
      $d = $Selected[$i];
      $lang = $d[N_LANG];
      $id = $d[N_ID]; 

      if (strlen($langs[$lang][LANG_NAME])>0){
         $Selected[$i][N_NAME] = $langs[$lang][LANG_NAME].IdName($id); }
      else {
         $Selected[$i][N_NAME] = $langs[$lang][LANG_FAMILY].IdName($id); } 

      foreach($d[N_FULLCPU] as $v){
         if ($Selected[$i][N_CPU_MAX]<$v){ $Selected[$i][N_CPU_MAX] = $v; }
      }
      foreach($d[N_MEMORY] as $v){
         if ($Selected[$i][N_MEMORY_MAX]<$v){ $Selected[$i][N_MEMORY_MAX] = $v; }
      }

// USE SAME COLOR FOR PROGRAM IN EVERY CHART
      $Selected[$i][N_COLOR] = $i; 
   }

   uasort($NData,'CompareNName');
   sort($TestValues);

   return array(&$NData,&$Selected,$TestValues);
}


function LogScore($x, $b){   
   if(($x==0)||($b==0)){ return 0.0; }
   $scale = 1.0;
   return 1 / (1 + $scale * log($x/$b)/log(2));
}


function ScoreData($FileName,&$Tests,&$Langs,$HasHeading=TRUE){
   $f = @fopen($FileName,'r') or die ('Cannot open $FileName');
   if ($HasHeading){ $row = @fgetcsv($f,1024,','); }

   $data = array();   
   while (!@feof ($f)){
      $row = @fgetcsv($f,1024,',');
      if (!is_array($row)){ continue; }
      
      $test = $row[DATA_TEST];
      if (!ExcludeData($row,$Langs) && (DEV||($row[0] == INCLUDED)) 
            && (DEV||(isset($Tests[$test]) && ($Tests[$test][0] == INCLUDED))) ) {                                                                    
         settype($row[DATA_ID],'integer');         
         $lang = $row[DATA_LANG];
      
         if (isset( $data[$lang][$test])){         
            // IF THERE ARE MULTIPLE IMPLEMENTATIONS RANK ON FULLCPU    
                    
            if ($row[DATA_FULLCPU] < $data[$lang][$test][DATA_FULLCPU]){            
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



function RankData($FileName,&$Langs,$L,$HasHeading=TRUE){
   $f = @fopen($FileName,'r') or die ('Cannot open $FileName');
   if ($HasHeading){ $row = @fgetcsv($f,1024,','); }

   // collect records for selected language together, keyed by test
   // collect records for other languages together, keyed by test

   $tests = array();
   $data = array();

   while (!@feof ($f)){
      $row = @fgetcsv($f,1024,',');
      if (!is_array($row)){ continue; }
      if (DEV||($row[0] == INCLUDED)){ 

         settype($row[DATA_ID],'integer');
         $testId = $row[DATA_TEST];

         if ($row[DATA_LANG]==$L){                  
            if (isset( $tests[$testId] )){
            
               // IF THERE ARE MULTIPLE IMPLEMENTATIONS RANK ON FULLCPU
               
               if ($row[DATA_FULLCPU] < $tests[$testId][DATA_FULLCPU]){            
                  $tests[$testId] = $row;  
               }
            }
            else {            
               $tests[$testId] = $row;                    
            }
         }
         else if (! ExcludeData($row,$Langs)) { 
            if (isset( $data[$testId] )){
               array_push( $data[$testId], $row );
            }
            else {
               $data[$testId] = array($row);
            }
         }
      }      
   }
   @fclose($f);

   // COPY ARRAY AND ZERO RANK COUNTS
   $ranks = array();   
   while (list($k,$d) = each($tests)){ 
      $r = $d;                                        // SHALLOW COPY ARRAY
      $r[DATA_CPU] = 1;
      $r[DATA_FULLCPU] = 1;
      $r[DATA_MEMORY] = 1;      
      $exclude = ExcludeData($d,$Langs);
      if ($exclude){ $r[DATA_LINES] = $exclude; } else { $r[DATA_LINES] = 1; }    
      $ranks[$k] = $r;
   }

   foreach($tests as $t){ 
      $r = &$ranks[ $t[DATA_TEST] ];  
      if (($r[DATA_LINES] > 0) && isset($data[$t[DATA_TEST]])){                                   
         foreach($data[$t[DATA_TEST]] as $d){           
            if ( $d[DATA_CPU] < $t[DATA_CPU] ){ $r[DATA_CPU]++; }                        
            if ( $d[DATA_FULLCPU] < $t[DATA_FULLCPU] ){ $r[DATA_FULLCPU]++; }
            if ( $d[DATA_MEMORY] < $t[DATA_MEMORY] ){ $r[DATA_MEMORY]++; }
            if ( $d[DATA_LINES] < $t[DATA_LINES] ){ $r[DATA_LINES]++; }        
         }  
      }      
   }
   
   return $ranks;
}



// CONTENT ///////////////////////////////////////////////////


function MkMenuForm($Tests,$SelectedTest,$Langs,$SelectedLang,$Sort){
   echo '<form method="GET" action="benchmark.php">', "\n";
   echo '<select name="test">', "\n";
   echo '<option value="all">all ', TESTS_PHRASE, '</option>', "\n";

   foreach($Tests as $Row){
      $Link = $Row[TEST_LINK];
      $Name = $Row[TEST_NAME];
      if ($Link==$SelectedTest){
         $Selected = 'selected';
      } else {
         $Selected = '';
      }
      printf('<option %s value="%s">%s</option>', $Selected,$Link,$Name); echo "\n";
   }
   echo '</select>', "\n";


   echo '<select name="lang">', "\n";
   echo '<option value="all">all ', LANGS_PHRASE, '</option>', "\n";
   foreach($Langs as $Row){
      $Link = $Row[LANG_LINK];
      $Name = $Row[LANG_FULL];
      if ($Link==$SelectedLang){
         $Selected = 'selected';
      } else {
         $Selected = '';
      }
      printf('<option %s value="%s">%s</option>', $Selected,$Link,$Name); echo "\n";
   }
   echo '</select>', "\n";
   echo '<input type="submit" value="Show" />', "\n";
   printf('<input type="hidden" name="sort" value="%s" />', $Sort); echo "\n";
   echo '</form>', "\n";
}



function MkScorecardMenuForm($Sort){
   echo '<form method="GET" action="benchmark.php">', "\n";
   echo '<select name="test">', "\n";
   echo '<option selected value="all">all ', TESTS_PHRASE, '</option>', "\n";
   echo '</select>', "\n";


   echo '<select name="lang">', "\n";
   echo '<option value="all">all ', LANGS_PHRASE, '</option>', "\n";
   echo '</select>', "\n";
   echo '<input type="submit" value="Show" />', "\n";
   printf('<input type="hidden" name="sort" value="%s" />', $Sort); echo "\n";   
   echo '</form">', "\n";
}



function MkComparisonMenuForm($Langs,$Tests,$SelectedTest,$Data,$p1,$p2,$p3,$p4,$Sort){
   echo '<form method="GET" action="sidebyside.php">', "\n";
   echo '<select name="test">', "\n";
   foreach($Tests as $Row){
      $Link = $Row[TEST_LINK];
      $Name = $Row[TEST_NAME];
      if ($Link==$SelectedTest){
         $Selected = 'selected';
      } else {
         $Selected = '';
      }
      printf('<option %s value="%s">%s</option>', $Selected,$Link,$Name); echo "\n";
   }
   echo '</select><br/><br/>', "\n";        
      
// NASTY HACK      
// ADD DUMMY VALUES TO PRESERVE SELECTION IN DROP-DOWN MENUS       
   list($a, $b) = explode('-', $p1); $c = $Langs[$a]; $d = IdName($b);    
   $Data[] = array($a, $b, '', $c[LANG_FULL].$d, $c[LANG_HTML].$d);    
   list($a, $b) = explode('-', $p2); $c = $Langs[$a]; $d = IdName($b);
   $Data[] = array($a, $b, '', $c[LANG_FULL].$d, $c[LANG_HTML].$d);   
   list($a, $b) = explode('-', $p3); $c = $Langs[$a]; $d = IdName($b);
   $Data[] = array($a, $b, '', $c[LANG_FULL].$d, $c[LANG_HTML].$d);     
   list($a, $b) = explode('-', $p4); $c = $Langs[$a]; $d = IdName($b);
   $Data[] = array($a, $b, '', $c[LANG_FULL].$d, $c[LANG_HTML].$d);          
    

   echo '<select name="p1">', "\n";
   $first = 1;
   foreach($Data as $Row){
      $Link = $Row[N_LANG].'-'.$Row[N_ID];
      $Name = $Row[N_FULL];
      if ($Link==$p1 && $first){ // avoid choosing the dummy value if possible
         $Selected = 'selected'; $first = 0;
      } else {
         $Selected = '';
      }
      printf('<option %s value="%s">%s</option>', $Selected,$Link,$Name); echo "\n";
   }
   echo '</select>', "\n";

   echo '<select name="p2">', "\n";
   $first = 1;   
   foreach($Data as $Row){
      $Link = $Row[N_LANG].'-'.$Row[N_ID];
      $Name = $Row[N_FULL];
      if (($Link==$p2) && $first){ // avoid choosing the dummy value if possible
         $Selected = 'selected'; $first = 0;
      } else {
         $Selected = '';
      }
      printf('<option %s value="%s">%s</option>', $Selected,$Link,$Name); echo "\n";
   }
   echo '</select>', "\n";

   echo '<select name="p3">', "\n";
   $first = 1;   
   foreach($Data as $Row){
      $Link = $Row[N_LANG].'-'.$Row[N_ID];
      $Name = $Row[N_FULL];
      if ($Link==$p3 && $first){ // avoid choosing the dummy value if possible
         $Selected = 'selected'; $first = 0;
      } else {
         $Selected = '';
      }
      printf('<option %s value="%s">%s</option>', $Selected,$Link,$Name); echo "\n";
   }
   echo '</select>', "\n";

   echo '<select name="p4">', "\n";
   $first = 1;   
   foreach($Data as $Row){
      $Link = $Row[N_LANG].'-'.$Row[N_ID];
      $Name = $Row[N_FULL];
      if ($Link==$p4 && $first){ // avoid choosing the dummy value if possible
         $Selected = 'selected'; $first = 0;
      } else {
         $Selected = '';
      }
      printf('<option %s value="%s">%s</option>', $Selected,$Link,$Name); echo "\n";
   }
   echo '</select>', "\n";


   echo '<input type="submit" value="Show" />', "\n";
   printf('<input type="hidden" name="sort" value="%s" />', $Sort); echo "\n";
   echo '</form>', "\n";
}


function HtmlFragment($FileName){
   if (is_readable($FileName)){
      $f = fopen($FileName,'r');
      $html = fread($f,filesize($FileName));
      fclose($f);
   } else {
      $html = '<p>&nbsp;</p>';
   }
   return $html;
}


?>