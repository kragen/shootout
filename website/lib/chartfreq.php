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
 ,array(2006,7,'gp4',0.06)
 ,array(2006,8,'gp4',0.08)
 ,array(2006,9,'gp4',0.08)
 ,array(2006,10,'gp4',0.09)
 ,array(2006,11,'gp4',0.10)
 ,array(2006,12,'gp4',0.11)
 ,array(2006,13,'gp4',0.11)
 ,array(2007,14,'gp4',0.12)
 ,array(2007,15,'gp4',0.13)
 ,array(2007,16,'gp4',0.14)
 ,array(2007,17,'gp4',0.15)
 ,array(2007,18,'gp4',0.16)
 ,array(2007,19,'gp4',0.25)
 ,array(2007,20,'gp4',0.25)
 ,array(2007,21,'gp4',0.27)
 ,array(2007,22,'gp4',0.29)
 ,array(2007,23,'gp4',0.30)
 ,array(2007,24,'gp4',0.33)
 ,array(2007,25,'gp4',0.35)
 ,array(2008,26,'gp4',0.41)
 ,array(2008,27,'gp4',0.45)
 ,array(2008,28,'gp4',0.52)
 ,array(2008,29,'gp4',0.64)
 ,array(2008,30,'gp4',0.77)
 ,array(2008,31,'gp4',0.84)
 ,array(2008,32,'gp4',1.00)
       )
       ,array(
  array(2007,14,'debian',0.14)
 ,array(2007,15,'debian',0.15)
 ,array(2007,16,'debian',0.16)
 ,array(2007,17,'debian',0.24)
 ,array(2007,18,'debian',0.26)
 ,array(2007,19,'debian',0.30)
 ,array(2007,20,'debian',0.30)
 ,array(2007,21,'debian',0.30)
 ,array(2007,22,'debian',0.30)
 ,array(2007,23,'debian',0.32)
 ,array(2007,24,'debian',0.39)
 ,array(2007,25,'debian',0.89)
 ,array(2008,26,'debian',1.00)
        )
       ,array(
  array(2008,33,'u32q',0.00)
 ,array(2008,34,'u32q',0.08)
 ,array(2008,35,'u32q',0.11)
 ,array(2008,36,'u32q',0.14)
 ,array(2008,37,'u32q',0.15)
 ,array(2009,38,'u32q',0.18)
 ,array(2009,39,'u32q',0.21)
 ,array(2009,40,'u32q',0.21)
 ,array(2009,41,'u32q',0.31)
 ,array(2009,42,'u32q',0.36)
 ,array(2009,43,'u32q',0.41)
 ,array(2009,44,'u32q',0.44)
 ,array(2009,45,'u32q',0.49)
 ,array(2009,46,'u32q',0.52)
 ,array(2009,47,'u32q',0.57)
 ,array(2009,48,'u32q',0.88)
 ,array(2009,49,'u32q',1.00)
       ) );
       


// CHART /////////////////////////////////////////////////////

$chart = new StepChart();

$chart->yscale = 1.7;
$chart->yAxis(axisPercent(axis10()));
$chart->xAxis(axisYrMth(),6.0);

$chart->steps(GP4,$d[0]);
$chart->steps(DEBIAN,$d[1]);
$chart->steps(U32Q,$d[2]);

$chart->title('Cumulative Percentage of Measurements by Month');
$chart->xAxisLegend('month');
$chart->yAxisLegend('cumulative percentage');
$chart->frame();
$chart->complete();

?>
