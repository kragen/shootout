<?
header("Content-type: image/png");

// Copyright (c) Isaac Gouy 2009

// LIBRARIES ////////////////////////////////////////////////

require_once(LIB_PATH.'lib_whitelist.php');
require_once(LIB_PATH.'lib_chart.php');

SetChartCacheControl();

list($in,$ex) = WhiteListInEx();
$WhiteListLangs = WhiteListUnique('lang.csv',$in);
$WhiteListTests = WhiteListUnique('test.csv',$in);

// DATA ////////////////////////////////////////////////////

list ($Mark,$valid) = ValidMark($HTTP_GET_VARS,TRUE);
list ($LangNames,$valid) = ValidLangs($HTTP_GET_VARS,$WhiteListLangs,$valid);
list ($Test,$valid) = ValidTests($HTTP_GET_VARS,$WhiteListTests,$valid);

define('TESTVALUES_SIZE',3);
list ($Data,$valid) = ValidMatrix($HTTP_GET_VARS,'v',TESTVALUES_SIZE,$valid);

$valid = $valid && (sizeof($Data)-TESTVALUES_SIZE)%3==0; // $testvalues row + 3*x rows

if ($valid){
   for ($i=0; $i<sizeof($Data); $i+=TESTVALUES_SIZE)
      $values[] = array($Data[0+$i],$Data[1+$i],$Data[2+$i]);

   // first row is the TEST VALUE sizes
   $testvalue = array_shift($values);
   // fix rounding errors back to large integers
   foreach ($testvalue as $k => $v){
      if ($v > 1000){
         $divisor = pow(10,floor(log10($v))-1);
         $z = round($v/$divisor)*$divisor;
      } else {
         $z = $v;
      }
      $testvalue[$k] = $z;
   }


   foreach ($testvalue as $k => $v) $testvalueaxis[] = array($v,"");

   // first third program ids, second third time, third third memory use
   $n = sizeof($values)/3;
   $id = array_splice($values,0,$n);
   foreach ($id as $i => $row)
      foreach ($row as $k => $v)
         $id[$i][$k] = round($v);

   // log10 for all data values
   foreach ($values as $i => $row)
      foreach ($row as $k => $v)
         $values[$i][$k] = log10($v);

   // first half time, second half memory use
   $n = sizeof($values)/2;
   $vs1 = array_splice($values,0,$n);
   $vs2 = &$values;
}

// CHART //////////////////////////////////////////////////

$chart = new LineChart();
$chart->yAxis(log10axis(axis03000()));

if ($valid){
   // RESCALE X-AXIS - ASSUME INCREASING VALUES
   $panelWidth = ($chart->w - $chart->xo)/3;

   $axis = $testvalueaxis;
   $before = 0;
   $after = sizeof($axis)-1;
   $xscale = $panelWidth / ($axis[$after][0] - $axis[$before][0]);
   $xshift = -1 * $axis[$before][0];

   $chart->xshift = $xshift;
   $chart->xscale = $xscale;
   $chart->xaxis = $testvalueaxis;

   $colours = array(DODGER_BLUE,GOLDENROD,MEDIUM_VIOLET_RED,YELLOW_GREEN);

   // TIME PANEL
   $x = $chart->xo;
   for ($i=0; $i<sizeof($vs1); $i++)
      $chart->lines($colours[$i],$testvalue,$vs1[$i]);

   $label = 'Time-used';
   $z = $x + ($panelWidth - strlen($label)*CHAR_WIDTH_2)/2.0;
   ImageString($chart->im, 2, $z, $chart->h - 30, $label, $chart->colour[BLACK]);
   ImageString($chart->im, 2, $z, 23, $label, $chart->colour[BLACK]);

   // MEMORY USE PANEL

   $x += 20 + $panelWidth;
   $chart->xo = $x;
   for ($i=0; $i<sizeof($vs2); $i++)
      $y[] = $chart->lines($colours[$i],$testvalue,$vs2[$i]);

   $label = 'Memory-used';
   $z = $x + ($panelWidth -strlen($label)*CHAR_WIDTH_2)/2.0;
   ImageString($chart->im, 2, $z, $chart->h - 30, $label, $chart->colour[BLACK]);
   ImageString($chart->im, 2, $z, 23, $label, $chart->colour[BLACK]);

   // PROGRAM NAME PANEL

   $x += $panelWidth;
   $chart->xo = $x;
   for ($i=0; $i<sizeof($y); $i++){
      // $id[$i] duplicates the same id value for each TEST VALUE
      $label = ($id[$i][0]>1) ? ' #'.strval($id[$i][0]) : '';
      $label = $LangNames[$i].$label;
      ImageString($chart->im, 2, $x+6, $y[$i]-7, $label, $chart->colour[$colours[$i]]);
   }

   $label = 'Program name';
   $z = $x + ($panelWidth - strlen($label)*CHAR_WIDTH_2)/2.0;
   ImageString($chart->im, 2, $z, $chart->h - 30, $label, $chart->colour[BLACK]);
   ImageString($chart->im, 2, $z, 23, $label, $chart->colour[BLACK]);
   
   $chart->xo = $chart->defaultOriginX();

   $x = $chart->notice($Mark);

   //  X AXIS LEGEND

   $label = "";
   foreach ($testvalue as $each)
     $label = $label.' N='.number_format($each);
   $label = $Test[0].$label;
   $chart->xAxisLegend($label,$x);
}

$chart->title('Normalized Time-used Memory-used as workload N increases');
$chart->frame();
$chart->complete();

?>
