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
list ($Sort,$valid) = ValidSort($HTTP_GET_VARS,$valid);
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

   if ($Sort=='fullcpu'){
      $titletext = $Test[0].' - How many times slower? (CPU secs)';
      $yaxistext = 'program time ÷ fastest program';
   } elseif ($Sort=='kb'){
      $titletext = $Test[0].' - How many times more memory?';
      $yaxistext = 'program memory-used ÷ smallest program';
   } elseif ($Sort=='elapsed'){
      $titletext = $Test[0].' - How many times slower? (Elapsed secs)';
      $yaxistext = 'program time ÷ fastest program';
   } elseif ($Sort=='gz'){ 
      $titletext = $Test[0].' - How many times more source code?';
      $yaxistext = 'program source code ÷ smallest program';
   }
   $chart->yAxisLegend($yaxistext);
   $chart->title($titletext);
}

$chart->frame();
$chart->complete();

?>
