#!/usr/bin/php
<?
// Copyright (c) Isaac Gouy 2009


// CONSTANTS ////////////////////////////////////////////////

define('HTTP_DIR', 'I:/Abyss Web Server/htdocs/websites');
$Sites = array('debian','gp4','u32q');

// FUNCTIONS ///////////////////////////////////////////


function extractLogDates($site,&$percentages){
   $d = HTTP_DIR.'/'.$site.'/code';
   $h = opendir($d)
      or die("Couldn't open $d");

   $fs = array();
   while ($each = readdir($h)){
      if (preg_match('/\.log$/i',$each)){
         $fs[] = $d.'/'.$each;
      }
   }
   
   $sitelist = includes($site);

   $sum = 0.0;
   foreach ($fs as $each){
      $parts = explode(".",$each);
      $lang = $parts[2];
      if (isset($sitelist[$lang])){

         $fp = @fopen($each,"r")
            or die("Couldn't open $each");

         while ($line = fgets($fp, 128))
            if ($found = preg_match('/([A-Z][a-z]{2})[0-9A-Z\s\:]+(\d{4})/', $line,$match))
               break;

         if ($found){
            $sum++;
            $mth = month($match[1]);
            $yr = intval($match[2]);
            if (!isset($percentages[$yr][$mth][$site])){
               $percentages[$yr][$mth][$site] = 0;
            } else {
               $percentages[$yr][$mth][$site] += 1;
            }
         }

         fclose($fp)
            or die("Couldn't close $each");
      }
   }

   foreach ($percentages as $yr => $mths)
      foreach ($mths as $mth => $counts)
         if (isset($counts[$site]))
            printf("%d,%d,%s,%0.2f\n",$yr,$mth,$site,$counts[$site]/$sum);

   closedir($h);
}


function month($s){
   switch ($s){
      case "Jan": return 1;
      case "Feb": return 2;
      case "Mar": return 3;
      case "Apr": return 4;
      case "May": return 5;
      case "Jun": return 6;
      case "Jul": return 7;
      case "Aug": return 8;
      case "Sep": return 9;
      case "Oct": return 10;
      case "Nov": return 11;
      case "Dec": return 12;
      default: echo $s, '\n';
   }
}

define('INCL_LINK',0);

function includes($site){
   $a = array();
   $f = @fopen(HTTP_DIR.'/'.$site.'/include.csv','r') or die('Cannot open ./include.csv');
   $row = @fgetcsv($f,1024,','); // heading row
   while (!@feof ($f)){
      $row = @fgetcsv($f,1024,',');
      if (!is_array($row)){ continue; }
      if (isset($row[INCL_LINK]{0})){ $a[ $row[INCL_LINK] ] = 0; }
   }
   @fclose($f);
   return $a;
}



// MAIN ////////////////////////////////////////////////

$percentages = array();
foreach ($Sites as $each){
   extractLogDates($each,$freq);
}
