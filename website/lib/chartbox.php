<?
header("Content-type: image/png");

// Copyright (c) Isaac Gouy 2009


// DATA ////////////////////////////////////////////////////

$D = array();
if (isset($HTTP_GET_VARS['d'])
      && (strlen($HTTP_GET_VARS['d']) && (strlen($HTTP_GET_VARS['d']) <= 512))){
   $X = $HTTP_GET_VARS['d'];
   if (ereg("^[0-9o]+$",$X)){
      foreach(explode('o',$X) as $v){
         if (strlen($v) && (strlen($v) <= 5)){ $D[] = doubleval($v)/100.0; }
      }
   }
}

$A = array();
if (isset($HTTP_GET_VARS['a'])
      && (strlen($HTTP_GET_VARS['a']) && (strlen($HTTP_GET_VARS['a']) <= 512))){
   $X = rawurldecode($HTTP_GET_VARS['a']);
   //if (ereg("^[a-z0-9,]+$",$X)){
      foreach(explode(',',$X) as $v){
         if (strlen($v) && (strlen($v) <= 32)){ $A[] = $v; }
      }
   //}
}


// CHART /////////////////////////////////////////////////////
   $w = 600;
   $h = 300;

   $boxspace = 8;
   $xo = 65;
   $yo = $boxspace;

   $yscale = 38;

   $boxw = 20;
   $boxo = 10;
   $whisk = floor(($boxw - $boxo)/2);
   $maxboxes= 19;
   
   define('STAT_XLOWER',0);
   define('STAT_LOWER',1);
   define('STAT_MEDIAN',2);
   define('STAT_UPPER',3);
   define('STAT_XUPPER',4);

$im = ImageCreate($w,$h);
ImageColorAllocate($im,204,204,204);

$white = ImageColorAllocate($im,255,255,255);
$black = ImageColorAllocate($im,0,0,0);
$bgray = ImageColorAllocate($im,204,204,204);
$mgray = ImageColorAllocate($im,165,165,165);
$gray = ImageColorAllocate($im,221,221,221);
$charwidth = 7.0; // for size 3


// BACKGROUND TEXT LAYER
$x = $xo;
$count = 0;
foreach($A as $k){
   $watermark = str_repeat($k,15);
   ImageStringUp($im, 3, $x-3, $h+17, $watermark, $mgray);
   $x = $x + $boxw + $boxspace;
   if ($count == $maxboxes){ break; } else { $count++;  }
}

// BOXES
$n = sizeof($D);
if ($n%5 == 0){
   $x = $xo;
   $count = 0;
   for ($i=0; $i<$n; $i+=5){
      $xlower = $h-($yo+$D[$i+STAT_XLOWER]*$yscale);
      $lower = $h-($yo+$D[$i+STAT_LOWER]*$yscale);
      $upper = $h-($yo+$D[$i+STAT_UPPER]*$yscale);
      $xupper = $h-($yo+$D[$i+STAT_XUPPER]*$yscale);

      ImageLine($im, $x+$boxo, $xlower, $x+$boxo, $xupper, $white);
      ImageLine($im, $x+$boxo+1, $xlower, $x+$boxo+1, $xupper, $white);
      ImageFilledRectangle($im, $x, $upper, $x+$boxw, $lower, $white);

      $x = $x + $boxw + $boxspace;
      if ($count == $maxboxes){ break; } else { $count++;  }
   }
}

// GRID
for ($i=0; $i<8; $i++){
   $y = $h-($yo+$i*$yscale);
   ImageLine($im, $xo-15, $h-($yo+$i*$yscale), $w, $y, $gray);
   if ($i>0){ ImageString($im, 2, $xo-15, $y, strval($i), $black); }

   $label = strval( floor(pow(10.0,$i/2.0)) ).'x';
   $x = strlen($label)*7.0;
   ImageString($im, 2, $xo-$x-6, $y-13, $label, $white);
}

// AXIS LEGEND
$label = '"hemibels" 2 * log10 time/fastest';
ImageStringUp($im, 3, 5, $h-33, $label, $black);

// MEDIAN and WHISKERS
if ($n%5 == 0){
   $x = $xo;
   $count = 0;
   for ($i=0; $i<$n; $i+=5){
      $xlower = $h-($yo+$D[$i+STAT_XLOWER]*$yscale);
      $median = $h-($yo+$D[$i+STAT_MEDIAN]*$yscale);
      $xupper = $h-($yo+$D[$i+STAT_XUPPER]*$yscale);

      ImageLine($im, $x+$whisk, $xlower, $x+$boxw-$whisk, $xlower, $white);
      ImageLine($im, $x+$whisk, $xupper, $x+$boxw-$whisk, $xupper, $white);
      ImageFilledRectangle($im, $x, $median-1, $x+$boxw, $median, $black);

      $x = $x + $boxw + $boxspace;
      if ($count == $maxboxes){ break; } else { $count++;  }
   }
}

ImagePNG($im);
ImageDestroy($im);
?> 
