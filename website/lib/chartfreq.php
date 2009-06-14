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
 ,array(2008,34,'u32q',0.16)
 ,array(2008,35,'u32q',0.20)
 ,array(2008,36,'u32q',0.22)
 ,array(2008,37,'u32q',0.23)
 ,array(2009,38,'u32q',0.30)
 ,array(2009,39,'u32q',0.35)
 ,array(2009,40,'u32q',0.42)
 ,array(2009,41,'u32q',0.73)
 ,array(2009,42,'u32q',0.88)
 ,array(2009,43,'u32q',0.99)
       ) );
       


// CHART /////////////////////////////////////////////////////

$chart = new StepChart();

$chart->yscale = 1.7;
$chart->yAxis(axisPercent(axis10()));
$chart->xAxis(axisYrMth(),6.0);

$chart->steps(GP4,$d[0]);
$chart->steps(DEBIAN,$d[1]);
$chart->steps(U32Q,$d[2]);

$chart->title('Cumulative Percentage of Current Measurements by Month');
$chart->xAxisLegend('month');
$chart->yAxisLegend('cumulative percentage');
$chart->frame();
$chart->complete();

?>
