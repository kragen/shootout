<?
header("Content-type: image/png");

// Copyright (c) Isaac Gouy 2009

// LIBRARIES ////////////////////////////////////////////////

require_once(LIB_PATH.'lib_chart.php');


// DATA ////////////////////////////////////////////////////

$d = array(
      array(
  array(2005,0,'gp4',0.01)
 ,array(2005,1,'gp4',0.02)
 ,array(2006,2,'gp4',0.03)
 ,array(2006,3,'gp4',0.04)
 ,array(2006,4,'gp4',0.05)
 ,array(2006,5,'gp4',0.05)
 ,array(2006,6,'gp4',0.05)
 ,array(2006,7,'gp4',0.05)
 ,array(2006,8,'gp4',0.07)
 ,array(2006,10,'gp4',0.09)
 ,array(2006,11,'gp4',0.10)
 ,array(2006,12,'gp4',0.10)
 ,array(2006,13,'gp4',0.10)
 ,array(2007,14,'gp4',0.12)
 ,array(2007,15,'gp4',0.12)
 ,array(2007,16,'gp4',0.13)
 ,array(2007,17,'gp4',0.15)
 ,array(2007,18,'gp4',0.15)
 ,array(2007,19,'gp4',0.24)
 ,array(2007,20,'gp4',0.24)
 ,array(2007,21,'gp4',0.26)
 ,array(2007,22,'gp4',0.28)
 ,array(2007,23,'gp4',0.29)
 ,array(2007,24,'gp4',0.32)
 ,array(2007,25,'gp4',0.34)
 ,array(2008,26,'gp4',0.40)
 ,array(2008,27,'gp4',0.43)
 ,array(2008,28,'gp4',0.51)
 ,array(2008,29,'gp4',0.63)
 ,array(2008,30,'gp4',0.78)
 ,array(2008,31,'gp4',0.82)
 ,array(2008,32,'gp4',0.98)
       )
       ,array(
  array(2007,14,'debian',0.14)
 ,array(2007,15,'debian',0.15)
 ,array(2007,16,'debian',0.16)
 ,array(2007,17,'debian',0.24)
 ,array(2007,18,'debian',0.26)
 ,array(2007,19,'debian',0.29)
 ,array(2007,23,'debian',0.31)
 ,array(2007,24,'debian',0.38)
 ,array(2007,25,'debian',0.88)
 ,array(2008,27,'debian',0.99)
        )
       ,array(
  array(2008,33,'u32q',0.00)
 ,array(2008,34,'u32q',0.36)
 ,array(2008,35,'u32q',0.44)
 ,array(2008,36,'u32q',0.50)
 ,array(2008,37,'u32q',0.57)
 ,array(2009,38,'u32q',0.84)
 ,array(2009,39,'u32q',0.99)
       ) );
       
       
function axisYrMth(){
   return array(
      array(2,"2006"), array(14,"2007"),
      array(26,"2008"), array(38,"2009"), 
      array(50,"2010"), array(62,"2011")
      );
}


/*
function chartSteps(&$im,$xo,$yo,$h,$xscale,$yscale,$linecol,&$d){
   $x = $xo;
   $y = $h - $yo;
   foreach($d as $p){
      if (!isset($prev)){
         $prev = $p;
      } else {
         $x1 = $x + $prev[1]*$xscale;
         $y1 = $y - 100.0*$prev[3]*$yscale;

         $x3 = $x + $p[1]*$xscale;
         $y3 = $y - 100.0*$p[3]*$yscale;

         $x2 = $x3;
         $y2 = $y1;

         ImageFilledRectangle($im, $x1, $y1-1, $x2+1, $y2, $linecol);
         ImageFilledRectangle($im, $x3, $y3-1, $x2+1, $y2, $linecol);

         $prev = $p;
      }
   }
   $x1 = $x + $prev[1]*$xscale + 1.0*$xscale;
   ImageFilledRectangle($im, $x3, $y3-1, $x1, $y3, $linecol);
}
*/


// CHART /////////////////////////////////////////////////////
   $w = 400;
   $h = 225;

   $boxspace = 8;
   $xo = 65;
   $yo = 16;

   $xscale = 6.0;
   $yscale = 1.7;

   $boxw = 20;
   $boxo = 10;
   $whisk = floor(($boxw - $boxo)/2);
   $outlier = 5;
   $maxboxes= 15;

$im = ImageCreate($w,$h);

ImageColorAllocate($im,255,255,255);
$white = ImageColorAllocate($im,255,255,255);
$black = ImageColorAllocate($im,0,0,0);
$gray = ImageColorAllocate($im,221,221,221);
$bgray = ImageColorAllocate($im,185,185,185);
$mgray = ImageColorAllocate($im,145,145,145);

$debian = ImageColorAllocate($im,0,0,128);
$gp4 = ImageColorAllocate($im,123,89,222);
$u32q = ImageColorAllocate($im,255,99,9);


// GRID
yAxisGrid($im,$xo,$yo,$w,$h,$yscale,$bgray,$gray,0,axisPercent(axis10s()));
xAxisGrid($im,$xo,$yo,$w,$h,$xscale,$yscale,$bgray,$gray,0,axisYrMth());

chartSteps(&$im,$xo,$yo,$h,$xscale,$yscale,$gp4,$d[0]);
chartSteps(&$im,$xo,$yo,$h,$xscale,$yscale,$debian,$d[1]);
chartSteps(&$im,$xo,$yo,$h,$xscale,$yscale,$u32q,$d[2]);

yAxisLegend($im,$yo,$w,$h,$black,'cumulative percentage');
xAxisLegend($im,$xo,$w,$h,$black,'month');

// TITLE
ImageString($im, 3, 0, 2, 'Cumulative Percentage of Current Measurements by Month', $black);

ImageInterlace($im,1);
ImagePNG($im);
ImageDestroy($im);
?>
