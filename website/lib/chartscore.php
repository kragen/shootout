<?
header("Content-type: image/png");

// Copyright (c) Isaac Gouy 2004-2011

// LIBRARIES ////////////////////////////////////////////////

require_once(LIB_PATH.'lib_whitelist.php');
require_once(LIB_PATH.'lib_chart.php');

SetChartCacheControl();

$in = WhiteListIn();
$WhiteListLangs = WhiteListUnique('lang.csv',$in);

// DATA ////////////////////////////////////////////////////

list ($Mark,$valid) = ValidMark($HTTP_GET_VARS,TRUE);
list ($BackText,$valid) = ValidLangs($HTTP_GET_VARS,$WhiteListLangs,$valid);
list ($Values,$valid) = ValidMatrix($HTTP_GET_VARS,'g',1,$valid);
//for ($i=0;$i<sizeof($Values);$i++) $Values[$i] = log10($Values[$i]);


// CHART /////////////////////////////////////////////////////

$chart = new WideBarChart();
$chart->yAxis(axis10());

if ($valid){
   $chart->backgroundText($BackText);
   $chart->bars($Values);
   $chart->notice($Mark);
}

$chart->xAxisLegend('selected language implementations');
$chart->yAxisLegend('Weighted Geometric Mean - lowest is best');
$chart->title('Ten tiny tasks - How many times better?');
$chart->frame();
$chart->complete();

?>
