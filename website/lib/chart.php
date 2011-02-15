<?
header("Content-type: image/png");

// Copyright (c) Isaac Gouy 2004-2011

// LIBRARIES ////////////////////////////////////////////////

require_once(LIB_PATH.'lib_whitelist.php');
require_once(LIB_PATH.'lib_chart.php');

SetChartCacheControl();

$in = WhiteListIn();
$WhiteListTests = WhiteListUnique('test.csv',$in);


// DATA ////////////////////////////////////////////////////

list ($Mark,$valid) = ValidMark($HTTP_GET_VARS,TRUE);
list ($Test,$valid) = ValidTests($HTTP_GET_VARS,$WhiteListTests,$valid);

list ($Time,$valid) = ValidMatrix($HTTP_GET_VARS,'r',1,$valid);
for ($i=0;$i<sizeof($Time);$i++) $Time[$i] = log10($Time[$i]);

// CHART //////////////////////////////////////////////////

   $barspace = 3;
   $w = 480;
   $h = 225;

   $xo = 48;
   $yo = MARGIN;

   $barw = 3;
   $barmw = 0;


$chart = new BarChart();
$chart->yAxis(log10axis(axis1000()));

if ($valid){
   $chart->bars(GRAY,$Time);
   $chart->barspace = $chart->barwidth + $chart->barspace;
   $chart->barwidth = 0;
   $chart->notice($Mark);
   $chart->xAxisLegend('selected'.$Test[0].' programs');
}


// Y AXIS LEGEND

//$chart->title('How many times slower than the fastest program?');
$chart->frame();
$chart->complete();

?>
