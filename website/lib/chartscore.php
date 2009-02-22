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
   $yo = MARGIN;

   $barw = 3;

$chart = new BarChart($w,$h,log10axis(axis1000()),$xo);
$chart->yAxisGrid();

if ($valid){
   $chart->bars($xo,$barw,$barspace,GRAY,$Values);
   $chart->notice($Mark);
}

$chart->xAxisLegend($w,$h,'language implementation');
$chart->yAxisLegend($w,$h,'ratio to best');
$chart->title('Weighted Geometric Mean of normalized Time, Memory and Size');
$chart->frame();
$chart->complete();

?>
