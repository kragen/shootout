<?
// Copyright (c) Isaac Gouy 2009

// CONSTANTS ///////////////////////////////////////////////////

define('CHAR_WIDTH_2',6.0);
define('CHAR_WIDTH_3',7.0);
define('MARGIN',16);
define('BETWEEN_GRID',10);


// FUNCTIONS ///////////////////////////////////////////////////

function chartColors(&$im){
   ImageColorAllocate($im,255,255,255);
   $c = array();
   $c['white'] = ImageColorAllocate($im,255,255,255);
   $c['ltgray'] = ImageColorAllocate($im,221,221,221);
   $c['gray'] = ImageColorAllocate($im,204,204,204);
   $c['dkgray'] = ImageColorAllocate($im,145,145,145);
   $c['black'] = ImageColorAllocate($im,0,0,0);
   $c['dodgerblue'] = ImageColorAllocate($im,30,144,255);
   $c['goldenrod'] = ImageColorAllocate($im,218,165,32);
   $c['mediumvioletred'] = ImageColorAllocate($im,199,21,133);
   $c['yellowgreen'] = ImageColorAllocate($im,154,205,50 );
   return $c;
}

   // AXIS LABEL & GRIDLINE DEFINITIONS

function axis100(){
   return array(
      array(1,"1"), array(3,"3"), array(5,"5"),
      array(10,"10"), array(30,"30"), array(50,"50"),
      array(100,"100")
      );
}

function axis1000(){
   $a = axis100();
   $a[] = array(300,"300");
   $a[] = array(500,"500");
   $a[] = array(1000,"1000");
   return $a;
}

function axis3000(){
   $a = axis1000();
   $a[] = array(3000,"3000");
   return $a;
}

function axis3_10(){
   return array(
      array(1,"1"), array(3,"3"), array(10,"10"), array(30,"30"),
      array(100,"100"), array(300,"300"), array(1000,"1000")
      );
}

function axis03000(){
   return array(
      array(0.1,"0.1"), array(0.3,"0.3"), array(0.5,"0.5"),
      //array(0.3,"0.3"), array(0.5,"0.5"),
      array(1,"1"), array(3,"3"), array(5,"5"),
      array(10,"10"), array(30,"30"), array(50,"50"),
      array(100,"100"), array(300,"300"), array(500,"500"),
      array(1000,"1000"), array(3000,"3000")
      );
}


function log10axis(&$a){
   $log10a = array();
   foreach($a as $v){ $log10a[] = array(log10($v[0]),$v[1]); }
   return $log10a;
}


function axisPercent(&$a){
   $p = array();
   foreach($a as $v){ $p[] = array($v[0],$v[1].'%'); }
   return $p;
}

function axisT(){
   return array(
      array(0.1,"0.1s"), array(0.5,"0.5s"),
      array(1,"1s"), array(5,"5s"),
      array(10,"10s"), array(30,"30s"), array(60,"60s"),
      array(300,"5 mins"), array(600,"10 mins"), array(1800,"30 mins"),
      array(3600,"1h"), array(10800,"3h"), array(18000,"5h")
      );
}


function scaleAndShift($o,$size,&$axis){
   $shift = $axis[0][0];
   $max = $axis[sizeof($axis)-1][0];
   $valuerange = ($shift<0) ? abs($max-$shift) : $max-$shift;
   $scale = ($size-2*$o)/$valuerange;
   return array($scale,$shift);
}


   // AXIS LABEL & GRIDLINE FUNCTIONS


function xAxisGrid(&$im,$xo,$yo,$w,$h,$xscale,$yscale,&$c,$ashift,$a){
   //$y = $h - 2*$yo - 100.0*$yscale + $ashift*$yscale;
   foreach($a as $v){
      $x = $xo + $v[0]*$xscale + $ashift*$xscale;
      ImageStringUp($im, 3, $x, $h-$yo-6, $v[1], $c['dkgray']);
      ImageLine($im, $x, $h-$yo, $x, $yo, $c['ltgray']);
   }
}

