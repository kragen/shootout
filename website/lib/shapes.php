<?php
// Copyright (c) Isaac Gouy 2010

// Some code duplication

// LIBRARIES ////////////////////////////////////////////////
require_once(LIB_PATH.'lib_whitelist.php');
require_once(LIB);

// DATA LAYOUT ///////////////////////////////////////////////////

define('DATA_TEST',0);
define('DATA_LANG',1);
define('DATA_ID',2);
define('DATA_GZ',4);
define('DATA_STATUS',7);
// With quad-core we changed from CPU Time to Elapsed Time
// but we still want to show the old stuff
if (SITE_NAME == 'debian' || SITE_NAME == 'gp4'){
   define('DATA_TIME',5);
} else {
   define('DATA_TIME',9);
}

// FUNCTIONS ///////////////////////////////////////////

function Median($a){
   $n = sizeof($a);
   $mid = floor($n / 2);
   return ($n % 2 != 0) ? $a[$mid] : ($a[$mid-1] + $a[$mid]) / 2.0;
}

function ValidRowsAndMins($FileName,$Tests,$Langs,$Incl,$Excl,$HasHeading=TRUE){
   $time_mins = array();
   $gz_mins = array();
   foreach($Tests as $k => $v){
      // unreasonably large initial values, data should always be smaller
      $time_mins[$k] = 360000.0; // 100 hours 
      $gz_mins[$k] = 102400; // 100 Kb
   }
   $data = array();

   $lines = @file($FileName) or die ('Cannot open $FileName');
   if ($HasHeading){ unset($lines[0]); } // remove header line
   foreach($lines as $line) {
      $row = explode( ',', $line);
      $test = $row[DATA_TEST];
      $lang = $row[DATA_LANG];
      $key = $test.$lang.$row[DATA_ID];

      // accumulate all acceptable datarows, exclude duplicates

      if (isset($Incl[$test]) && isset($Incl[$lang]) &&
               isset($Langs[$lang]) &&
                  !isset($Excl[$key])){

            settype($row[DATA_STATUS],'integer');
            settype($row[DATA_TIME],'double');
            $row_time = $row[DATA_TIME];

            if ($row[DATA_STATUS] == 0 && (
                  ($row_time > 0.0 && (!isset($data[$lang][$test]) ||
                     $row_time < $data[$lang][$test][DATA_TIME])))){

               settype($row[DATA_ID],'integer');
               settype($row[DATA_GZ],'integer');
               $data[$lang][$test] = $row;

               if ($row_time < $time_mins[$test]){
                  $time_mins[$test] = $row_time;
               }
               $row_gz = $row[DATA_GZ];
               if ($row_gz > 0 && $row_gz < $gz_mins[$test]){
                  $gz_mins[$test] = $row_gz;
               }
            }

      }
   }
   return array($data,$time_mins,$gz_mins);
}


function TimeSizeShapes($FileName,$Tests,$Langs,$Incl,$Excl,$HasHeading=TRUE){
   list($data,$time_mins,$gz_mins) = ValidRowsAndMins($FileName,$Tests,$Langs,$Incl,$Excl,$HasHeading);

   $shapes = array(); $medians = array();

   foreach($data as $k => $test){
      // javasteady source code includes an extra loop
      if ((sizeof($test)/sizeof($Tests) > 0.5) && $k != 'javasteady'){

         $points = array(); $xs = array(); $ys = array();
         unset($minpoint);
         foreach($test as $t => $v){

            // wait until now to filter so sizeof($test) is consistent with FullWeightedData
            if ($Tests[$t][TEST_WEIGHT]>0){
               // normalized source code size on X, normalized measured time on Y
               $x = $v[DATA_GZ]/$gz_mins[$t];
               $y = $v[DATA_TIME]/$time_mins[$t];
               $points[] = array($x,$y);
               $xs[] = $x; // collect for median
               $ys[] = $y; // collect for median
            }
         }

         $shapes[$k] = $points;
         sort($xs);
         $xm = Median($xs);
         sort($ys);
         $ym = Median($ys);
         $medians[$k] = array($xm,$ym); // median
      }
   }
   return array($shapes,$medians);
}


function MarkTime($PathRoot=''){
   if (SITE_NAME == 'debian'){
      $Mark = 'late 2007';
   } elseif (SITE_NAME == 'gp4'){
      $Mark = 'mid 2008';
   } else {
      $mtime = filemtime($PathRoot.DATA_PATH.'data.csv');
      $Mark = gmdate("d M Y", $mtime);
   }
   return $Mark;
}

// DATA ///////////////////////////////////////////

list($Incl,$Excl) = WhiteListInEx();
$Tests = WhiteListUnique('test.csv',$Incl); // assume test.csv in name order
$Langs = WhiteListUnique('lang.csv',$Incl); // assume lang.csv in name order
$mark = MarkTime().' '.SITE_NAME;

$DataSet = 'data';
$MetaKeywords = '';

// PAGES ///////////////////////////////////////////////////

$Page = & new Template(LIB_PATH);
$Body = & new Template(LIB_PATH);

$PageId = 'shapes';
$Title = 'Code-used Time-used Shapes';

$Body->set('Title', $Title);
$TemplateName = 'shapes.tpl.php';
$About = & new Template(ABOUT_PATH);
$AboutTemplateName = 'shapes-about.tpl.php';
if (! file_exists(ABOUT_PATH.$AboutTemplateName)){ $AboutTemplateName = 'blank-about.tpl.php'; }
$Body->set('DataSet', $DataSet);
$Body->set('Data', TimeSizeShapes(DATA_PATH.$DataSet.'.csv', $Tests, $Langs, $Incl, $Excl));

$faqUrl = CORE_SITE.'help.php';
$bannerUrl = CORE_SITE;

if (SITE_NAME == 'u32' || SITE_NAME == 'u32q' || SITE_NAME == 'u64' || SITE_NAME == 'u64q'){
   $metaRobots = '<meta name="robots" content="all" />';
} else {
   $metaRobots = '<meta name="robots" content="noindex,nofollow,noarchive" />';
}
$metaKeywords = '<meta name="description" content="Look for patterns in Code-used Time-used Shapes ('.PLATFORM_NAME.') &amp; find out how your favorite language compares." />';

// TEMPLATE VARS ////////////////////////////////////////////////

$Page->set('PageTitle', $Title.BAR.'Computer&nbsp;Language&nbsp;Benchmarks&nbsp;Game');
$Page->set('BannerTitle', BANNER_TITLE);
$Page->set('FaqTitle', FAQ_TITLE);
$Page->set('BannerUrl', $bannerUrl);
$Page->set('FaqUrl', $faqUrl);
$Body->set('Mark', $mark);
$Body->set('About', $About->fetch($AboutTemplateName));
$Body->set('Langs', $Langs);

$Page->set('PageBody', $Body->fetch($TemplateName));
$Page->set('Robots', $metaRobots);
$Page->set('MetaKeywords', $metaKeywords);
$Page->set('PageId', $PageId);

echo $Page->fetch('page.tpl.php');
?>