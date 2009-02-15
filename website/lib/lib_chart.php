<?
// Copyright (c) Isaac Gouy 2009

// CONSTANTS ///////////////////////////////////////////////////

define('CHAR_WIDTH_2',6.0);
define('CHAR_WIDTH_3',7.0);


// FUNCTIONS ///////////////////////////////////////////////////

function chartColors(&$im){
   ImageColorAllocate($im,204,204,204);
   $white = ImageColorAllocate($im,255,255,255);
   $black = ImageColorAllocate($im,0,0,0);
   $gray = ImageColorAllocate($im,221,221,221);
   $bgray = ImageColorAllocate($im,204,204,204);
   $mgray = ImageColorAllocate($im,165,165,165);
   return array($white,$black,$gray,$bgray,$mgray);
}

   // AXIS & GRID

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

function log10axis(&$a){
   $log10a = array();
   foreach($a as $v){ $log10a[] = array(log10($v[0]),$v[1]); }
   return $log10a;
}

function yAxisGrid(&$im,$xo,$yo,$w,$h,$scale,$labelcol,$linecol,$ashift,$a){
   foreach($a as $v){
      $y = $h - ($yo + $v[0]*$scale + $ashift*$scale);
      $x = strlen($v[1])*CHAR_WIDTH_2;
      ImageString($im, 2, $xo-$x-6, $y-13, $v[1], $labelcol);
      ImageLine($im, $xo-15, $y, $w, $y, $linecol);
   }
}

function axisT(){
   return array(
      array(0.1,"0.1s"), array(0.5,"0.5s"),
      array(1,"1s"), array(5,"5s"),
      array(10,"10s"), array(30,"30s"), array(60,"60s"),
      array(300,"5 mins"), array(600,"10 mins"),
      array(1800,"30 mins"), array(3600,"1h"), array(10800,"3h")
      );
}


   // TEXT LABELS

function chartTitle(&$im,$w,$labelcol,$label){
   $x = $w-5-strlen($label)*CHAR_WIDTH_3;
   ImageString($im, 3, $x, 2, $label, $labelcol);
}

function chartNotice(&$im,$w,$labelcol,$label){
   $x = $w-5-strlen($label)*CHAR_WIDTH_2;
   ImageString($im, 2, $x, 16, $label, $labelcol);
}

function xAxisLegend(&$im,$xo,$w,$h,$labelcol,$label){
   $x = ($w-$xo-strlen($label)*CHAR_WIDTH_2)/2.0;
   ImageString($im, 2, $x+$xo, $h-15, $label, $labelcol);
}

function yAxisLegend(&$im,$yo,$w,$h,$labelcol,$label){
   $y = ($h-$yo-strlen($label)*CHAR_WIDTH_2)/2.0;
   ImageStringUp($im, 2, 5, $h-$y-$yo, $label, $labelcol);
}

function chartBackground(&$im,$xo,$yo,$h,$labelcol,$inc,$max,&$a){
   $x = $xo;
   $count = 0;
   $need = floor($h/CHAR_WIDTH_3);
   foreach($a as $s){
      $needrepeat = floor($need/strlen($s))+1;
      $label = substr( str_repeat($s,$needrepeat), 0, $need);
      ImageStringUp($im, 3, $x, $yo, $label, $labelcol);
      $x = $x + $inc;
      if ($count == $max){ break; } else { $count++; }
   }
}


   // CONTENT

function chartBars(&$im,$xo,$yo,$scale,$barcol,$barw,$inc,$dshift,&$d){
   $x = $xo;
   foreach($d as $v){
      $y = $yo - $v*$scale;
      ImageFilledRectangle($im, $x, $y, $x+$barw, $yo, $barcol);
      $x = $x + $barw + $inc;
   }
}


function chartBoxes(&$im,$xo,$yo,$h,$scale,$boxcol,$boxw,$inc,$boxo,$max,$dshift,&$d){
   $n = sizeof($d);
   if ($n%STATS_SIZE == 0){
      $x = $xo-4;
      $ys = $dshift*$scale;
      $count = 0;
      for ($i=0; $i<$n; $i+=STATS_SIZE){

         $xlower = $h-($yo + $d[$i+STAT_XLOWER]*$scale + $ys);
         $lower = $h-($yo + $d[$i+STAT_LOWER]*$scale + $ys);
         $upper = $h-($yo + $d[$i+STAT_UPPER]*$scale + $ys);
         $xupper = $h-($yo + $d[$i+STAT_XUPPER]*$scale + $ys);

         ImageLine($im, $x+$boxo, $xlower, $x+$boxo, $xupper, $boxcol);
         ImageLine($im, $x+$boxo+1, $xlower, $x+$boxo+1, $xupper, $boxcol);
         ImageFilledRectangle($im, $x, $upper, $x+$boxw, $lower, $boxcol);

         $x = $x + $boxw + $inc;
         if ($count == $max){ break; } else { $count++;  }
      }
   }
}


function chartWhiskers(&$im,$xo,$yo,$h,$scale,$boxcol,$boxw,$inc,$boxo,$max,$mcol,$dshift,&$d){
   $n = sizeof($d);
   if ($n%STATS_SIZE == 0){
      $x = $xo-4;
      $ys = $dshift*$scale;
      $count = 0;
      $whisk = floor(($boxw - $boxo)/2);
      for ($i=0; $i<$n; $i+=STATS_SIZE){
         $xlower = $h-($yo + $d[$i+STAT_XLOWER]*$scale + $ys);
         $median = $h-($yo + $d[$i+STAT_MEDIAN]*$scale + $ys);
         $xupper = $h-($yo + $d[$i+STAT_XUPPER]*$scale + $ys);
         ImageLine($im, $x+$whisk, $xlower, $x+$boxw-$whisk, $xlower, $boxcol);
         ImageLine($im, $x+$whisk, $xupper, $x+$boxw-$whisk, $xupper, $boxcol);

         if ($d[$i+STAT_MIN] < $d[$i+STAT_XLOWER]){
            $y = $h-($yo + $d[$i+STAT_MIN]*$scale + $ys);
            ImageLine($im, $x+$whisk, $y, $x+$boxw-$whisk, $y, $boxcol);
            ImageLine($im, $x+$boxo, $y-5, $x+$boxo, $y, $boxcol);
            ImageLine($im, $x+$boxo+1, $y-5, $x+$boxo+1, $y, $boxcol);
         }
         if ($d[$i+STAT_MAX] > $d[$i+STAT_XUPPER]){
            $y = $h-($yo + $d[$i+STAT_MAX]*$scale + $ys);
            ImageLine($im, $x+$whisk, $y, $x+$boxw-$whisk, $y, $boxcol);
            ImageLine($im, $x+$boxo, $y, $x+$boxo, $y+5, $boxcol);
            ImageLine($im, $x+$boxo+1, $y, $x+$boxo+1, $y+5, $boxcol);
         }
         
         ImageFilledRectangle($im, $x, $median, $x+$boxw, $median+1, $mcol);

         $x = $x + $boxw + $inc;
         if ($count == $max){ break; } else { $count++;  }
      }
   }
}


?>