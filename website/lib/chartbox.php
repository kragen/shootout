<?
header("Content-type: image/png");

// Copyright (c) Isaac Gouy 2009

// LIBRARIES ////////////////////////////////////////////////

require_once(LIB_PATH.'lib_whitelist.php');
require_once(LIB_PATH.'lib_chart.php');

list($in,$ex) = WhiteListInEx();
$WhiteListLangs = WhiteListUnique('lang.csv',$in);


// DATA ////////////////////////////////////////////////////

list ($Mark,$valid) = ValidMark($HTTP_GET_VARS,TRUE);
list ($BackText,$valid) = ValidLangs($HTTP_GET_VARS,$WhiteListLangs,$valid);
list ($Stats,$valid) = ValidMatrix($HTTP_GET_VARS,'s',STATS_SIZE,$valid);
for ($i=0;$i<sizeof($Stats);$i++) $Stats[$i] = log10($Stats[$i]);

// CHART /////////////////////////////////////////////////////
   $w = 480;
   $h = 300;

   $boxspace = 8;
   $xo = 48;
   $yo = MARGIN;

   $boxwidth = 20;
   $boxo = 10;
   $whisk = floor(($boxwidth - $boxo)/2);
   $outlier = 5;
   $maxboxes= 15;



$chart = new BoxChart($w,$h,log10axis(axis3000()),$xo);
$chart->yAxisGrid();

if ($valid){
   $chart->backgroundText($boxwidth+$boxspace,$maxboxes,$BackText);
   $chart->boxAndWhiskers($boxwidth,$boxspace,$boxo,$maxboxes,$Stats);  
   $chart->notice($Mark);
}

$chart->xAxisLegend($w,$h,'language implementation');
$chart->yAxisLegend($w,$h,'ratio to best');
$chart->title('Normalized Program Run Time - Median and Quartiles');
$chart->frame();
$chart->complete();

?>