function yAxisGrid(&$im,$xo,$yo,$w,$h,$scale,&$c,$ashift,$a,$up=''){
   if ($up=='down'){ $dir = -1.0; } else { $dir = 1.0; }
   foreach($a as $v){
      $y = $h - $yo - $dir*($v[0]*$scale - $ashift*$scale);
      if (!isset($firsty)){ $firsty = $y; }
      $x = strlen($v[1])*CHAR_WIDTH_2;
      if (!isset($prev)||abs($prev-$y)>BETWEEN_GRID){ // arbitrary spacing
         ImageString($im, 2, $xo-$x-6, $y-7, $v[1], $c['dkgray']);
         ImageLine($im, $xo-CHAR_WIDTH_2, $y, $w-1, $y, $c['ltgray']);
         $prev = $y;
      }
   }
}


   // TEXT LABELS

function chartTitle(&$im,$xo,$w,&$c,$label){
   $width = $w - $xo;
   $inset = ($width - strlen($label)*CHAR_WIDTH_3)/2.0;
   if ($inset < 0){
      $x = $w - strlen($label)*CHAR_WIDTH_3;
   } else {
      $x = $xo + $inset;
   }
   ImageString($im, 3, $x, 0, $label, $c['black']);
}

function chartNotice(&$im,$w,$h,&$c,$label){
   $x = $w - strlen($label)*CHAR_WIDTH_2;
   ImageString($im, 2, $x, $h-15, $label, $c['dkgray']);
   return $x;
}

function xAxisLegend(&$im,$xo,$w,$h,&$c,$label){
//   $x = $xo+(($w-$xo-strlen($label)*CHAR_WIDTH_2)/2.0);
   $x = ($w-$xo-strlen($label)*CHAR_WIDTH_2)/2.0;
   ImageString($im, 2, $x+$xo, $h-15, $label, $c['black']);
}

function yAxisLegend(&$im,$yo,$w,$h,&$c,$label){
   $y = ($h-$yo-strlen($label)*CHAR_WIDTH_2)/2.0;
   ImageStringUp($im, 2, 5, $h-$y-$yo, $label, $c['black']);
}

function chartBackground(&$im,$xo,$yo,$h,&$c,$inc,$max,&$a){
   $x = $xo+4;
   $count = 0;
   $need = floor($h/CHAR_WIDTH_3)-1;
   foreach($a as $s){
      $s = ' '.$s;
      $needrepeat = floor($need/strlen($s))+1;
      $label = substr( str_repeat($s,$needrepeat), 0, $need);
      ImageStringUp($im, 3, $x, $yo, $label, $c['ltgray']);
      $x = $x + $inc;
      if ($count == $max){ break; } else { $count++; }
   }
}

function chartFrame(&$im,$xo,$yo,$w,$h,&$c){
   ImageLine($im, $xo, MARGIN, $xo, $h-MARGIN, $c['dkgray']); // y-axis
   ImageLine($im, $w-1, MARGIN, $w-1, $h-MARGIN, $c['gray']);
   ImageLine($im, $xo, $h-$yo, $w-1, $h-$yo, $c['dkgray']); // x-axis
}

   // CONTENT

function chartBars(&$im,$xo,$yo,$scale,&$c,$barc,$barw,$inc,$dshift,&$d,$filled=TRUE){
   $x = $xo;
   foreach($d as $v){
      if ($v > -4){ // no measurement was made
         $y1 = $yo - $v*$scale;
         $y2 = $yo;
         if ($v < 0){ $tmp = $y1; $y1 = $y2; $y2 = $tmp; }
         if ($filled){
            ImageFilledRectangle($im, $x, $y1, $x+$barw, $y2, $c[$barc]);
         } else {
            ImageFilledRectangle($im, $x, $y1, $x+$barw, $y2, $c['white']);
            ImageRectangle($im, $x, $y1, $x+$barw, $y2, $c[$barc]);
         }
      }
      $x += $barw + $inc;
   }
   return $x;
}


