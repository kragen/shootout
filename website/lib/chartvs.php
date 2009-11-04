<?
header("Content-type: image/png");

// Copyright (c) Isaac Gouy 2004-2009

// LIBRARIES ////////////////////////////////////////////////

require_once(LIB_PATH.'lib_whitelist.php');
require_once(LIB_PATH.'lib_chart.php');

SetChartCacheControl();

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

$chart = new ComparisonChart();
$chart->yo = $chart->h / 2;
$scale = 45.0;
$shift = 0.0;
$chart->yAxis(log10axis(axis3_10()), $scale, $shift);
$chart->yAxis(log10axis(axis3_10_Mirror()), $scale, $shift, MIRROR_AXIS);

if ($valid){

   // TIME PANEL

   $x = $chart->xo;
   $x1 = $x;
   $chart->barwidth = 5;
   $x = $chart->bars(DARK_GRAY,$secs);

   $label = 'Time';
   $z = $x1 + ($x-$x1-strlen($label)*CHAR_WIDTH_2)/2.0;
   ImageString($chart->im, 2, $z, $chart->h - 30, $label, $chart->colour[BLACK]);
   ImageString($chart->im, 2, $z, 23, $label, $chart->colour[BLACK]);

   // MEMORY USE PANEL

   $x += 20;
   $x1 = $x;
   $chart->xo = $x;
   $chart->barspace = 4 + $chart->barspace;
   $chart->barwidth = 0;
   $x = $chart->bars(BLACK,$kb);

   $label = 'Memory Use';
   $z = $x1 + ($x-$x1-strlen($label)*CHAR_WIDTH_2)/2.0;
   ImageString($chart->im, 2, $z, $chart->h - 30, $label, $chart->colour[BLACK]);
   ImageString($chart->im, 2, $z, 23, $label, $chart->colour[BLACK]);

   // SOURCE SIZE PANEL

   $x += 20;
   $x1 = $x;
   $chart->xo = $x;
   $chart->barspace = 3;
   $chart->barwidth = 5;
   $x = $chart->bars(DARK_GRAY,$gz,FALSE);

   $label = 'Source Size';
   $z = $x1 + ($x-$x1-strlen($label)*CHAR_WIDTH_2)/2.0;
   ImageString($chart->im, 2, $z, $chart->h - 30, $label, $chart->colour[BLACK]);
   ImageString($chart->im, 2, $z, 23, $label, $chart->colour[BLACK]);

   $chart->xo = $chart->defaultOriginX();
   $chart->title($LangName[0].' ÷ '.$LangName[1]);
   $chart->notice($Mark);
}

$chart->frame();
$chart->complete();

?>
