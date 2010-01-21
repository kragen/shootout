<?php
// Copyright (c) Isaac Gouy 2010

// DATA LAYOUT ///////////////////////////////////////////////////

$NAME_LEN = 16;
$LANG_COMPARE = 8;

// GET_VARS ////////////////////////////////////////////////

if (isset($HTTP_GET_VARS['test'])
      && strlen($HTTP_GET_VARS['test']) && (strlen($HTTP_GET_VARS['test']) <= $NAME_LEN)){
   $X = $HTTP_GET_VARS['test'];
   if (ereg("^[a-z]+$",$X)){ $T = $X; }
}
if (!isset($T)){ $T = 'all'; }

if (isset($HTTP_GET_VARS['lang'])
      && strlen($HTTP_GET_VARS['lang']) && (strlen($HTTP_GET_VARS['lang']) <= $NAME_LEN)){
   $X = $HTTP_GET_VARS['lang'];
   if (ereg("^[a-z0-9]+$",$X)){ $L = $X; }
}
if (!isset($L)){ $L = 'all'; }


if ($L2 == 'lang'){ $L2 = $L; }
else {
   if (isset($HTTP_GET_VARS['lang2'])
         && strlen($HTTP_GET_VARS['lang2']) && (strlen($HTTP_GET_VARS['lang2']) <= $NAME_LEN)){
      $X = $HTTP_GET_VARS['lang2'];
      if (ereg("^[a-z0-9]+$",$X)){ $L2 = $X; }
   }
}
if (!isset($L2)){
   if ($L!='all'){ $L2 = $Langs[$L][$LANG_COMPARE]; }
}


// PAGES ///////////////////////////////////////////////////

if ($T=='all'){
   if ($L=='all'){
      require_once(LIB_PATH.'boxplot.php');
   } else {
      if ($L!=$L2){
         require_once(LIB_PATH.'compare.php');
      } else {
        require_once(LIB_PATH.'measurements.php');
      }
   }
} elseif ($L=='all'){
   require_once(LIB_PATH.'performance.php');
} else {
   require_once(LIB_PATH.'program.php');
}
?>



