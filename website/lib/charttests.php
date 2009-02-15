<?
header("Content-type: image/png");
// Copyright (c) Isaac Gouy 2009

// LIBRARIES ////////////////////////////////////////////////

require_once(LIB_PATH.'lib_whitelist.php');
require_once(LIB_PATH.'lib_chart.php');

list($in,$ex) = WhiteListInEx();
$WhiteListTests = WhiteListUnique('test.csv',$in);

// DATA ////////////////////////////////////////////////////

list ($Mark,$valid) = ValidMark($HTTP_GET_VARS,TRUE);
list ($BackText,$valid) = ValidTests($HTTP_GET_VARS,$WhiteListTests,$valid);
list ($Stats,$valid) = ValidStats($HTTP_GET_VARS,'s',$valid);


// CHART /////////////////////////////////////////////////////
   $w = 480;
   $h = 300;

   $xo = 65;
   $yo = 16;

   $yscale = 48;

   $boxw = 20;
   $boxo = 10;
   $whisk = floor(($boxw - $boxo)/2);
   $outlier = 5;
   $maxboxes = 17;

   $yshift = 1;

if ($valid){
// SPACE OUT BARS ACROSS WIDTH
   $boxspace = 4;
   if (sizeof($Stats)>0){
      $n = sizeof($Stats)/STATS_SIZE;
      $i = 1;
      while ($n*($boxw+$i) <= $w-$xo){ $i++; }
      $boxspace = $i-1;
   }
}

$im = ImageCreate($w,$h);
list($white,$black,$gray,$bgray,$mgray) = chartColors($im);

if ($valid){
   chartBackground($im,$xo-CHAR_WIDTH_2,$h-12,$h-42,$mgray,$boxw+$boxspace,$maxboxes,$BackText);
   chartBoxes($im,$xo,$yo,$h,$yscale,$white,$boxw,$boxspace,$boxo,$maxboxes,1,$Stats);
}

yAxisGrid($im,$xo,$yo,$w,$h,$yscale,$white,$gray,$yshift,log10axis(axisT()));
yAxisLegend($im,-64,$w,$h,$black,'program sys + usr');
xAxisLegend($im,$xo,$w,$h,$black,'benchmark');

if ($valid){
   chartWhiskers($im,$xo,$yo,$h,$yscale,$white,$boxw,$boxspace,$boxo,$maxboxes,$black,1,$Stats);
}

chartTitle($im,$w,$black,
   'Program Run Time - Median and Quartiles - by Benchmark');

if ($valid){
   chartNotice($im,$w,$white,$Mark);
}

ImageInterlace($im,1);
ImagePNG($im);
ImageDestroy($im);
?>
