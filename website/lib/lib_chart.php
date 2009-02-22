<?
// Copyright (c) Isaac Gouy 2009

// CONSTANTS ///////////////////////////////////////////////////

define('CHAR_WIDTH_2',6.0);
define('CHAR_WIDTH_3',7.0);
define('MARGIN',16);
define('BETWEEN_GRID',10);
define('SPACE_BETWEEN_GRIDLINES',10);

define('WHITE',0);
define('LIGHT_GRAY',1);
define('GRAY',2);
define('DARK_GRAY',3);
define('BLACK',4);
define('DODGER_BLUE',5);
define('GOLDENROD',6);
define('MEDIUM_VIOLET_RED',7);
define('YELLOW_GREEN',8);



// CHART CLASS ///////////////////////////////////////////////////


class Chart {
   var $im,$w,$h,$colour;
   var $xo,$xscale,$xshift,$xaxis;
   var $yo,$yscale,$yshift,$yaxis;

   function Chart($width,$height,&$yaxis,$xorigin=MARGIN,$yorigin=MARGIN){
      $this->w = $width;
      $this->h = $height;

      $this->im = ImageCreate($width,$height);
      ImageColorAllocate($this->im,255,255,255);
      $this->initializeColours();
      
      $this->xo = $xorigin;
      $this->yo = $yorigin;
      $this->yaxis = $yaxis;
      
      $this->shiftAndScaling();
   }

   function complete(){
      ImageInterlace($this->im,1);
      ImagePNG($this->im);
      ImageDestroy($this->im);
   }
   
   function initializeColours(){
      $this->colour = array();
      $this->colour[WHITE] = ImageColorAllocate($this->im,255,255,255);
      $this->colour[LIGHT_GRAY] = ImageColorAllocate($this->im,221,221,221);
      $this->colour[GRAY] = ImageColorAllocate($this->im,204,204,204);
      $this->colour[DARK_GRAY] = ImageColorAllocate($this->im,145,145,145);
      $this->colour[BLACK] = ImageColorAllocate($this->im,0,0,0);
      $this->colour[DODGER_BLUE] = ImageColorAllocate($this->im,30,144,255);
      $this->colour[GOLDENROD] = ImageColorAllocate($this->im,218,165,32);
      $this->colour[MEDIUM_VIOLET_RED] = ImageColorAllocate($this->im,199,21,133);
      $this->colour[YELLOW_GREEN] = ImageColorAllocate($this->im,154,205,50 );
   }

   function frame(){
      ImageLine($this->im, $this->xo, MARGIN, $this->xo, $this->h-MARGIN, $this->colour[DARK_GRAY]); // y-axis
      ImageLine($this->im, $this->w -1, MARGIN, $this->w -1, $this->h-MARGIN, $this->colour[GRAY]);
      ImageLine($this->im, $this->xo, $this->h - $this->yo, $this->w -1, $this->h - $this->yo, $this->colour[DARK_GRAY]); // x-axis
   }
   
   function title($label){
      $width = $this->w - $this->xo;
      $inset = ($width - strlen($label)*CHAR_WIDTH_3)/2.0;
      if ($inset < 0){
         $x = $this->w - strlen($label)*CHAR_WIDTH_3;
      } else {
         $x = $this->xo + $inset;
      }
      ImageString($this->im, 3, $x, 0, $label, $this->colour[BLACK]);
   }

   function notice($label){
      $x = $this->w - strlen($label)*CHAR_WIDTH_2;
      ImageString($this->im, 2, $x, $this->h - 15, $label, $this->colour[DARK_GRAY]);
      return $x;
   }

   function xAxisLegend($w,$h,$label){
      $x = ($w - $this->xo - strlen($label)*CHAR_WIDTH_2)/2.0;
      ImageString($this->im, 2, $x + $this->xo, $h-15, $label, $this->colour[BLACK]);
   }

   function yAxisLegend($w,$h,$label,$yo=null){
      if (!isset($yo)){ $yo = $this->yo; }
      $y = ($h - $yo - strlen($label)*CHAR_WIDTH_2)/2.0;
      ImageStringUp($this->im, 2, 5, $h - $y - $yo, $label, $this->colour[BLACK]);
   }

