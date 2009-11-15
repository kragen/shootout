<?
header("Content-type: image/png");

// Copyright (c) Isaac Gouy 2009

// LIBRARIES ////////////////////////////////////////////////

require_once(LIB_PATH.'lib_whitelist.php');
require_once(LIB_PATH.'lib_chart.php');

SetChartCacheControl();

list($in,$ex) = WhiteListInEx();
$WhiteListLangs = WhiteListUnique('lang.csv',$in);


// DATA ////////////////////////////////////////////////////

list ($Mark,$valid) = ValidMark($HTTP_GET_VARS,TRUE);
list ($BackText,$valid) = ValidLangs($HTTP_GET_VARS,$WhiteListLangs,$valid);
list ($Stats,$valid) = ValidMatrix($HTTP_GET_VARS,'s',STATS_SIZE,$valid);
for ($i=0;$i<sizeof($Stats);$i++) $Stats[$i] = log10($Stats[$i]);

// CHART /////////////////////////////////////////////////////

$chart = new BoxChart();
$chart->yAxis(log10axis(axis3000()));

if ($valid){
   $chart->backgroundText($BackText);
   $chart->boxAndWhiskers($Stats);
   $chart->notice($Mark);
}

$chart->xAxisLegend('language implementation');
$chart->title('Normalized Time-used - Median and Quartiles');
$chart->frame();
$chart->complete();

?>
