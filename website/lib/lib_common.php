<?php
// Copyright (c) Isaac Gouy 2004, 2005

// DATA LAYOUT ///////////////////////////////////////////////////

define('TEST_LINK',0);
define('TEST_NAME',1);
define('TEST_TAG',2);
define('TEST_WEIGHT',3);
define('TEST_DATE',4);         

define('LANG_LINK',0);
define('LANG_FAMILY',1);
define('LANG_NAME',2);
define('LANG_FULL',3);
define('LANG_HTML',4);
define('LANG_TAG',5);
define('LANG_DATE',6);   
define('LANG_COMPARE',7);      

define('DATA_TEST',0);
define('DATA_LANG',1);
define('DATA_ID',2);
define('DATA_TESTVALUE',3);
define('DATA_CPU',4);
define('DATA_FULLCPU',5);
define('DATA_MEMORY',6);
define('DATA_LINES',7);
define('DATA_DATE',8);

define('INCL_LINK',0);
define('INCL_NAME',1);

define('EXCL_USE',0);
define('EXCL_TEST',1);
define('EXCL_LANG',2);
define('EXCL_ID',3);


// CONSTANTS ///////////////////////////////////////////////////

define('EXCLUDED','X');
define('PROGRAM_TIMEOUT',-1);
define('PROGRAM_ERROR',-2);
define('PROGRAM_SPECIAL','-3');
define('PROGRAM_EXCLUDED',-4);
define('LANGUAGE_EXCLUDED',-5);
define('NO_COMPARISON',-6);
define('NO_PROGRAM_OUTPUT',-7);

define('N_TEST',0);
define('N_LANG',1);
define('N_ID',2);
define('N_NAME',3);
define('N_FULL',4);
define('N_HTML',5);
define('N_FULLCPU',6);
define('N_MEMORY',7);
define('N_CPU_MAX',8);
define('N_MEMORY_MAX',9);
define('N_COLOR',10);

define('N_N',3);
define('N_LINES',8);
define('N_CPU',9);
define('N_EXCLUDE',10);


define('CPU_MIN',0);
define('CPU_MAX',1);
define('MEM_MIN',2);
define('MEM_MAX',3);
define('LOC_MIN',4);
define('LOC_MAX',5);



// FUNCTIONS ///////////////////////////////////////////////////

function GetMicroTime(){
   $t = explode(" ", microtime());
   return doubleval($t[1]) + doubleval($t[0]);
}

function ReadIncludeExclude(){
   $incl = array();
   $f = @fopen('./include.csv','r') or die('Cannot open ./include.csv');
   $row = @fgetcsv($f,1024,','); // heading row
   while (!@feof ($f)){
      $row = @fgetcsv($f,1024,',');
      if (!is_array($row)){ continue; }
      if (isset($row[INCL_LINK]{0})){ $incl[ $row[INCL_LINK] ] = 0; }                   
   }
   @fclose($f);
   
   $excl = array();
   $f = @fopen(DESC_PATH.'/exclude.csv','r') or die('Cannot open '.DESC_PATH.'/exclude.csv');
   $row = @fgetcsv($f,1024,','); // heading row

   while (!@feof ($f)){
      $row = @fgetcsv($f,1024,',');
      if (!is_array($row)){ continue; }
      if (isset($row[EXCL_TEST]{0})){           
         if (!isset($row[EXCL_ID])){ $row[EXCL_ID] = 1; }
         $excl[] = $row;               
      }                                
   }
   @fclose($f);   
       
   return array($incl,$excl);
}



function ReadUniqueArrays($FileName,$Incl,$HasHeading=TRUE){
   if (file_exists('./'.$FileName)){
      $f = @fopen('./'.$FileName,'r') or die('Cannot open '.$FileName);
   } else {
      $f = @fopen(DESC_PATH.$FileName,'r') or die('Cannot open '.$FileName);
   }

   if ($HasHeading){ $row = @fgetcsv($f,1024,','); }

   while (!@feof ($f)){
      $row = @fgetcsv($f,1024,',');
      if (!is_array($row)){ continue; }
     
//######## Hardcoded assumption that $row[0] is a link name
      if (isset( $Incl[$row[0]] )){ $rows[ $row[0] ] = $row; }      
   }
   @fclose($f);
   return $rows;
}


