<?
// Copyright (c) Isaac Gouy 2009-2011

// CONSTANTS ///////////////////////////////////////////////////

define('CHAR_WIDTH_2',6.0);
define('CHAR_WIDTH_3',7.0);
define('MARGIN',16);
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
define('DEBIAN',9);
define('GP4',10);
define('U32Q',11);

define('MIRROR_AXIS',0);

// CHART CLASS ///////////////////////////////////////////////////


class Chart {
   var $im,$w,$h,$colour;
   var $xo,$xscale,$xshift,$xaxis;
   var $yo,$yscale,$yshift,$yaxis;


   function Chart(){
      $this->w = $this->defaultWidth();
      $this->h = $this->defaultHeight();

      $this->im = ImageCreate($this->w,$this->h);
      ImageColorAllocate($this->im,255,255,255);
      $this->initializeColours();

      // chart origin may be temporarily reset to create multiple panels
      $this->xo = $this->defaultOriginX();
      $this->yo = $this->defaultOriginY();
   }

   function defaultWidth(){
      return 480;
   }
   
   function defaultHeight(){
      return 300;
   }
   
   function defaultOriginX(){
      return 48;
   }

   function defaultOriginY(){
      return MARGIN;
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
      $this->colour[DEBIAN] = ImageColorAllocate($this->im,0,0,128);
      $this->colour[GP4] = ImageColorAllocate($this->im,123,89,222);
      $this->colour[U32Q] = ImageColorAllocate($this->im,255,99,9);
   }

   function frame(){
      ImageLine($this->im, $this->xo, MARGIN, $this->xo, $this->h-MARGIN, $this->colour[DARK_GRAY]); // y-axis
      ImageLine($this->im, $this->w -1, MARGIN, $this->w -1, $this->h-MARGIN, $this->colour[GRAY]);
      ImageLine($this->im, $this->xo, $this->h - $this->yo, $this->w -1, $this->h - $this->yo, $this->colour[DARK_GRAY]); // x-axis
   }
   

   function title($label){
      $this->title_($label,3,CHAR_WIDTH_3);
   }

   function title_($label,$textsize,$charwidth){
      $width = $this->w - $this->xo;
      $inset = ($width - strlen($label)*$charwidth)/2.0;
      if ($inset < 0){
         $x = $this->w - strlen($label)*$charwidth;
      } else {
         $x = $this->xo + $inset;
      }
      ImageString($this->im, $textsize, $x, 0, $label, $this->colour[BLACK]);
   }

   function notice($label){
      $x = $this->w - strlen($label)*CHAR_WIDTH_2;
      ImageString($this->im, 2, $x, $this->h - 15, $label, $this->colour[DARK_GRAY]);
      return $x;
   }

   function xAxisLegend($label,$size=null){
      if (!isset($size)){ $size = $this->w; }
      $x = ($size - $this->xo - strlen($label)*CHAR_WIDTH_2)/2.0;
      ImageString($this->im, 2, $x + $this->xo, $this->h - 15, $label, $this->colour[BLACK]);
   }
   
   function yAxisLegend($label,$size=null){
      if (!isset($size)){ $size = $this->h; }
      $y = ($size - $this->yo - strlen($label)*CHAR_WIDTH_2)/2.0;
      ImageStringUp($this->im, 2, 5, $this->h - $y - $this->yo, $label, $this->colour[BLACK]);
   }

   function shiftAndScale(){
      if (isset($this->yaxis)){
         $this->yshift = $this->yaxis[0][0];
         $max = $this->yaxis[ sizeof($this->yaxis) - 1][0];
         $valuerange = ($this->yshift < 0) ? abs($max - $this->yshift) : $max - $this->yshift;
         $this->yscale = ($this->h - (2 * $this->yo)) / $valuerange;
      }
   }

