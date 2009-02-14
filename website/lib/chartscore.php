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
         if (strlen($v) && (strlen($v) <= 5)){ $D[] = doubleval($v)/10.0; }
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
   $h = 225;
   
   $xo = 65;
   $yo = 16;

   $yscale = 64;
   $barw = 3;
   $charwidth2 = 6.0; // for size 2
   $charwidth3 = 7.0; // for size 3

$im = ImageCreate($w,$h);
ImageColorAllocate($im,204,204,204);
$white = ImageColorAllocate($im,255,255,255);
$black = ImageColorAllocate($im,0,0,0);
$bgray = ImageColorAllocate($im,204,204,204);
$gray = ImageColorAllocate($im,221,221,221);

// BARS
$x = $xo;
foreach($D as $v){
   $y = $h-($yo+ log10($v)*$yscale);
   ImageFilledRectangle($im, $x, $y, $x+$barw, $h-$yo, $white);
   $x = $x + $barw + $barspace;
}

// GRID
for ($i=0; $i<11; $i++){
   if ($i==1||$i==5||$i==9){ continue; }
   $y = $h-($yo+($i/4.0)*$yscale);
   ImageLine($im, $xo-15, $y, $w, $y, $gray);

   $label = strval( floor(pow(10.0,$i/4.0)) );
   $x = strlen($label)*$charwidth2;
   ImageString($im, 2, $xo-$x-6, $y-13, $label, $white);
}

// AXIS LEGEND
$label = 'ratio to best';
$y = ($h-strlen($label)*$charwidth2)/2;
ImageStringUp($im, 2, 5, $h-$y, $label, $black);

$label = 'language implementation';
$x = ($w-strlen($label)*$charwidth2)/2;
ImageString($im, 2, $x, $h-15, $label, $black);

// TITLE
$label = 'Weighted Geometric Mean of normalized Time, Memory and Source size';
$x = $w-5-strlen($label)*$charwidth3;
ImageString($im, 3, $x, 2, $label, $black);

// NOTICE
$label = $Mark;
$x = $w-5-strlen($label)*$charwidth2;
ImageString($im, 2, $x, 16, $label, $white);


ImageInterlace($im,1);
ImagePng($im);
ImageDestroy($im);
?>