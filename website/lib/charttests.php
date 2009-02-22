<?
header("Content-type: image/png");
// Copyright (c) Isaac Gouy 2009

// LIBRARIES ////////////////////////////////////////////////

require_once(LIB_PATH.'lib_whitelist.php');
require_once(LIB_PATH.'lib_chart.php');

list($in,$ex) = WhiteListInEx();
$WhiteListTests = WhiteListUnique('test.csv',$in);

// DATA ////////////////////////////////////////////////////

list ($Mark,$valid) = ValidMark($HTTP_GET_VARS,TRUE);
list ($BackText,$valid) = ValidTests($HTTP_GET_VARS,$WhiteListTests,$valid);
list ($Stats,$valid) = ValidMatrix($HTTP_GET_VARS,'s',STATS_SIZE,$valid);
for ($i=0;$i<sizeof($Stats);$i++) $Stats[$i] = log10($Stats[$i]);


// CHART /////////////////////////////////////////////////////
   $w = 480;
   $h = 300;

   $xo = 48;
   $yo = MARGIN;

   $boxwidth = 20;
   $boxo = 10;
   $whisk = floor(($boxwidth - $boxo)/2);
   $outlier = 5;
   $maxboxes = 17;


if ($valid){
// SPACE OUT BARS ACROSS WIDTH
   $boxspace = 4;
   if (sizeof($Stats)>0){
      $n = sizeof($Stats)/STATS_SIZE;
      $i = 1;
      while ($n*($boxwidth+$i) <= $w-$xo){ $i++; }
      $boxspace = $i-1;
   }
}


$chart = new BoxChart($w,$h,log10axis(axisT()),$xo);
$chart->yAxisGrid();

if ($valid){
   $chart->backgroundText($boxwidth+$boxspace,$maxboxes,$BackText);
   $chart->boxAndWhiskers($boxwidth,$boxspace,$boxo,$maxboxes,$Stats);    
   $chart->notice($Mark);
}

$chart->yAxisLegend($w,$h,'program sys + usr',-64);
$chart->xAxisLegend($w,$h,'benchmark');
$chart->title('Program Run Time - Median and Quartiles - by Benchmark');
$chart->frame();
$chart->complete();
?>