function chartBoxes(&$im,$xo,$yo,$h,$scale,&$c,$boxw,$inc,$boxo,$max,$dshift,&$d){
   $n = sizeof($d);
   if ($n%STATS_SIZE == 0){
      $x = $xo+4;
      $ys = $dshift*$scale;
      $count = 0;
      for ($i=0; $i<$n; $i+=STATS_SIZE){
         $xlower = $h-($yo + $d[$i+STAT_XLOWER]*$scale + $ys);
         $lower = $h-($yo + $d[$i+STAT_LOWER]*$scale + $ys);
         $upper = $h-($yo + $d[$i+STAT_UPPER]*$scale + $ys);
         $xupper = $h-($yo + $d[$i+STAT_XUPPER]*$scale + $ys);

         ImageLine($im, $x+$boxo, $xlower, $x+$boxo, $xupper, $c['dkgray']);
         ImageLine($im, $x+$boxo+1, $xlower, $x+$boxo+1, $xupper, $c['dkgray']);
         ImageFilledRectangle($im, $x, $upper, $x+$boxw, $lower, $c['white']);
         ImageRectangle($im, $x, $upper, $x+$boxw, $lower, $c['dkgray']);

         $x = $x + $boxw + $inc;
         if ($count == $max){ break; } else { $count++;  }
      }
   }
}

function chartWhiskers(&$im,$xo,$yo,$h,$scale,&$c,$boxw,$inc,$boxo,$max,$dshift,&$d){
   $n = sizeof($d);
   if ($n%STATS_SIZE == 0){
      $x = $xo+4;
      $ys = $dshift*$scale;
      $count = 0;
      $whisk = floor(($boxw - $boxo)/2);
      for ($i=0; $i<$n; $i+=STATS_SIZE){
         $xlower = $h-($yo + $d[$i+STAT_XLOWER]*$scale + $ys);
         $median = $h-($yo + $d[$i+STAT_MEDIAN]*$scale + $ys);
         $xupper = $h-($yo + $d[$i+STAT_XUPPER]*$scale + $ys);
         ImageLine($im, $x+$whisk, $xlower, $x+$boxw-$whisk, $xlower, $c['dkgray']);
         ImageLine($im, $x+$whisk, $xupper, $x+$boxw-$whisk, $xupper, $c['dkgray']);

         if ($d[$i+STAT_MIN] < $d[$i+STAT_XLOWER]){
            $y = $h-($yo + $d[$i+STAT_MIN]*$scale + $ys);
            ImageLine($im, $x+$whisk, $y, $x+$boxw-$whisk, $y, $c['dkgray']);
            ImageLine($im, $x+$boxo, $y-5, $x+$boxo, $y, $c['dkgray']);
            ImageLine($im, $x+$boxo+1, $y-5, $x+$boxo+1, $y, $c['dkgray']);
         }
         if ($d[$i+STAT_MAX] > $d[$i+STAT_XUPPER]){
            $y = $h-($yo + $d[$i+STAT_MAX]*$scale + $ys);
            ImageLine($im, $x+$whisk, $y, $x+$boxw-$whisk, $y, $c['dkgray']);
            ImageLine($im, $x+$boxo, $y, $x+$boxo, $y+5, $c['dkgray']);
            ImageLine($im, $x+$boxo+1, $y, $x+$boxo+1, $y+5, $c['dkgray']);
         }

         ImageFilledRectangle($im, $x, $median-1, $x+$boxw, $median, $c['black']);

         $x = $x + $boxw + $inc;
         if ($count == $max){ break; } else { $count++;  }
      }
   }
}


function chartLines(&$im,$xo,$yo,$h,$xscale,$yscale,&$c,$linec,$xshift,&$xs,$ashift,&$ys){
   $x2 = $xo;
   $y2 = $yo;
   for ($i=0;$i<sizeof($ys);$i++){
     if ($ys[$i] > log10(NO_VALUE)){ // no measurement was made LOG10 TOO SPECIFIC

         if (!isset($prevx)){
            $prevx = $xo + ($xs[$i]*$xscale + $xshift*$xscale);
            $prevy = $h - $yo - ($ys[$i]-$ashift)*$yscale;
            ImageFilledRectangle($im, $prevx-1, $prevy-3, $prevx+3, $prevy+1, $c[$linec]);
         } else {
            $x1 = $prevx;
            $y1 = $prevy;

            $x2 = $xo + ($xs[$i]*$xscale + $xshift*$xscale);
            $y2 = $h - $yo - ($ys[$i]-$ashift)*$yscale;

            $prevx = $x2;
            $prevy = $y2;

            ImageLine($im, $x1-1, $y1-1, $x2-1, $y2-1, $c[$linec]);
            ImageFilledRectangle($im, $prevx-1, $prevy-3, $prevx+3, $prevy+1, $c[$linec]);
         }
      }
   }
   return $prevy;
}


?>