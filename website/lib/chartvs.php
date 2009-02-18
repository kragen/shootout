<?
header("Content-type: image/png");

// Copyright (c) Isaac Gouy 2004-2009

// LIBRARIES ////////////////////////////////////////////////

require_once(LIB_PATH.'lib_whitelist.php');
require_once(LIB_PATH.'lib_chart.php');

list($in,$ex) = WhiteListInEx();
$WhiteListLangs = WhiteListUnique('lang.csv',$in);

// DATA ////////////////////////////////////////////////////

list ($Mark,$valid) = ValidMark($HTTP_GET_VARS,TRUE);
list ($LangName,$valid) = ValidLangs($HTTP_GET_VARS,$WhiteListLangs,$valid);

define('RATIOS_SIZE',3);
define('RATIOS_SECS',0);
define('RATIOS_KB',1);
define('RATIOS_GZ',2);
list ($Matrix,$valid) = ValidMatrix($HTTP_GET_VARS,'r',RATIOS_SIZE,$valid);

$secs = array();
$kb = array();
$gz = array();

$n = sizeof($Matrix);
if ($n%RATIOS_SIZE == 0){
   for ($i=0; $i<$n; $i+=RATIOS_SIZE){
      $secs[] = log10($Matrix[$i+RATIOS_SECS]);
      $kb[] = log10($Matrix[$i+RATIOS_KB]);
      $gz[] = log10($Matrix[$i+RATIOS_GZ]);
   }
}
unset($Matrix);
sort($secs);
sort($kb);
sort($gz);
$n = sizeof($secs);

// CHART //////////////////////////////////////////////////

   $barspace = 3;
   $w = 480;
   $h = 300;

   $xo = 48;
   $yo = 150;

   $yscale = 44.0;
   $barw = 5;
   $barmw = 0;

   $gap = 20;


$im = ImageCreate($w,$h);
$c = chartColors($im);

$yaxis = log10axis(axis3_10());
yAxisGrid($im,$xo,$yo,$w,$h,$yscale,$c,0,$yaxis);
yAxisGrid($im,$xo,$yo,$w,$h,$yscale,$c,0,$yaxis,'down');

if ($valid){
   $x = $xo;
   $x1 = $x;
   $x = chartBars($im,$x,$h-$yo,$yscale,$c,'dkgray',$barw,$barspace,0,$secs);
   
   $label = 'Time';
   $z = $x1 + ($x-$x1-strlen($label)*CHAR_WIDTH_2)/2.0;
   ImageString($im, 2, $z, $h-30, $label, $c['black']);

   $x += $gap;
   $x1 = $x;
   $x = chartBars($im,$x,$h-$yo,$yscale,$c,'black',$barmw,4+$barspace,0,$kb);

   $label = 'Memory Use';
   $z = $x1 + ($x-$x1-strlen($label)*CHAR_WIDTH_2)/2.0;
   ImageString($im, 2, $z, $h-30, $label, $c['black']);

   $x += $gap;
   $x1 = $x;
   $x = chartBars($im,$x,$h-$yo,$yscale,$c,'dkgray',$barw,$barspace,0,$gz,FALSE);

   $label = 'Source Size';
   $z = $x1 + ($x-$x1-strlen($label)*CHAR_WIDTH_2)/2.0;
   ImageString($im, 2, $z, $h-30, $label, $c['black']);

   chartNotice($im,$w,$h,$c,$Mark);
}

yAxisLegend($im,15,$w,$h,$c,'worse ratio       better ratio');


/*

// Y AXIS LEGEND
$labela = 'Time';
$labelb = 'Memory';
$y = ($h-strlen($labela.$labelb)*CHAR_WIDTH_2 -14)/2;
$y0 = $y;
ImageStringUp($im, 2, 5, $h-$y-4, $labela, $black);
ImageFilledRectangle($im, 11, $h-$y, 11+$barw, $h-$y+12, $white);
$y = $y + strlen($labela)*CHAR_WIDTH_2 + 22;
ImageStringUp($im, 2, 5, $h-$y-4, $labelb, $black);
ImageFilledRectangle($im, 12, $h-$y, 12+$barmw, $h-$y+10, $black);


$labela = 'worse';
$labelb = 'Source size';
$y = $y0;
ImageStringUp($im, 2, $w-20, $h-$y-4, $labela, $black);
ImageFilledRectangle($im, $w-20+6, $h-$y, $w-20+6+$barw, $h-$y+12, $mgray);
$y = $y + strlen($labela)*CHAR_WIDTH_2 + 22;
ImageStringUp($im, 2, $w-20, $h-$y-4, $labelb, $black);
ImageRectangle($im, $w-20+6, $h-$y, $w-20+6+$barw, $h-$y+10, $white);



 */

if ($valid){
   chartTitle($im,$xo,$w,$c,$LangName[0].' worse-to-better compared to '.$LangName[1]);
   chartNotice($im,$w,$h,$c,$Mark);
}

ImageInterlace($im,1);
ImagePng($im);
ImageDestroy($im);
?>