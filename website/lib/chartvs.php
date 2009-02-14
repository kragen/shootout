<?
header("Content-type: image/png");

// Copyright (c) Isaac Gouy 2004-2009

require_once(LIB_PATH.'lib_whitelist.php');

list($in,$ex) = WhiteListInEx();
$WhiteListLangs = WhiteListUnique('lang.csv',$in);

// DATA ////////////////////////////////////////////////////

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

$A = array("","");
if (isset($HTTP_GET_VARS['a'])
      && (strlen($HTTP_GET_VARS['a']) && (strlen($HTTP_GET_VARS['a']) <= 72))){
   $X = $HTTP_GET_VARS['a'];
   if (ereg("^[a-z0-9O]+$",$X)){
      foreach(explode('O',$X) as $i => $v){
         if (strlen($v) && (strlen($v) <= 32) &&
            (isset($WhiteListLangs[$v]))){ $A[$i] = $WhiteListLangs[$v][LANG_FULL]; }
      }
   }
}

$Mark = '';
if (isset($HTTP_GET_VARS['mark'])
      && (strlen($HTTP_GET_VARS['mark']) && (strlen($HTTP_GET_VARS['mark']) <= 24))){
   $X = rawurldecode($HTTP_GET_VARS['mark']);
   if (ereg("^[ a-zA-Z0-9]+$",$X)){
      $Mark = $X;
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
   $charwidth2 = 6.0; // for size 2
   $charwidth3 = 7.0; // for size 2

   define('DATA_SIZE',3);
   define('DATA_CPU',0);
   define('DATA_MEM',1);
   define('DATA_GZ',2);


$im = ImageCreate($w,$h);
ImageColorAllocate($im,204,204,204);
$white = ImageColorAllocate($im,255,255,255);
$black = ImageColorAllocate($im,0,0,0);
$bgray = ImageColorAllocate($im,204,204,204);
$mgray = ImageColorAllocate($im,165,165,165);
$gray = ImageColorAllocate($im,221,221,221);

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

   $label = strval( floor(pow(10.0,$i/4.0)) ).'x';
   $x = strlen($label)*$charwidth2;
   ImageString($im, 2, $xo-$x-6, $y-13, $label, $white);
}
// LOWER GRID
for ($i=0; $i<11; $i++){
   if ($i==0||$i==1||$i==5||$i==9){ continue; }
   $y = $h-($yo-($i/4.0)*$yscale);
   ImageLine($im, $xo-15, $y, $lastx, $y, $gray);

   $label = strval( floor(pow(10.0,$i/4.0)) ).'x';
   $x = strlen($label)*$charwidth2;
   ImageString($im, 2, $xo-$x-6, $y-13, $label, $white);
}

// GRID GAPS
if (isset($aftercpu)){
   ImageFilledRectangle($im, $aftercpu, 0, $aftercpu+$gap-1, $h, $bgray);
}
if (isset($aftermem)){
   ImageFilledRectangle($im, $aftermem, 0, $aftermem+$gap-1, $h, $bgray);
}


// AXIS LEGEND
$labela = 'log10 secs ratio';
$labelb = 'log10 KB ratio';
$y = ($h-strlen($labela.$labelb)*$charwidth2 -14)/2;
ImageStringUp($im, 2, 5, $h-$y-4, $labela, $black);
ImageFilledRectangle($im, 11, $h-$y, 11+$barw, $h-$y+12, $white);
$y = $y + strlen($labela)*$charwidth2 + 22;
ImageStringUp($im, 2, 5, $h-$y-4, $labelb, $black);
ImageFilledRectangle($im, 12, $h-$y, 12+$barmw, $h-$y+10, $black);


$labela = 'worse';
$labelb = 'log10 gz ratio';
$y = ($h-strlen($labela.$labelb)*$charwidth2 -14)/2;
ImageStringUp($im, 2, $w-20, $h-$y-4, $labela, $black);
ImageFilledRectangle($im, $w-20+6, $h-$y, $w-20+6+$barw, $h-$y+10, $mgray);
$y = $y + strlen($labela)*$charwidth2 + 22;
ImageStringUp($im, 2, $w-20, $h-$y-4, $labelb, $black);
ImageRectangle($im, $w-20+6, $h-$y, $w-20+6+$barw, $h-$y+10, $white);

// LEGEND
$label = $A[0].' better';
$x = $w-5-strlen($label)*$charwidth3;
ImageString($im, 3, $x, 2, $label, $black);
$label = 'vs '.$A[1];
$x = $w-5-strlen($label)*$charwidth3;
ImageString($im, 3, $x, $h-29, $label, $black);

// NOTICE
$label = $Mark.' The Computer Language Benchmarks Game';
$x = $w-5-strlen($label)*$charwidth2;
ImageString($im, 2, $x, $h-15, $label, $white);

ImageInterlace($im,1);
ImagePng($im);
ImageDestroy($im);
?>