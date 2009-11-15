<?
header("Content-type: image/png");
// Copyright (c) Isaac Gouy 2009

// LIBRARIES ////////////////////////////////////////////////

require_once(LIB_PATH.'lib_whitelist.php');
require_once(LIB_PATH.'lib_chart.php');

SetChartCacheControl();

list($in,$ex) = WhiteListInEx();
$WhiteListTests = WhiteListUnique('test.csv',$in);

// DATA ////////////////////////////////////////////////////

list ($Mark,$valid) = ValidMark($HTTP_GET_VARS,TRUE);
list ($BackText,$valid) = ValidTests($HTTP_GET_VARS,$WhiteListTests,$valid);
list ($Stats,$valid) = ValidMatrix($HTTP_GET_VARS,'s',STATS_SIZE,$valid);
for ($i=0;$i<sizeof($Stats);$i++) $Stats[$i] = log10($Stats[$i]);


// CHART /////////////////////////////////////////////////////

$chart = new BoxChart();
$chart->yAxis(log10axis(axisT()));

if ($valid){
   $chart->autoBoxspace($Stats);
   $chart->backgroundText($BackText);
   $chart->boxAndWhiskers($Stats);
   $chart->notice($Mark);
}

$chart->yAxisLegend('program sys + usr',224);
$chart->xAxisLegend('benchmark');
$chart->title('Time-used   Median and Quartiles by Benchmark');
$chart->frame();
$chart->complete();

?>