   function yAxis($yaxis,$scale=null,$shift=null,$axistype=null){
      $this->yaxis = $yaxis;

      if (isset($scale)){
         $this->yscale = $scale;
         $this->yshift = $shift;
      } else {
         $this->shiftAndScale();
      }
      if (isset($axistype)){ $dir = -1.0; } else { $dir = 1.0; }

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
   
   function xAxis($xaxis,$scale,$shift=null){
      $this->xaxis = $xaxis;
      $this->xscale = $scale;
      if (isset($shift)){ $this->xshift = $shift; } else { $this->xshift = 0; }
      foreach($this->xaxis as $v){
         $x = $this->xo + ($v[0] * $this->xscale + $this->xshift * $this->xscale);
         ImageStringUp($this->im, 3, $x, $this->h - $this->yo - 0.5*CHAR_WIDTH_3, $v[1], $this->colour[LIGHT_GRAY]);
         ImageLine($this->im, $x, $this->h - $this->yo, $x, $this->yo, $this->colour[LIGHT_GRAY]);
      }
   }

}


// BOXCHART CLASS ///////////////////////////////////////////////////


// assume vertical box

class BoxChart extends Chart {

   var $boxwidth,$boxspace;

   function BoxChart(){
      Chart::Chart();
      $this->boxwidth = 20;
      $this->boxspace = 8;
      $this->boxmiddle = 10;
      $this->maxboxes = 15;
   }

   function boxAndWhiskers($d){
      $this->boxes($d);
      $this->whiskers($d);
   }

   function boxes($d){
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

            ImageLine($this->im, $x+$this->boxmiddle, $xlower, $x+$this->boxmiddle, $xupper, $this->colour[DARK_GRAY]);
            ImageLine($this->im, $x+$this->boxmiddle+1, $xlower, $x+$this->boxmiddle+1, $xupper, $this->colour[DARK_GRAY]);
            ImageFilledRectangle($this->im, $x, $upper, $x+$this->boxwidth, $lower, $this->colour[WHITE]);
            ImageRectangle($this->im, $x, $upper, $x+$this->boxwidth, $lower, $this->colour[DARK_GRAY]);

            $x = $x + $this->boxwidth + $this->boxspace;
            if ($count == $this->maxboxes){ break; } else { $count++;  }
         }
      }
   }

   function whiskers($d){
      $n = sizeof($d);
      if ($n%STATS_SIZE == 0){
         $x = $this->xo + 4;
         $ys = abs($this->yshift) * $this->yscale;
         $count = 0;
         $whisk = floor(($this->boxwidth - $this->boxmiddle)/2);
         for ($i=0; $i<$n; $i+=STATS_SIZE){
            $xlower = $this->h - ($this->yo + $d[$i+STAT_XLOWER] * $this->yscale + $ys);
            $median = $this->h - ($this->yo + $d[$i+STAT_MEDIAN] * $this->yscale + $ys);
            $xupper = $this->h - ($this->yo + $d[$i+STAT_XUPPER] * $this->yscale + $ys);
            ImageLine($this->im, $x+$whisk, $xlower, $x+$this->boxwidth-$whisk, $xlower, $this->colour[DARK_GRAY]);
            ImageLine($this->im, $x+$whisk, $xupper, $x+$this->boxwidth-$whisk, $xupper, $this->colour[DARK_GRAY]);

            if ($d[$i+STAT_MIN] < $d[$i+STAT_XLOWER]){
               $y = $this->h - ($this->yo + $d[$i+STAT_MIN] * $this->yscale + $ys);
               ImageLine($this->im, $x+$whisk, $y, $x+$this->boxwidth-$whisk, $y, $this->colour[DARK_GRAY]);
               ImageLine($this->im, $x+$this->boxmiddle, $y-5, $x+$this->boxmiddle, $y, $this->colour[DARK_GRAY]);
               ImageLine($this->im, $x+$this->boxmiddle+1, $y-5, $x+$this->boxmiddle+1, $y, $this->colour[DARK_GRAY]);
            }
            if ($d[$i+STAT_MAX] > $d[$i+STAT_XUPPER]){
               $y = $this->h -($this->yo + $d[$i+STAT_MAX] * $this->yscale + $ys);
               ImageLine($this->im, $x+$whisk, $y, $x+$this->boxwidth-$whisk, $y, $this->colour[DARK_GRAY]);
               ImageLine($this->im, $x+$this->boxmiddle, $y, $x+$this->boxmiddle, $y+5, $this->colour[DARK_GRAY]);
               ImageLine($this->im, $x+$this->boxmiddle+1, $y, $x+$this->boxmiddle+1, $y+5, $this->colour[DARK_GRAY]);
            }

            ImageFilledRectangle($this->im, $x, $median-1, $x+$this->boxwidth, $median, $this->colour[BLACK]);

            $x = $x + $this->boxwidth + $this->boxspace;
            if ($count == $this->maxboxes){ break; } else { $count++;  }
         }
      }
   }
   
   function backgroundText($a){
      $x = $this->xo + 2;
      $count = 0;
      $need = floor(($this->h - 15) /CHAR_WIDTH_3)-1;
      foreach($a as $s){
         $s = ' '.$s;
         $needrepeat = floor($need/strlen($s))+1;
         $label = substr( str_repeat($s,$needrepeat), 0, $need);
         ImageStringUp($this->im, 3, $x, $this->h - 12, $label, $this->colour[GRAY]);
         $x = $x + $this->boxwidth + $this->boxspace;
         if ($count == $this->maxboxes){ break; } else { $count++; }
      }
   }

   function autoBoxspace($a){
      $boxspace = 4;
      if (sizeof($a)>0){
         $n = sizeof($a)/STATS_SIZE;
         $i = 1;
         while ($n * ($this->boxwidth + $i) <= $this->w - $this->xo){ $i++; }
         $this->boxspace = $i-1;
      }
   }

}


