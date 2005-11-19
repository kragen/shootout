#!/usr/bin/php 
<?
// Copyright (c) Isaac Gouy 2005

// Used PHP because I know it somewhat - should rewrite in Perl

// LIBRARIES ////////////////////////////////////////////////

require_once('../website/lib/lib_common.php'); 

define('DESC_PATH', '../website/desc/');
define('CODE_PATH', '../website/code/');


// FUNCTIONS ///////////////////////////////////////////


function ReadUnique($FileName,$HasHeading=TRUE){
   if (file_exists('./'.$FileName)){
      $f = @fopen('./'.$FileName,'r') or die('Cannot open '.$FileName);
   } else {
      $f = @fopen(DESC_PATH.$FileName,'r') or die('Cannot open '.$FileName);
   }

   if ($HasHeading){ $row = @fgetcsv($f,1024,','); }

   while (!@feof ($f)){
      $row = @fgetcsv($f,1024,',');
      if (!is_array($row)){ continue; }
     
      $rows[ $row[0] ] = $row;     
   }
   @fclose($f);
   return $rows;
}


// MAIN //////////////////////////////////////////////// 

// are we measuring on Gentoo or Debian?
if (preg_match("/gp4/i",`pwd`)){ $url = "http://shootout.alioth.debian.org/gp4/"; } 
else { $url = "http://shootout.alioth.debian.org/"; }

$dirName = CODE_PATH;
$cutoff = filemtime('timestamp');

$Tests = ReadUnique('test.csv');
$Langs = ReadUnique('lang.csv');

// get test and lang from most recently updated logfiles
$dh = opendir($dirName);
while ($file = readdir($dh)){
   if (preg_match("/([a-z]*)-([a-z]*)(\S*)\.log$/i",$file,$matches) 
      && filemtime($dirName.$file) > $cutoff){

      $lang = $matches[2];
      $test = $matches[1];
      if (!isset($testNames[$lang])) $testNames[$lang] = array();
      $testNames[$lang][$test] = $Tests[$test][TEST_NAME];
   }
}
closedir($dh);

// use pretty test and lang names to make RSS items
foreach($testNames as $lang => $ar){   
   asort($ar);
   foreach($ar as $k => $v){ 
      if (isset($desc)){ $desc = $desc.', '.$v; } else { $desc = $v; }
   }
   $langName = $Langs[$lang][LANG_FULL];

      // Is there a short URL for this language?
   if (strlen($Langs[$lang][LANG_SPECIALURL])>0){ 
      $link = $url.$Langs[$lang][LANG_SPECIALURL].".php";
   } else {
      $link = $url."benchmark.php?test=all&amp;lang=".$lang;
   }

   printf("<item><title>%s measurements</title>",$langName);
   printf("<description>%s</description>",$desc);
   printf("<link>%s</link></item>\n",$link);

   unset($desc);
}

?>
