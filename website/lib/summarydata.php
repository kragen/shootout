<?php
// Copyright (c) Isaac Gouy 2009-2010

// LIBRARIES ////////////////////////////////////////////////

require_once(LIB_PATH.'lib_whitelist.php');
require_once(LIB);

// DATA LAYOUT ///////////////////////////////////////////////////

// Some code duplication

define('DATA_TEST',0);
define('DATA_LANG',1);
define('DATA_ID',2);
define('DATA_TESTVALUE',3);
define('DATA_STATUS',7);
// With quad-core we changed from CPU Time to Elapsed Time
// but we still want to show the old stuff
if (SITE_NAME == 'debian' || SITE_NAME == 'gp4'){
   define('DATA_TIME',5);
} else {
   define('DATA_TIME',9);
}


// FUNCTIONS ///////////////////////////////////////////

// Some code duplication

function FastestRows($test_rows,$fastest){
   foreach($test_rows as $k => $rows) {
      $testvalue = -1; // assume negative test values are not used
      $time = 360000.0; // 100 hours
      foreach($rows as $row) {
         $row_testvalue = $row[DATA_TESTVALUE];
         if ($row_testvalue > $testvalue){
            $testvalue = $row_testvalue;
            $time = $row[DATA_TIME];
            $id = $row[DATA_ID];
         } elseif ($row_testvalue == $testvalue){
            $row_time = $row[DATA_TIME];
            if ($row_time < $time){
               $testvalue = $row_testvalue;
               $time = $row_time;
               $id = $row[DATA_ID];
            }
         }
      }
      foreach($rows as $row) {
         if ($row[DATA_ID] == $id){
            $fastest[] = $row;
         }
      }
   }
   return $fastest;
}


function DataRows($FileName,&$Tests,&$Langs,&$Incl,&$Excl,$HasHeading=TRUE){
   $data = array();
   $previous = 'not set';
   $test_rows = array();
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

            if ($previous != $test){ // assume ndata.csv is sorted by test
               $data = FastestRows($test_rows,$data);
               $test_rows = array();
            }
            $previous = $test;

            settype($row[DATA_STATUS],'integer');
            settype($row[DATA_TESTVALUE],'integer');
            $testvalue = $row[DATA_TESTVALUE];
            settype($row[DATA_TIME],'double');

            if ($row[DATA_STATUS] == 0){
               $test_rows[$lang][] = $row;
            }

      }
   }
   $data = FastestRows($test_rows,$data);
   return $data;
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

$mark = MarkTime();
$mark = $mark.' '.SITE_NAME;

$MetaKeywords = '';

$faqUrl = CORE_SITE.'help.php';
$bannerUrl = CORE_SITE;


// PAGES ///////////////////////////////////////////////////

$Page = & new Template(LIB_PATH);
$Body = & new Template(LIB_PATH);

$PageId = 'summarydata';
$Title = 'Summary Data';
$TemplateName = 'summarydata.tpl.php';
$Title = $Title.' - Full Data'; $mark = $mark.' n';
$Body->set('DataSet', 'ndata');
$Body->set('Data', DataRows(DATA_PATH.'ndata.csv', $Tests, $Langs, $Incl, $Excl));
$Body->set('Title', $Title);
$metaRobots = '<meta name="robots" content="noindex,nofollow,noarchive" />';

// TEMPLATE VARS ////////////////////////////////////////////////

$Page->set('PageTitle', $Title.BAR.'Computer&nbsp;Language&nbsp;Benchmarks&nbsp;Game');
$Page->set('BannerTitle', BANNER_TITLE);
$Page->set('FaqTitle', FAQ_TITLE);
$Page->set('BannerUrl', $bannerUrl);
$Page->set('FaqUrl', $faqUrl);
$Body->set('Mark', $mark);
$Body->set('Tests', $Tests);
$Body->set('Langs', $Langs);

$Page->set('PageBody', $Body->fetch($TemplateName));
$Page->set('Robots', $metaRobots);
$Page->set('MetaKeywords', $MetaKeywords);
$Page->set('PageId', $PageId);

echo $Page->fetch('page.tpl.php');
?>



