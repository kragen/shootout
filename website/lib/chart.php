<?
header("Content-type: image/png");

// Copyright (c) Isaac Gouy 2004-2009

// LIBRARIES ////////////////////////////////////////////////

require_once(LIB_PATH.'lib_whitelist.php');
require_once(LIB_PATH.'lib_chart.php');


// DATA ////////////////////////////////////////////////////

list ($Mark,$valid) = ValidMark($HTTP_GET_VARS,TRUE);
list ($Time,$valid) = ValidLog10($HTTP_GET_VARS,'t',$valid);
list ($KB,$valid) = ValidLog10($HTTP_GET_VARS,'k',$valid);


// CHART //////////////////////////////////////////////////

   $barspace = 3;
   $w = 480;
   $h = 225;

   $xo = 65;
   $yo = 16;

   $yscale = 54;
   $barw = 3;
   $barmw = 0;

$im = ImageCreate($w,$h);
list($white,$black,$gray,$bgray,$mgray) = chartColors($im);

if ($valid){
   chartBars($im,$xo,$h-$yo,$yscale,$white,$barw,$barspace,0,$Time);
   chartBars($im,$xo,$h-$yo,$yscale,$black,$barmw,$barw+$barspace,0,$KB);
}

yAxisGrid($im,$xo,$yo,$w,$h,$yscale,$white,$gray,0,log10axis(axis1000()));

// Y AXIS LEGEND
$label = 'ratio to best';
ImageStringUp($im, 2, 5, $h-$yo, $label, $black);
$y = $yo + strlen($label)*CHAR_WIDTH_2 + 16;

$label = 'Time';
ImageStringUp($im, 2, 5, $h-$y-16, $label, $black);
ImageFilledRectangle($im, 11, $h-$y-10, 11+$barw, $h-$y, $white);
$y = $y + strlen($label)*CHAR_WIDTH_2 + 24;

$label = 'Memory';
ImageStringUp($im, 2, 5, $h-$y-16, $label, $black);
ImageFilledRectangle($im, 12, $h-$y-10, 12+$barmw, $h-$y, $black);

xAxisLegend($im,$xo,$w,$h,$black,'program');
chartTitle($im,$w,$black,'Normalized Program Run Time and Memory');
if ($valid){
   chartNotice($im,$w,$white,$Mark);
}

ImageInterlace($im,1);
ImagePng($im);
ImageDestroy($im);
?>