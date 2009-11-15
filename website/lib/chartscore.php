<?
header("Content-type: image/png");

// Copyright (c) Isaac Gouy 2004-2009

// LIBRARIES ////////////////////////////////////////////////

require_once(LIB_PATH.'lib_whitelist.php');
require_once(LIB_PATH.'lib_chart.php');

SetChartCacheControl();


// DATA ////////////////////////////////////////////////////

list ($Mark,$valid) = ValidMark($HTTP_GET_VARS,TRUE);

list ($Values,$valid) = ValidMatrix($HTTP_GET_VARS,'g',1,$valid);
for ($i=0;$i<sizeof($Values);$i++) $Values[$i] = log10($Values[$i]);


// CHART /////////////////////////////////////////////////////

$chart = new BarChart();
$chart->yAxis(log10axis(axis1000()));

if ($valid){
   $chart->bars(GRAY,$Values);
   $chart->notice($Mark);
}

$chart->xAxisLegend('language implementation');
$chart->title('Weighted Geometric Mean   Time-used, Memory-used, Code-used');
$chart->frame();
$chart->complete();

?>
