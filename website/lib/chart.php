<?
header("Content-type: image/png");

// Copyright (c) Isaac Gouy 2004-2009

// LIBRARIES ////////////////////////////////////////////////

require_once(LIB_PATH.'lib_whitelist.php');
require_once(LIB_PATH.'lib_chart.php');


// DATA ////////////////////////////////////////////////////

list ($Mark,$valid) = ValidMark($HTTP_GET_VARS,TRUE);

list ($Time,$valid) = ValidMatrix($HTTP_GET_VARS,'t',1,$valid);
for ($i=0;$i<sizeof($Time);$i++) $Time[$i] = log10($Time[$i]);

list ($KB,$valid) = ValidMatrix($HTTP_GET_VARS,'k',1,$valid);
for ($i=0;$i<sizeof($KB);$i++) $KB[$i] = log10($KB[$i]);

// CHART //////////////////////////////////////////////////

   $barspace = 3;
   $w = 480;
   $h = 225;

   $xo = 48;
   $yo = 16;

   $yscale = 64;
   $barw = 3;
   $barmw = 0;

$im = ImageCreate($w,$h);
$c = chartColors($im);
              
yAxisGrid($im,$xo,$yo,$w,$h,$yscale,$c,0,log10axis(axis1000()));

if ($valid){
   chartBars($im,$xo,$h-$yo,$yscale,$c,'gray',$barw,$barspace,0,$Time);
   chartBars($im,$xo,$h-$yo,$yscale,$c,'black',$barmw,$barw+$barspace,0,$KB);
   chartNotice($im,$w,$h,$c,$Mark);
}

// Y AXIS LEGEND
$label = 'ratio to best';
ImageStringUp($im, 2, 5, $h-$yo, $label, $c['black']);
$y = $yo + strlen($label)*CHAR_WIDTH_2 + 16;

$label = 'Time';
ImageStringUp($im, 2, 5, $h-$y-8, $label, $c['black']);
ImageFilledRectangle($im, 11, $h-$y-4, 11+$barw, $h-$y+6, $c['gray']);
$y = $y + strlen($label)*CHAR_WIDTH_2 + 18;

$label = 'Memory';
ImageStringUp($im, 2, 5, $h-$y-8, $label, $c['black']);
ImageFilledRectangle($im, 12, $h-$y-4, 12+$barmw, $h-$y+6, $c['black']);

xAxisLegend($im,$xo,$w,$h,$c,'program');
chartTitle($im,$xo,$w,$c,'Normalized Program Run Time and Memory');


ImageInterlace($im,1);
ImagePng($im);
ImageDestroy($im);
?>