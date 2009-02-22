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
   $yo = $h/2;

   $barw = 5;
   $barmw = 0;

   $gap = 20;


$chart = new BarChart($w,$h,log10axis(axis3_10()),$xo,$yo);
$chart->yshift = 0.0;
$chart->yscale = 45.0;
$chart->yAxisGrid();
$chart->yAxisGrid('down');

if ($valid){
   $x = $xo;
   $x1 = $x;
   $x = $chart->bars($x,$barw,$barspace,DARK_GRAY,$secs);

   $label = 'Time';
   $z = $x1 + ($x-$x1-strlen($label)*CHAR_WIDTH_2)/2.0;
   ImageString($chart->im, 2, $z, $h-30, $label, $chart->colour[BLACK]);
   
   $x += $gap;
   $x1 = $x;
   $x = $chart->bars($x,$barmw,4+$barspace,BLACK,$kb);
   
   $label = 'Memory Use';
   $z = $x1 + ($x-$x1-strlen($label)*CHAR_WIDTH_2)/2.0;
   ImageString($chart->im, 2, $z, $h-30, $label, $chart->colour[BLACK]);
   
   $x += $gap;
   $x1 = $x;
   $x = $chart->bars($x,$barw,$barspace,DARK_GRAY,$gz,FALSE);

   $label = 'Source Size';
   $z = $x1 + ($x-$x1-strlen($label)*CHAR_WIDTH_2)/2.0;
   ImageString($chart->im, 2, $z, $h-30, $label, $chart->colour[BLACK]);

   $chart->title($LangName[0].' worse-to-better compared to '.$LangName[1]);
   $chart->notice($Mark);
}

$chart->yAxisLegend($w,$h,'worse ratio       better ratio',15);
$chart->frame();
$chart->complete();

?>