// BARCHART CLASS ///////////////////////////////////////////////////

// assume vertical bar

class BarChart extends Chart {
   var $barwidth,$barspace;

   function BarChart(){
      Chart::Chart();
      $this->barwidth = 3;
      $this->barspace = 3;
   }

   function defaultHeight(){
      return 225;
   }

   function bars($barcolour,$d,$filled=TRUE){
      $x = $this->xo;
      foreach($d as $v){
         if ($v > -4){ // no measurement was made
            $y1 = $this->h - $this->yo - $v * $this->yscale;
            $y2 = $this->h - $this->yo;
            if ($v < 0){ $tmp = $y1; $y1 = $y2; $y2 = $tmp; }
            if ($filled){
               ImageFilledRectangle($this->im, $x, $y1, $x + $this->barwidth, $y2, $this->colour[$barcolour]);
            } else {
               ImageFilledRectangle($this->im, $x, $y1, $x + $this->barwidth, $y2, $this->colour[WHITE]);
               ImageRectangle($this->im, $x, $y1, $x + $this->barwidth, $y2, $this->colour[$barcolour]);
            }
         }
         $x += $this->barwidth + $this->barspace;
      }
      return $x;
   }
}


class ComparisonChart extends BarChart {

   function defaultHeight(){
      return Chart::defaultHeight();
   }
}

// LINECHART CLASS ///////////////////////////////////////////////////

// assume horizontal lines

class LineChart extends Chart {

