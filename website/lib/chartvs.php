<?
header("Content-type: image/png");

// Copyright (c) Isaac Gouy 2004-2009

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

$A = array();
if (isset($HTTP_GET_VARS['a'])
      && (strlen($HTTP_GET_VARS['a']) && (strlen($HTTP_GET_VARS['a']) <= 72))){
   $X = rawurldecode($HTTP_GET_VARS['a']);
   // how to check language implementation name strings?
   //if (ereg("^[a-z0-9,]+$",$X)){
      foreach(explode(',',$X) as $v){
         if (strlen($v) && (strlen($v) <= 32)){ $A[] = $v; }
      }
   //}
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
ImageStringUp($im, 2, 5, $h-54, 'log10 secs ratio', $black);
ImageFilledRectangle($im, 11, $h-50, 11+$barw, $h-40, $white);

ImageStringUp($im, 2, 5, $h-172, 'log10 KB ratio', $black);
ImageFilledRectangle($im, 12, $h-168, 12+$barmw, $h-158, $black);

ImageStringUp($im, 2, $w-20, $h-54, 'log10 gz ratio', $black);
ImageRectangle($im, $w-20+6, $h-50, $w-20+6+$barw, $h-40, $white);

ImageStringUp($im, 2, $w-20, $h-172, 'worse', $black);
ImageFilledRectangle($im, $w-20+6, $h-168, $w-20+6+$barw, $h-158, $mgray);


// LEGEND
$label = $A[0].' better';
$x = $w-5-strlen($label)*$charwidth3;
ImageString($im, 3, $x, 2, $label, $black);
$label = 'vs '.$A[1];
$x = $w-5-strlen($label)*$charwidth3;
ImageString($im, 3, $x, $h-15, $label, $black);

//ImageString($im, 4, 100, $h-200, SITE_NAME, $black);

ImageInterlace($im,1);
ImagePng($im);
ImageDestroy($im);
?>