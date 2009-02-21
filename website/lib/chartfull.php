<?
header("Content-type: image/png");

// Copyright (c) Isaac Gouy 2009

// LIBRARIES ////////////////////////////////////////////////

require_once(LIB_PATH.'lib_whitelist.php');
require_once(LIB_PATH.'lib_chart.php');

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

   $w = 480;
   $h = 300;
   $xo = 48;
   $yo = MARGIN;
   $gap = MARGIN;

if ($valid){
   // RESCALE X-AXIS - ASSUME INCREASING VALUES
   $axis = $testvalueaxis;
   $before = 0;
   $after = sizeof($axis)-1;
   $xscale = 15;
   $xscale = (($w-$xo)/3)/($axis[$after][0] - $axis[$before][0]);
   $xshift = -1 * $axis[$before][0];
}

$im = ImageCreate($w,$h);
$c = chartColors($im);

//ImageString($im, 2, 100, 100, strval(($valid)?"valid":"not"), $c['black']);

$yaxis = log10axis(axis03000());
list($yscale,$yshift) = scaleAndShift($yo,$h,$yaxis);
yAxisGrid($im,$xo,$yo,$w,$h,$yscale,$c,$yshift,$yaxis);

if ($valid){
   $colours = array('dodgerblue','goldenrod','mediumvioletred','yellowgreen');

   // TIME PANEL
   $x = $xo;
   for ($i=0; $i<sizeof($vs1); $i++)
      chartLines($im,$x,$yo,$h,$xscale,$yscale,$c,$colours[$i],$xshift,$testvalue,$yshift,$vs1[$i]);

   $label = 'Time';
   $z = $x + (($w-$xo)/3 -strlen($label)*CHAR_WIDTH_2)/2.0;
   ImageString($im, 2, $z, $h-30, $label, $c['black']);

   $x += $gap + ($w-$xo)/3;
   for ($i=0; $i<sizeof($vs2); $i++)
      $y[] = chartLines($im,$x,$yo,$h,$xscale,$yscale,$c,$colours[$i],$xshift,$testvalue,$yshift,$vs2[$i]);


   $label = 'Memory Use';
   $z = $x + (($w-$xo)/3 -strlen($label)*CHAR_WIDTH_2)/2.0;
   ImageString($im, 2, $z, $h-30, $label, $c['black']);

   $x += ($w-$xo)/3;
   for ($i=0; $i<sizeof($y); $i++){
      // $id[$i] duplicates the same id value for each TEST VALUE
      $label = ($id[$i][0]>1) ? ' #'.strval($id[$i][0]) : '';
      $label = $LangNames[$i].$label;
      ImageString($im, 2, $x+6, $y[$i]-7, $label, $c[$colours[$i]]);
   }

   $label = 'Program';
   $z = $x + (($w-$xo)/3 -strlen($label)*CHAR_WIDTH_2)/2.0;
   ImageString($im, 2, $z, $h-30, $label, $c['black']);


   $x = chartNotice($im,$w,$h,$c,$Mark);

   $label = "";
   foreach ($testvalue as $each)
     //$label = $label.' N='.strval($each);
     $label = $label.' N='.number_format($each);
   $label = $Test[0].$label;
   xAxisLegend($im,$xo,$x,$h,$c,$label);
}

chartFrame($im,$xo,$yo,$w,$h,$c);
yAxisLegend($im,$yo,$w,$h,$c,'ratio to best');
chartTitle($im,$xo,$w,$c,'Normalized Run Times and Memory Use as workload N increases');

ImageInterlace($im,1);
ImagePng($im);
ImageDestroy($im);
?>