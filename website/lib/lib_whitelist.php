<?
// Copyright (c) Isaac Gouy 2009

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
define('LANG_SELECT',7);
define('LANG_COMPARE',8);
define('LANG_SPECIALURL',9);

define('INCL_LINK',0);
define('INCL_NAME',1);

define('EXCL_USE',0);
define('EXCL_TEST',1);
define('EXCL_LANG',2);
define('EXCL_ID',3);

define('STATS_SIZE',8);
define('STAT_MIN',0);
define('STAT_XLOWER',1);
define('STAT_LOWER',2);
define('STAT_MEDIAN',3);
define('STAT_UPPER',4);
define('STAT_XUPPER',5);
define('STAT_MAX',6);
define('STATS_N',7);

// MEASUREMENT_RESCALE has to be big enough to rescale NO_MEASUREMENT
// so the NO_MEASUREMENT information is passed to charts
define('NO_VALUE',0.00001);
define('VALUE_RESCALE',100000.0);
define('VALUE_SHIFT',5);

// FUNCTIONS ///////////////////////////////////////////////////

function WhiteListInEx(){
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
         $key = $row[EXCL_TEST].$row[EXCL_LANG].strval($row[EXCL_ID]);
         $excl[$key] = $row;
      }
   }
   @fclose($f);

   return array($incl,$excl);
}


function WhiteListUnique($FileName,$Incl,$HasHeading=TRUE){
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


function WhiteListSelected($FileName,$Value,$Incl,$HasHeading=TRUE){
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


   // VALIDATION

function ValidMark(&$H,$valid=FALSE){
   $bounds = 64;
   $mark = '';
   if ($valid){
      $valid = FALSE;
      if (isset($H['m']) && strlen($H['m']) && strlen($H['m']) <= $bounds){
         $X = base64_decode( rawurldecode($H['m']) );
         $X = @gzuncompress($X,$bounds); // returns FALSE on error
         if ($X && ereg("^[ a-zA-Z0-9]+$",$X)){ $mark = $X; $valid = TRUE; }
      }
   }
   return array($mark,$valid);
}

function ValidMatrix(&$H,$V,$size,$valid=FALSE){
   $shift = 5;
   $bounds = 1024;
   $d = array();
   if ($valid){
      $valid = FALSE;
      if (isset($H[$V]) && strlen($H[$V]) && strlen($H[$V]) <= $bounds){
         $X = base64_decode( rawurldecode($H[$V]) );
         $X = @gzuncompress($X,$bounds); // returns FALSE on error

         if ($X && ereg("^[0-9O]+$",$X)){
            foreach(explode('O',$X) as $v){
               if (strlen($v) && (strlen($v) <= 10) && is_numeric($v)){
                  $d[] = pow(10.0,(doubleval($v)/VALUE_RESCALE-VALUE_SHIFT));
               } else {
                  $d = array();
                  break;
               }
            }
            if ((sizeof($d)%$size) == 0){ $valid = TRUE;
            } else { $d = array(); }
         }
      }
   }
   return array($d,$valid);
}


function ValidLangs(&$H,&$Langs,$valid=FALSE){
   return ValidWhiteList($H,$Langs,"^[a-z0-9O]+$",24,LANG_FULL,$valid);
}

function ValidTests(&$H,&$Tests,$valid=FALSE){
   return ValidWhiteList($H,$Tests,"^[a-zO]+$",32,TEST_NAME,$valid);
}

// private
function ValidWhiteList(&$H,&$WhiteList,$regex,$size,$index,$valid){
   $bounds = 512;
   $d = array();
   if ($valid){
      $valid = FALSE;
      if (isset($H['w']) && strlen($H['w']) && strlen($H['w']) <= $bounds){
         $X = base64_decode( rawurldecode($H['w']) );
         $X = @gzuncompress($X,$bounds); // returns FALSE on error

         if ($X && ereg($regex,$X)){
            foreach(explode('O',$X) as $v){
               if (strlen($v) && (strlen($v) <= $size) && isset($WhiteList[$v])){
                  $d[] = $WhiteList[$v][$index];
               } else {
                  $d = array(); 
                  break;
               }
            }
            $valid = TRUE;
         }
      }
   }
   return array($d,$valid);
}

?>