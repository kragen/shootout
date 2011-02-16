<?
header("Content-type: image/png");

// Copyright (c) Isaac Gouy 2004-2011

// LIBRARIES ////////////////////////////////////////////////

require_once(LIB_PATH.'lib_whitelist.php');
require_once(LIB_PATH.'lib_chart.php');

SetChartCacheControl();

$in = WhiteListIn();
$WhiteListTests = WhiteListUnique('test.csv',$in);
$WhiteListLangs = WhiteListUnique('lang.csv',$in);


// DATA ////////////////////////////////////////////////////

list ($Mark,$valid) = ValidMark($HTTP_GET_VARS,TRUE);
list ($Sort,$valid) = ValidSort($HTTP_GET_VARS,TRUE);
list ($Test,$valid) = ValidTests($HTTP_GET_VARS,$WhiteListTests,$valid);
list ($BackText,$valid) = ValidLangs($HTTP_GET_VARS,$WhiteListLangs,$valid);

list ($Ratios,$valid) = ValidMatrix($HTTP_GET_VARS,'r',1,$valid);
for ($i=0;$i<sizeof($Ratios);$i++) $Ratios[$i] = log10($Ratios[$i]);

// CHART //////////////////////////////////////////////////

$chart = new WideBarChart();
$chart->yAxis(log10axis(axis1000()));

if ($valid){
   $chart->backgroundText($BackText);
   $chart->bars($Ratios);
   $chart->notice($Mark);
   $chart->xAxisLegend('selected '.$Test[0].' programs');
}


// Y AXIS LEGEND

//$chart->title('How many times slower than the fastest program?');
$chart->frame();
$chart->complete();

?>
