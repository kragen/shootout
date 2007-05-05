<?
header("Content-type: image/png");

// DATA ////////////////////////////////////////////////////

   $d = array();
   if (isset($HTTP_GET_VARS['d'])){
      $s = $HTTP_GET_VARS['d'];
      if (is_string($s)){ $d = explode('o',$s); }
   }

// CHART //////////////////////////////////////////////////

   $v1 = 2;
   $v2 = 10;
   $v3 = 20;
   $v4 = 40;

   $w = 450;
   $h = 150;
   $wratio = 5;
   $vscale = 48;
   $xratio = 7;
   $width = 9;
   $minratio = 1;


$im = ImageCreate($w,$h);

ImageColorAllocate($im,204,204,204);

$white = ImageColorAllocate($im,255,255,255);
$black = ImageColorAllocate($im,0,0,0);
$bgray = ImageColorAllocate($im,204,204,204);

// GRIDLINES
$gray = ImageColorAllocate($im,221,221,221);
$h1 = $h - (($v1 / $vscale) * $h);
$h2 = $h - (($v2 / $vscale) * $h);
$h3 = $h - (($v3 / $vscale) * $h);
$h4 = $h - (($v4 / $vscale) * $h);
ImageLine($im, 0, $h1, $w, $h1, $gray);
ImageLine($im, 0, $h2, $w, $h2, $gray);
ImageLine($im, 0, $h3, $w, $h3, $gray);
ImageLine($im, 0, $h4, $w, $h4, $gray);


foreach($d as $v){
   $hratio = min( ($v/10.0)*($h/$vscale), $h);
   ImageFilledRectangle($im, $xratio, $h-$hratio, $xratio+$wratio, $h, $white);
   $xratio = $xratio + $width;
}


// GRIDLINE LABELS
ImageString($im, 2, 6, $h1-14, $v1.'x', $white);
ImageString($im, 2, 6, $h2-14, $v2.'x', $white);
ImageString($im, 2, 6, $h3-14, $v3.'x', $white);
ImageString($im, 2, 6, $h4-14, $v4.'x', $white);

ImageString($im, 2, $w-26, $h1-14, $v1.'x', $white);
ImageString($im, 2, $w-26, $h2-14, $v2.'x', $white);
ImageString($im, 2, $w-26, $h3-14, $v3.'x', $white);
ImageString($im, 2, $w-26, $h4-14, $v4.'x', $white);

ImageInterlace($im,1);
ImagePng($im);
ImageDestroy($im);
?>