   function shiftAndScaling(){
      if (isset($this->yaxis)){
         $this->yshift = $this->yaxis[0][0];
         $max = $this->yaxis[ sizeof($this->yaxis) - 1][0];
         $valuerange = ($this->yshift < 0) ? abs($max - $this->yshift) : $max - $this->yshift;
         $this->yscale = ($this->h - (2 * $this->yo)) / $valuerange;
      }
   }

   function yAxisGrid($up=''){
      if ($up=='down'){ $dir = -1.0; } else { $dir = 1.0; }
      foreach($this->yaxis as $v){
         $y = $this->h - $this->yo - $dir*($v[0] * $this->yscale - $this->yshift * $this->yscale);
         if (!isset($firsty)){ $firsty = $y; }
         $x = strlen($v[1])*CHAR_WIDTH_2;
         if (!isset($prev)||abs($prev-$y) > SPACE_BETWEEN_GRIDLINES){
            ImageString($this->im, 2, $this->xo - $x -6, $y-7, $v[1], $this->colour[DARK_GRAY]);
            ImageLine($this->im, $this->xo - CHAR_WIDTH_2, $y, $this->w-1, $y, $this->colour[LIGHT_GRAY]);
            $prev = $y;
         }
      }
   }
   
   function backgroundText($inc,$max,&$a){
      $x = $this->xo + 4;
      $count = 0;
      $need = floor(($this->h - 15) /CHAR_WIDTH_3)-1;
      foreach($a as $s){
         $s = ' '.$s;
         $needrepeat = floor($need/strlen($s))+1;
         $label = substr( str_repeat($s,$needrepeat), 0, $need);
         ImageStringUp($this->im, 3, $x, $this->h - 12, $label, $this->colour[LIGHT_GRAY]);
         $x = $x + $inc;
         if ($count == $max){ break; } else { $count++; }
      }
   }
   

}


// BOXCHART CLASS ///////////////////////////////////////////////////


// assume vertical box

class BoxChart extends Chart {

   function boxAndWhiskers($boxw,$inc,$boxo,$max,&$d){
      $this->boxes($boxw,$inc,$boxo,$max,$d);
      $this->whiskers($boxw,$inc,$boxo,$max,$d);
   }

   function boxes($boxw,$inc,$boxo,$max,&$d){
      $n = sizeof($d);
      if ($n % STATS_SIZE == 0){
         $x = $this->xo + 4;
         $ys = abs($this->yshift) * $this->yscale;
         $count = 0;
         for ($i=0; $i<$n; $i+=STATS_SIZE){
            $xlower = $this->h - ($this->yo + $d[$i+STAT_XLOWER] * $this->yscale + $ys);
            $lower = $this->h - ($this->yo  + $d[$i+STAT_LOWER] * $this->yscale + $ys);
            $upper = $this->h - ($this->yo  + $d[$i+STAT_UPPER] * $this->yscale + $ys);
            $xupper = $this->h - ($this->yo  + $d[$i+STAT_XUPPER] * $this->yscale + $ys);

            ImageLine($this->im, $x+$boxo, $xlower, $x+$boxo, $xupper, $this->colour[DARK_GRAY]);
            ImageLine($this->im, $x+$boxo+1, $xlower, $x+$boxo+1, $xupper, $this->colour[DARK_GRAY]);
            ImageFilledRectangle($this->im, $x, $upper, $x+$boxw, $lower, $this->colour[WHITE]);
            ImageRectangle($this->im, $x, $upper, $x+$boxw, $lower, $this->colour[DARK_GRAY]);

            $x = $x + $boxw + $inc;
            if ($count == $max){ break; } else { $count++;  }
         }
      }
   }

