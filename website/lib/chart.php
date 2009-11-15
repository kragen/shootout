<?
header("Content-type: image/png");

// Copyright (c) Isaac Gouy 2004-2009

// LIBRARIES ////////////////////////////////////////////////

require_once(LIB_PATH.'lib_whitelist.php');
require_once(LIB_PATH.'lib_chart.php');

SetChartCacheControl();

list($in,$ex) = WhiteListInEx();
$WhiteListTests = WhiteListUnique('test.csv',$in);


// DATA ////////////////////////////////////////////////////

list ($Mark,$valid) = ValidMark($HTTP_GET_VARS,TRUE);
list ($Test,$valid) = ValidTests($HTTP_GET_VARS,$WhiteListTests,$valid);

list ($Time,$valid) = ValidMatrix($HTTP_GET_VARS,'t',1,$valid);
for ($i=0;$i<sizeof($Time);$i++) $Time[$i] = log10($Time[$i]);

list ($KB,$valid) = ValidMatrix($HTTP_GET_VARS,'k',1,$valid);
for ($i=0;$i<sizeof($KB);$i++) $KB[$i] = log10($KB[$i]);

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
   $chart->bars(BLACK,$KB);
   $chart->notice($Mark);
   $chart->xAxisLegend($Test[0].' programs');
}


// Y AXIS LEGEND

$label = 'ratio to best';
ImageStringUp($chart->im, 2, 5, $h-$yo, $label, $chart->colour[BLACK]);
$y = $yo + strlen($label)*CHAR_WIDTH_2 + 16;

$label = 'Time';
ImageStringUp($chart->im, 2, 5, $h-$y-8, $label, $chart->colour[BLACK]);
ImageFilledRectangle($chart->im, 11, $h-$y-4, 11+$barw, $h-$y+6, $chart->colour[GRAY]);
$y = $y + strlen($label)*CHAR_WIDTH_2 + 18;

$label = 'Memory';
ImageStringUp($chart->im, 2, 5, $h-$y-8, $label, $chart->colour[BLACK]);
ImageFilledRectangle($chart->im, 12, $h-$y-4, 12+$barmw, $h-$y+6, $chart->colour[BLACK]);


$chart->title('Normalized Time-used and Memory-used for each Program');
$chart->frame();
$chart->complete();

?>
