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
list ($Stats,$valid) = ValidStats($HTTP_GET_VARS,'s',$valid);


// CHART /////////////////////////////////////////////////////
   $w = 480;
   $h = 300;

   $boxspace = 8;
   $xo = 65;
   $yo = 16;

   $yscale = 72;

   $boxw = 20;
   $boxo = 10;
   $whisk = floor(($boxw - $boxo)/2);
   $outlier = 5;
   $maxboxes= 15;

$im = ImageCreate($w,$h);
list($white,$black,$gray,$bgray,$mgray) = chartColors($im);

if ($valid){
   chartBackground($im,$xo-CHAR_WIDTH_2,$h-12,$h-40,$mgray,$boxw+$boxspace,$maxboxes,$BackText);
   chartBoxes($im,$xo,$yo,$h,$yscale,$white,$boxw,$boxspace,$boxo,$maxboxes,0,$Stats);
}

// GRID
yAxisGrid($im,$xo,$yo,$w,$h,$yscale,$white,$gray,0,log10axis(axis3000()));
yAxisLegend($im,$yo,$w,$h,$black,'ratio to best');
xAxisLegend($im,$xo,$w,$h,$black,'language implementation');

if ($valid){
   chartWhiskers($im,$xo,$yo,$h,$yscale,$white,$boxw,$boxspace,$boxo,$maxboxes,$black,0,$Stats);
}

chartTitle($im,$w,$black,
   'Normalized Program Run Time - Median and Quartiles - by Language');

if ($valid){
   chartNotice($im,$w,$white,$Mark);
}


ImageInterlace($im,1);
ImagePNG($im);
ImageDestroy($im);
?>
