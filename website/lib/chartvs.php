<?
header("Content-type: image/png");

// Copyright (c) Isaac Gouy 2004-2009

// LIBRARIES ////////////////////////////////////////////////

require_once(LIB_PATH.'lib_whitelist.php');
require_once(LIB_PATH.'lib_chart.php');

list($in,$ex) = WhiteListInEx();
$WhiteListLangs = WhiteListUnique('lang.csv',$in);

// DATA ////////////////////////////////////////////////////


list ($Mark,$valid) = ValidMark($HTTP_GET_VARS,TRUE);
list ($LangName,$valid) = ValidLangs($HTTP_GET_VARS,$WhiteListLangs,$valid);

$D = array();
if (isset($HTTP_GET_VARS['d'])
      && (strlen($HTTP_GET_VARS['d']) && (strlen($HTTP_GET_VARS['d']) <= 512))){
   $X = $HTTP_GET_VARS['d'];
   if (ereg("^[0-9o]+$",$X)){
      foreach(explode('o',$X) as $v){
         if (strlen($v) && (strlen($v) <= 12)){ $D[] = doubleval($v)/100000.0; }
      }
   }
}


// CHART //////////////////////////////////////////////////

   $barspace = 3;
   $w = 480;
   $h = 300;

   $xo = 65;
   $yo = 150;

   $yscale = 54;
   $barw = 4;
   $barmw = 0;

   define('DATA_SIZE',3);
   define('DATA_CPU',0);
   define('DATA_MEM',1);
   define('DATA_GZ',2);


$im = ImageCreate($w,$h);
list($white,$black,$gray,$bgray,$mgray) = chartColors($im);

// BARS
$gap = 16;
$n = sizeof($D);
if ($n%DATA_SIZE == 0){
   $x = $xo;
   for ($i=0; $i<$n; $i+=DATA_SIZE){
      $v = $D[$i+DATA_CPU];
      if ($v < 1.0){
         if ($v == 0){ $v = 1.0; }
         $y = $yo+ log10(1.0/$v)*$yscale;
         ImageFilledRectangle($im, $x, $h-$yo, $x+$barw-1, $y, $mgray);
      } else {
         $y = $h-($yo+ log10($v)*$yscale);
         ImageFilledRectangle($im, $x, $y, $x+$barw, $h-$yo, $white);
      }
      $x = $x + $barw + $barspace;
   }
   $aftercpu = $x;

   $x = $x+$gap;
   for ($i=0; $i<$n; $i+=DATA_SIZE){
      $v = $D[$i+DATA_MEM];
      if ($v < 1.0){
         if ($v == 0){ $v = 1.0; }
         $y = $yo+ log10(1.0/$v)*$yscale;
         ImageFilledRectangle($im, $x, $h-$yo, $x+$barw-1, $y, $mgray);
      } else {
         $y = $h-($yo+ log10($v)*$yscale);
         ImageFilledRectangle($im, $x, $y, $x+$barmw, $h-$yo, $black);
      }
      $x = $x + $barw + $barspace;
   }
   $aftermem = $x;

   $x = $x+$gap;
   for ($i=0; $i<$n; $i+=DATA_SIZE){
      $v = $D[$i+DATA_GZ];
      if ($v < 1.0){
         if ($v == 0){ $v = 1.0; }
         $y = $yo+ log10(1.0/$v)*$yscale;
         ImageFilledRectangle($im, $x, $h-$yo, $x+$barw-1, $y, $mgray);
      } else {
         $y = $h-($yo+ log10($v)*$yscale);
         ImageRectangle($im, $x, $y, $x+$barw, $h-$yo, $white);
      }
      $x = $x + $barw + $barspace;
   }
   $aftergz = $x;
}


// UPPER GRID
$lastx = (isset($aftergz)) ? $aftergz : $w;
for ($i=0; $i<11; $i++){
   if ($i==1||$i==5||$i==9){ continue; }
   $y = $h-($yo+($i/4.0)*$yscale);
   ImageLine($im, $xo-15, $y, $lastx, $y, $gray);

   $label = strval( floor(pow(10.0,$i/4.0)) );
   $x = strlen($label)*CHAR_WIDTH_2;
   ImageString($im, 2, $xo-$x-6, $y-13, $label, $white);
}
// LOWER GRID
for ($i=0; $i<11; $i++){
   if ($i==0||$i==1||$i==5||$i==9){ continue; }
   $y = $h-($yo-($i/4.0)*$yscale);
   ImageLine($im, $xo-15, $y, $lastx, $y, $gray);

   $label = strval( floor(pow(10.0,$i/4.0)) );
   $x = strlen($label)*CHAR_WIDTH_2;
   ImageString($im, 2, $xo-$x-6, $y-13, $label, $mgray);
}

// GRID GAPS
if (isset($aftercpu)){
   ImageFilledRectangle($im, $aftercpu, 0, $aftercpu+$gap-1, $h, $bgray);
}
if (isset($aftermem)){
   ImageFilledRectangle($im, $aftermem, 0, $aftermem+$gap-1, $h, $bgray);
}

// X AXIS LEGEND
if (isset($aftercpu)){
   $axisw = $aftercpu-$xo;
   $label = 'faster';
   $x = ($axisw-strlen($label)*CHAR_WIDTH_2)/2;
   ImageString($im, 2, $xo+$x, $h-15, $label, $black);

   $label = 'smaller';
   $x = ($axisw-strlen($label)*CHAR_WIDTH_2)/2;
   ImageString($im, 2, $aftercpu+$gap+$x, $h-15, $label, $black);

   $label = 'smaller';
   $x = ($axisw-strlen($label)*CHAR_WIDTH_2)/2;
   ImageString($im, 2, $aftermem+$gap+$x, $h-15, $label, $black);
}

// Y AXIS LEGEND
$labela = 'Time';
$labelb = 'Memory';
$y = ($h-strlen($labela.$labelb)*CHAR_WIDTH_2 -14)/2;
$y0 = $y;
ImageStringUp($im, 2, 5, $h-$y-4, $labela, $black);
ImageFilledRectangle($im, 11, $h-$y, 11+$barw, $h-$y+12, $white);
$y = $y + strlen($labela)*CHAR_WIDTH_2 + 22;
ImageStringUp($im, 2, 5, $h-$y-4, $labelb, $black);
ImageFilledRectangle($im, 12, $h-$y, 12+$barmw, $h-$y+10, $black);


$labela = 'worse';
$labelb = 'Source size';
$y = $y0;
ImageStringUp($im, 2, $w-20, $h-$y-4, $labela, $black);
ImageFilledRectangle($im, $w-20+6, $h-$y, $w-20+6+$barw, $h-$y+12, $mgray);
$y = $y + strlen($labela)*CHAR_WIDTH_2 + 22;
ImageStringUp($im, 2, $w-20, $h-$y-4, $labelb, $black);
ImageRectangle($im, $w-20+6, $h-$y, $w-20+6+$barw, $h-$y+10, $white);

if ($valid){
   chartTitle($im,$w,$black,$LangName[0].' / '.$LangName[1]);
   chartNotice($im,$w,$white,$Mark);
}

ImageInterlace($im,1);
ImagePng($im);
ImageDestroy($im);
?>