<?
header("Content-type: image/png");

// Copyright (c) Isaac Gouy 2004-2009

// LIBRARIES ////////////////////////////////////////////////

require_once(LIB_PATH.'lib_whitelist.php');
require_once(LIB_PATH.'lib_chart.php');


// DATA ////////////////////////////////////////////////////

list ($Mark,$valid) = ValidMark($HTTP_GET_VARS,TRUE);

list ($Values,$valid) = ValidMatrix($HTTP_GET_VARS,'g',1,$valid);
for ($i=0;$i<sizeof($Values);$i++) $Values[$i] = log10($Values[$i]);


// CHART /////////////////////////////////////////////////////

   $barspace = 3;
   $w = 480;
   $h = 225;

   $xo = 48;
   $yo = 16;

   $yscale = 64;
   $barw = 3;

$im = ImageCreate($w,$h);
$c = chartColors($im);

yAxisGrid($im,$xo,$yo,$w,$h,$yscale,$c,0,log10axis(axis1000()));

if ($valid){
   chartBars($im,$xo,$h-$yo,$yscale,$c,'gray',$barw,$barspace,0,$Values);
   chartNotice($im,$w,$h,$c,$Mark);
}
yAxisLegend($im,$yo,$w,$h,$c,'ratio to best');
xAxisLegend($im,$xo,$w,$h,$c,'language implementation');
chartTitle($im,$xo,$w,$c,
   'Weighted Geometric Mean of normalized Time, Memory and Size');


ImageInterlace($im,1);
ImagePNG($im);
ImageDestroy($im);
?>
