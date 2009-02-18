<?
header("Content-type: image/png");

// Copyright (c) Isaac Gouy 2009

// LIBRARIES ////////////////////////////////////////////////

require_once(LIB_PATH.'lib_whitelist.php');
require_once(LIB_PATH.'lib_chart.php');

list($in,$ex) = WhiteListInEx();
$WhiteListLangs = WhiteListUnique('lang.csv',$in);


// DATA ////////////////////////////////////////////////////

list ($Mark,$valid) = ValidMark($HTTP_GET_VARS,TRUE);
list ($BackText,$valid) = ValidLangs($HTTP_GET_VARS,$WhiteListLangs,$valid);
list ($Stats,$valid) = ValidMatrix($HTTP_GET_VARS,'s',STATS_SIZE,$valid);
for ($i=0;$i<sizeof($Stats);$i++) $Stats[$i] = log10($Stats[$i]);

// CHART /////////////////////////////////////////////////////
   $w = 480;
   $h = 300;

   $boxspace = 8;
   $xo = 48;
   $yo = 16;

   $yscale = 76;

   $boxw = 20;
   $boxo = 10;
   $whisk = floor(($boxw - $boxo)/2);
   $outlier = 5;
   $maxboxes= 15;

$im = ImageCreate($w,$h);
$c = chartColors($im);

// GRID
yAxisGrid($im,$xo,$yo,$w,$h,$yscale,$c,0,log10axis(axis3000()));
yAxisLegend($im,$yo,$w,$h,$c,'ratio to best');
xAxisLegend($im,$xo,$w,$h,$c,'language implementation');

if ($valid){
   chartBackground($im,$xo,$h-12,$h-27,$c,$boxw+$boxspace,$maxboxes,$BackText);
   chartBoxes($im,$xo,$yo,$h,$yscale,$c,$boxw,$boxspace,$boxo,$maxboxes,0,$Stats);
   chartWhiskers($im,$xo,$yo,$h,$yscale,$c,$boxw,$boxspace,$boxo,$maxboxes,0,$Stats);
   chartNotice($im,$w,$h,$c,$Mark);
}

chartTitle($im,$xo,$w,$c,
   'Normalized Program Run Time - Median and Quartiles');




ImageInterlace($im,1);
ImagePNG($im);
ImageDestroy($im);
?>
