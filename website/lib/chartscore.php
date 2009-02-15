<?
header("Content-type: image/png");

// Copyright (c) Isaac Gouy 2004-2009

// LIBRARIES ////////////////////////////////////////////////

require_once(LIB_PATH.'lib_whitelist.php');
require_once(LIB_PATH.'lib_chart.php');


// DATA ////////////////////////////////////////////////////

list ($Mark,$valid) = ValidMark($HTTP_GET_VARS,TRUE);
list ($GeometricMean,$valid) = ValidLog10($HTTP_GET_VARS,'g',$valid);


// CHART /////////////////////////////////////////////////////

   $barspace = 3;
   $w = 480;
   $h = 225;

   $xo = 65;
   $yo = 16;

   $yscale = 84;
   $barw = 3;

$im = ImageCreate($w,$h);
list($white,$black,$gray,$bgray,$mgray) = chartColors($im);

if ($valid){
   chartBars($im,$xo,$h-$yo,$yscale,$white,$barw,$barspace,0,$GeometricMean);
}

yAxisGrid($im,$xo,$yo,$w,$h,$yscale,$white,$gray,0,log10axis(axis100()));
yAxisLegend($im,$yo,$w,$h,$black,'ratio to best');
xAxisLegend($im,$xo,$w,$h,$black,'language implementation');
chartTitle($im,$w,$black,
   'Weighted Geometric Mean of normalized Time, Memory and Source size');

if ($valid){
   chartNotice($im,$w,$white,$Mark);
}

ImageInterlace($im,1);
ImagePNG($im);
ImageDestroy($im);
?>