function ReadSelectedDataArrays($FileName,$Value,$Incl,$HasHeading=TRUE){
   $f = @fopen($FileName,'r') or die ('Cannot open $FileName');
   if ($HasHeading){ $row = @fgetcsv($f,1024,','); }
   $rows = array();
   while (!@feof ($f)){
      $row = @fgetcsv($f,1024,',');
      if (!is_array($row)){ continue; }
      if ( isset($row[DATA_LANG]) && ($row[DATA_TEST]==$Value) ){                  
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

function CompareTestValue2($a, $b){
   if ($a[DATA_TEST] == $b[DATA_TEST]){
         if ($a[DATA_TESTVALUE] == $b[DATA_TESTVALUE]) return 0;
         return ($a[DATA_TESTVALUE] > $b[DATA_TESTVALUE]) ? -1 : 1;
   }
   else {
      return ($a[DATA_TEST] < $b[DATA_TEST]) ? -1 : 1;      
   }   
}

function CompareNName($a, $b){
   return strcasecmp($a[N_FULL],$b[N_FULL]);
}

function SortName($sort){
   if ($sort=='cpu'){ return 'CPU Time'; }
   elseif ($sort=='fullcpu'){ return 'Full CPU Time'; }
   else { return 'Memory use'; }
}

function IdName($id){
   if ($id>0){ return ' #'.$id; } else { return ''; }
}


function ExcludeData(&$d,&$langs,&$Excl){
   if( !isset($langs[$d[DATA_LANG]]) ) { return LANGUAGE_EXCLUDED; }

//######## Look for more efficient approach?   
   foreach($Excl as $x){   

      if ( ($d[DATA_TEST]==$x[EXCL_TEST]) && 
              ($d[DATA_LANG]==$x[EXCL_LANG]) &&
                  ($d[DATA_ID]==$x[EXCL_ID]) ){         
                  
         if ($x[EXCL_USE]==EXCLUDED){         
            return PROGRAM_EXCLUDED; 

         } else {  
            return PROGRAM_SPECIAL; }
      }     
   }         

   if( $d[DATA_FULLCPU] == PROGRAM_TIMEOUT ) { return PROGRAM_TIMEOUT; }
   if( $d[DATA_FULLCPU] == PROGRAM_ERROR ) { return PROGRAM_ERROR; }  
   return 0;
}


function FilterAndSortData($langs,$data,$sort,&$Excl){
   $Accepted = array();
   $Rejected = array();   
   $Special = array();  

   // $data is an associative array keyed by language
   // Each value is itself an array of one or more data records

   foreach($data as $ar){   
      foreach($ar as $d){  
         $x = ExcludeData($d,$langs,$Excl);         
         if ($x==PROGRAM_SPECIAL){ 
            $Special[] = $d;
         } elseif ($x==PROGRAM_EXCLUDED) { 
                   
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
   } elseif ($sort=='lines'){ 
      usort($Accepted, 'CompareCodeLines'); 
   } 

   return array($Accepted,$Rejected,$Special);
}




// CONTENT ///////////////////////////////////////////////////

function MkMenuForm($Tests,$SelectedTest,$Langs,$SelectedLang,$Sort){
   echo '<form method="get" action="benchmark.php">', "\n";
   echo '<p><select name="test">', "\n";
   echo '<option value="all">all ', TESTS_PHRASE, '</option>', "\n";

   foreach($Tests as $Row){
      $Link = $Row[TEST_LINK];
      $Name = $Row[TEST_NAME];
      if ($Link==$SelectedTest){
         $Selected = 'selected="selected"';
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
         $Selected = 'selected="selected"';
      } else {
         $Selected = '';
      }
      printf('<option %s value="%s">%s</option>', $Selected,$Link,$Name); echo "\n";
   }
   echo '</select>', "\n";
   echo '<input type="submit" value="Show" />', "\n";
   printf('<input type="hidden" name="sort" value="%s" />', $Sort); echo "\n";
   echo '</p></form>', "\n";
}


function MkScorecardMenuForm($Sort){
   echo '<form method="get" action="benchmark.php">', "\n";
   echo '<p><select name="test">', "\n";
   echo '<option selected="selected" value="all">all ', TESTS_PHRASE, '</option>', "\n";
   echo '</select>', "\n";

   echo '<select name="lang">', "\n";
   echo '<option value="all">all ', LANGS_PHRASE, '</option>', "\n";
   echo '</select>', "\n";
   echo '<input type="submit" value="Show" title="Create your own Overall Scores"/>', "\n";
   printf('<input type="hidden" name="sort" value="%s" />', $Sort); echo "\n";   
   echo '</p></form>', "\n";
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