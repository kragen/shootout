<?
header("Content-type: image/png");

// Copyright (c) Isaac Gouy 2011

// LIBRARIES ////////////////////////////////////////////////

require_once(LIB_PATH.'lib_whitelist.php');
require_once(LIB_PATH.'lib_chart.php');

SetChartCacheControl();

$in = WhiteListIn();
$WhiteListLangs = WhiteListUnique('lang.csv',$in);


// DATA LAYOUT ///////////////////////////////////////////////////

define('STATS_SIZE',8);
define('STAT_MIN',0);
define('STAT_XLOWER',1);
define('STAT_LOWER',2);
define('STAT_MEDIAN',3);
define('STAT_UPPER',4);
define('STAT_XUPPER',5);
define('STAT_MAX',6);
define('STATS_N',7);


// DATA ////////////////////////////////////////////////////

list ($Mark,$valid) = ValidMark($HTTP_GET_VARS,TRUE);
list ($BackText,$valid) = ValidLangs($HTTP_GET_VARS,$WhiteListLangs,$valid);
list ($Stats,$valid) = ValidMatrix($HTTP_GET_VARS,'s',STATS_SIZE,$valid);
for ($i=0;$i<sizeof($Stats);$i++) $Stats[$i] = $Stats[$i] - 1;

// CHART /////////////////////////////////////////////////////

$chart = new BoxChart();
$chart->yAxis(axis100simple());

if ($valid){
   $chart->backgroundText($BackText);
   $chart->boxAndWhiskers($Stats);
   $chart->notice($Mark);
}

$chart->xAxisLegend('language implementation');
$chart->title('Normalized Time-used   Median and Quartiles');
$chart->frame();
$chart->complete();

?>