   function whiskers($boxw,$inc,$boxo,$max,&$d){
      $n = sizeof($d);
      if ($n%STATS_SIZE == 0){
         $x = $this->xo + 4;
         $ys = abs($this->yshift) * $this->yscale;
         $count = 0;
         $whisk = floor(($boxw - $boxo)/2);
         for ($i=0; $i<$n; $i+=STATS_SIZE){
            $xlower = $this->h - ($this->yo + $d[$i+STAT_XLOWER] * $this->yscale + $ys);
            $median = $this->h - ($this->yo + $d[$i+STAT_MEDIAN] * $this->yscale + $ys);
            $xupper = $this->h - ($this->yo + $d[$i+STAT_XUPPER] * $this->yscale + $ys);
            ImageLine($this->im, $x+$whisk, $xlower, $x+$boxw-$whisk, $xlower, $this->colour[DARK_GRAY]);
            ImageLine($this->im, $x+$whisk, $xupper, $x+$boxw-$whisk, $xupper, $this->colour[DARK_GRAY]);

            if ($d[$i+STAT_MIN] < $d[$i+STAT_XLOWER]){
               $y = $this->h - ($this->yo + $d[$i+STAT_MIN] * $this->yscale + $ys);
               ImageLine($this->im, $x+$whisk, $y, $x+$boxw-$whisk, $y, $this->colour[DARK_GRAY]);
               ImageLine($this->im, $x+$boxo, $y-5, $x+$boxo, $y, $this->colour[DARK_GRAY]);
               ImageLine($this->im, $x+$boxo+1, $y-5, $x+$boxo+1, $y, $this->colour[DARK_GRAY]);
            }
            if ($d[$i+STAT_MAX] > $d[$i+STAT_XUPPER]){
               $y = $this->h -($this->yo + $d[$i+STAT_MAX] * $this->yscale + $ys);
               ImageLine($this->im, $x+$whisk, $y, $x+$boxw-$whisk, $y, $this->colour[DARK_GRAY]);
               ImageLine($this->im, $x+$boxo, $y, $x+$boxo, $y+5, $this->colour[DARK_GRAY]);
               ImageLine($this->im, $x+$boxo+1, $y, $x+$boxo+1, $y+5, $this->colour[DARK_GRAY]);
            }

            ImageFilledRectangle($this->im, $x, $median-1, $x+$boxw, $median, $this->colour[BLACK]);

            $x = $x + $boxw + $inc;
            if ($count == $max){ break; } else { $count++;  }
         }
      }
   }   

}


// BARCHART CLASS ///////////////////////////////////////////////////

// assume vertical bar

class BarChart extends Chart {
   
   function bars($xo,$barwidth,$inc,$barcolour,&$d,$filled=TRUE){
      $x = $xo;
      foreach($d as $v){
         if ($v > -4){ // no measurement was made
            $y1 = $this->h - $this->yo - $v * $this->yscale;
            $y2 = $this->h - $this->yo;
            if ($v < 0){ $tmp = $y1; $y1 = $y2; $y2 = $tmp; }
            if ($filled){
               ImageFilledRectangle($this->im, $x, $y1, $x + $barwidth, $y2, $this->colour[$barcolour]);
            } else {
               ImageFilledRectangle($this->im, $x, $y1, $x + $barwidth, $y2, $this->colour[WHITE]);
               ImageRectangle($this->im, $x, $y1, $x + $barwidth, $y2, $this->colour[$barcolour]);
            }
         }
         $x += $barwidth + $inc;
      }
      return $x;
   }

}


// LINECHART CLASS ///////////////////////////////////////////////////

// assume horizontal lines

class LineChart extends Chart {
   
   function lines($xo,$linecolour,&$xs,&$ys){
      $x2 = $xo;
      $y2 = $this->yo;
      for ($i=0;$i<sizeof($ys);$i++){
        if ($ys[$i] > log10(NO_VALUE)){ // no measurement was made - LOG10 TOO SPECIFIC

            if (!isset($prevx)){
               $prevx = $xo + ($xs[$i] * $this->xscale + $this->xshift * $this->xscale);
               $prevy = $this->h - $this->yo - ($ys[$i] - $this->yshift)* $this->yscale;
               ImageFilledRectangle($this->im, $prevx-1, $prevy-3, $prevx+3, $prevy+1, $this->colour[$linecolour]);
            } else {
               $x1 = $prevx;
               $y1 = $prevy;

               $x2 = $xo + ($xs[$i] * $this->xscale + $this->xshift * $this->xscale);
               $y2 = $this->h - $this->yo - ($ys[$i] - $this->yshift) * $this->yscale;

               $prevx = $x2;
               $prevy = $y2;
   
               ImageLine($this->im, $x1-1, $y1-1, $x2-1, $y2-1, $this->colour[$linecolour]);
               ImageFilledRectangle($this->im, $prevx-1, $prevy-3, $prevx+3, $prevy+1, $this->colour[$linecolour]);
            }
         }
      }
      return $prevy;
   }

}


// AXIS DEFINITIONS ///////////////////////////////////////////////////

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

?>