   function lines($linecolour,$xs,$ys){
      $x2 = $this->xo;
      $y2 = $this->yo;
      for ($i=0;$i<sizeof($ys);$i++){
        if ($ys[$i] > log10(NO_VALUE)){ // no measurement was made - LOG10 TOO SPECIFIC

            if (!isset($prevx)){
               $prevx = $this->xo + ($xs[$i] * $this->xscale + $this->xshift * $this->xscale);
               $prevy = $this->h - $this->yo - ($ys[$i] - $this->yshift)* $this->yscale;
               ImageFilledRectangle($this->im, $prevx-1, $prevy-3, $prevx+3, $prevy+1, $this->colour[$linecolour]);
            } else {
               $x1 = $prevx;
               $y1 = $prevy;

               $x2 = $this->xo + ($xs[$i] * $this->xscale + $this->xshift * $this->xscale);
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


// STEPCHART CLASS ///////////////////////////////////////////////////


class StepChart extends Chart {
   
   function defaultWidth(){
      return 400;
   }
   
   function defaultHeight(){
      return 225;
   }
   
   function steps($linecolour,$d){
      $x = $this->xo;
      $y = $this->h - $this->yo;
      foreach($d as $p){
         if (!isset($prev)){
            $prev = $p;
         } else {
            $x1 = $x + $prev[1] * $this->xscale;
            $y1 = $y - 100.0*$prev[3] * $this->yscale;

            $x3 = $x + $p[1] * $this->xscale;
            $y3 = $y - 100.0*$p[3] * $this->yscale;
   
            $x2 = $x3;
            $y2 = $y1;

            ImageFilledRectangle($this->im, $x1, $y1-1, $x2+1, $y2, $this->colour[$linecolour]);
            ImageFilledRectangle($this->im, $x3, $y3-1, $x2+1, $y2, $this->colour[$linecolour]);
   
            $prev = $p;
         }
      }
      $x1 = $x + $prev[1] * $this->xscale + 1.0 * $this->xscale;
      ImageFilledRectangle($this->im, $x3, $y3-1, $x1, $y3, $this->colour[$linecolour]);
   }

}


// SHAPECHART CLASS ///////////////////////////////////////////////////


class ShapeChart extends Chart {
   
   // individual points and lines from centroid to those points
   
   function defaultWidth(){
      return 150;
   }

   function defaultHeight(){
      return 120;
   }
   
   function shapes($d,$c){
      $n = sizeof($d);
      if ($n % 2 == 0){
         $xs = $this->xshift * $this->xscale;
         $ys = $this->yshift * $this->yscale;
         $cx = $this->xo + $c[0] * $this->xscale + $xs;
         $cy = $this->h - ($this->yo + $c[1] * $this->yscale + $ys);
         for ($i=0; $i<$n; $i+=2){
            $x1 = $this->xo + $d[$i] * $this->xscale + $xs;
            $y1 = $this->h - ($this->yo + $d[$i+1] * $this->yscale + $ys);
            ImageLine($this->im, $cx, $cy, $x1, $y1, $this->colour[DARK_GRAY]);
         }
         for ($i=0; $i<$n; $i+=2){
            $x1 = $this->xo + $d[$i] * $this->xscale + $xs;
            $y1 = $this->h - ($this->yo + $d[$i+1] * $this->yscale + $ys);
            ImageFilledRectangle($this->im, $x1-2, $y1-2, $x1+2, $y1+2, $this->colour[BLACK]);
         }
      }
   }
}


// AXIS DEFINITIONS ///////////////////////////////////////////////////


function axis10(){
   return array(
      array(0,"0"), array(10,"10"), array(20,"20"),  array(30,"30"),  array(40,"40"),
      array(50,"50"), array(60,"60"), array(70,"70"),  array(80,"80"),  array(90,"90"),
      array(100,"100")
      );
}


function axis100(){
   return array(
      array(1,"1"), array(3,"3"), array(5,"5"),
      array(10,"10"), array(30,"30"), array(50,"50"),
      array(100,"100")
      );
}

function axis250(){
   return array(
      array(1,"1"), array(10,"10"), array(50,"50"),  array(100,"100"),  array(150,"150"),
      array(200,"200"), array(250,"250") 
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
      array(1,""), array(3,"3×"), array(10,"10×"), array(30,"30×"),
      array(100,"100×"), array(300,"300×"), array(1000,"1000×")
      );
}

function axis3_10_Mirror(){
   return array(
      array(1,""), array(3,"1/3"), array(10,"1/10"), array(30,"1/30"),
      array(100,"1/100"), array(300,"1/300"), array(1000,"1/1000")
      );
}

function axis3_5_10(){
   return array(
      array(1,""), array(3,"3"), array(5,""), array(10,"10"), array(30,"30"),
      array(50,""), array(100,"100"), array(300,"300"), array(500,""), array(1000,"1000")
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


function log10axis($a){
   $log10a = array();
   foreach($a as $v){ $log10a[] = array(log10($v[0]),$v[1]); }
   return $log10a;
}


function axisPercent($a){
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

function axisYrMth(){
   return array(
      array(1,"2007"),
      array(13,"2008"), array(25,"2009"),
      array(37,"2010"), array(49,"2011")
      );
}

function axisOneTen(){
   return array(
      array(1,"1"), array(2,"2"),
      array(3,"3"), array(5,"5"),
      array(10,"10")
      );
}



?>
