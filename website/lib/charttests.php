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
list ($Stats,$valid) = ValidMatrix($HTTP_GET_VARS,'s',STATS_SIZE,$valid);
for ($i=0;$i<sizeof($Stats);$i++) $Stats[$i] = log10($Stats[$i]);


// CHART /////////////////////////////////////////////////////
   $w = 480;
   $h = 300;

   $xo = 48;
   $yo = MARGIN;

   $boxw = 20;
   $boxo = 10;
   $whisk = floor(($boxw - $boxo)/2);
   $outlier = 5;
   $maxboxes = 17;

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
$c = chartColors($im);

$yaxis = log10axis(axisT());
list($yscale,$yshift) = scaleAndShift($yo,$h,$yaxis);
yAxisGrid($im,$xo,$yo,$w,$h,$yscale,$c,$yshift,$yaxis);

xAxisLegend($im,$xo,$w,$h,$c,'benchmark');

$label = 'program sys + usr';
ImageStringUp($im, 2, 0, $h-72, $label, $c['black']);

if ($valid){
   chartBackground($im,$xo,$h-12,$h-15,$c,$boxw+$boxspace,$maxboxes,$BackText);
   chartBoxes($im,$xo,$yo,$h,$yscale,$c,$boxw,$boxspace,$boxo,$maxboxes,abs($yshift),$Stats);
   chartWhiskers($im,$xo,$yo,$h,$yscale,$c,$boxw,$boxspace,$boxo,$maxboxes,abs($yshift),$Stats);
   chartNotice($im,$w,$h,$c,$Mark);
}

chartFrame($im,$xo,$yo,$w,$h,$c);

chartTitle($im,$xo,$w,$c,
   'Program Run Time - Median and Quartiles - by Benchmark');

ImageInterlace($im,1);
ImagePNG($im);
ImageDestroy($im);
?>
