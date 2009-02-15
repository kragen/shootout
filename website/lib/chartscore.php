<?
header("Content-type: image/png");

// Copyright (c) Isaac Gouy 2004-2009

// LIBRARIES ////////////////////////////////////////////////

require_once(LIB_PATH.'lib_whitelist.php');
require_once(LIB_PATH.'lib_chart.php');


// DATA ////////////////////////////////////////////////////

$D = array();
if (isset($HTTP_GET_VARS['d'])
      && (strlen($HTTP_GET_VARS['d']) && (strlen($HTTP_GET_VARS['d']) <= 512))){
   $X = $HTTP_GET_VARS['d'];
   if (ereg("^[0-9o]+$",$X)){
      foreach(explode('o',$X) as $v){
         if (strlen($v) && (strlen($v) <= 5)){ $D[] = log10(doubleval($v)/10.0); }
      }
   }
}

$Mark = ValidMark($HTTP_GET_VARS);

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

chartBars($im,$xo,$h-$yo,$yscale,$white,$barw,$barspace,0,$D);

yAxisGrid($im,$xo,$yo,$w,$h,$yscale,$white,$gray,0,log10axis(axis100()));
yAxisLegend($im,$yo,$w,$h,$black,'ratio to best');
xAxisLegend($im,$xo,$w,$h,$black,'language implementation');
chartTitle($im,$w,$black,
   'Weighted Geometric Mean of normalized Time, Memory and Source size');
chartNotice($im,$w,$white,$Mark);


ImageInterlace($im,1);
ImagePNG($im);
ImageDestroy($im);
?>
