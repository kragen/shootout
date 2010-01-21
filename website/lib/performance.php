<?php
// Copyright (c) Isaac Gouy 2010

// LIBRARIES ////////////////////////////////////////////////

require_once(LIB_PATH.'lib_whitelist.php');
require_once(LIB);
require_once(LIB_PATH.'lib_data.php');


// FUNCTIONS ///////////////////////////////////////////

function BenchmarkData($FileName,$Test,$Langs,$Incl,$Excl,$Sort,$HasHeading=TRUE){
   $lines = @file($FileName) or die ('Cannot open $FileName');
   if ($HasHeading){ unset($lines[0]); } // remove header line

   $prefix = substr($Test,1).',';
   $succeeded = array();
   $failed = array();
   $special = array();

   $time_min = 360000.0; // 100 hours
   $mem_min = 1024000000;
   $DATA_TIME_SORT = $Sort=='fullcpu' ? DATA_FULLCPU : DATA_TIME;

   foreach($lines as $line) {
      if (strpos($line,$prefix)){
         $row = explode( ',', $line);
         $lang = $row[DATA_LANG];

         if (isset($Incl[$lang])){
            $exclude = $Excl[ $Test.$lang.$row[DATA_ID] ];
            if ($exclude){
               continue;
            }

            settype($row[DATA_ID],'integer');
            settype($row[DATA_TESTVALUE],'integer');
            settype($row[DATA_GZ],'integer');
            settype($row[DATA_FULLCPU],'double');
            settype($row[DATA_MEMORY],'integer');
            settype($row[DATA_STATUS],'integer');
            settype($row[DATA_ELAPSED],'double');

            if (isset($exclude)){
               $special[] = $row;
            } elseif ($row[DATA_STATUS]){
               $failed[] = $row;
            } else {
               $succeeded[] = $row;
               
               $row_time = $row[$DATA_TIME_SORT];
               if ($row_time > 0.0 && $row_time < $time_min){
                  $time_min = $row_time;
               }
               $row_mem = $row[DATA_MEMORY];
               if ($row_mem > 0 && $row_mem < $mem_min){
                  $mem_min = $row_mem;
               }

            }
         }
      }
   }
   
   if ($Sort=='fullcpu'){
      usort($succeeded, 'CompareFullCpuTime');
      usort($special, 'CompareFullCpuTime');
   } elseif ($Sort=='kb'){
      usort($succeeded, 'CompareMemoryUse');
      usort($special, 'CompareMemoryUse');
   } elseif ($Sort=='gz'){
      usort($succeeded, 'CompareGz');
      usort($special, 'CompareGz');
   } elseif ($Sort=='elapsed'){
      usort($succeeded, 'CompareElapsed');
      usort($special, 'CompareElapsed');
   }

   $time_ratios = array();
   $mem_ratios = array();
   
   if ($mem_min < 200){ $mem_min = 200; }
   settype($mem_min,'double');

   foreach($succeeded as $row){
      $row_time = $row[$DATA_TIME_SORT];
      $time_ratios[] = $row_time > 0.0 ? $row_time/$time_min : 1.0;
      $row_mem = $row[DATA_MEMORY];
      $mem_ratios[] = $row_mem > 200 ? $row_mem/$mem_min : 1.0;
   }

   return array($succeeded,$failed,$special,$time_ratios,$mem_ratios);
}


function CompareFullCpuTime($a, $b){
   return  ($a[DATA_FULLCPU] < $b[DATA_FULLCPU]) ? -1 :
      ($a[DATA_FULLCPU] > $b[DATA_FULLCPU] ? 1 : 0);
}

function CompareMemoryUse($a, $b){
   return  ($a[DATA_MEMORY] < $b[DATA_MEMORY]) ? -1 :
      ($a[DATA_MEMORY] > $b[DATA_MEMORY] ? 1 : 0);
}

function CompareGz($a, $b){
   return  ($a[DATA_GZ] < $b[DATA_GZ]) ? -1 :
      ($a[DATA_GZ] > $b[DATA_GZ] ? 1 : 0);
}

function CompareElapsed($a, $b){
   return  ($a[DATA_ELAPSED] < $b[DATA_ELAPSED]) ? -1 :
      ($a[DATA_ELAPSED] > $b[DATA_ELAPSED] ? 1 : 0);
}

// should these be on the tpl.php?

function PTime($d){
   if ($d <= 0.0){ return ''; }
   if ($d<300.0){ return number_format($d,2); }
   elseif ($d<3600.0){
     $m = floor($d/60); $s = $d-($m*60); $ss = number_format($s,0);
     if (strlen($ss)<2) { $ss = "0".$ss; }
     return number_format($m,0)."&nbsp;min"; }
   else {
     $h = floor($d/3600); $m = floor(($d-($h*3600))/60);
     $mm = number_format($m,0); if (strlen($mm)<2) { $mm = "0".$mm; }
     return number_format($h,0)."h&nbsp;".$mm."&nbsp;min";
   }
}

function PFx($d){
   if ($d>9.9){ return number_format($d); }
   elseif ($d>0.0){ return number_format($d,1); }
   else { return "&nbsp;"; }
}

// PAGE ////////////////////////////////////////////////

$Page = & new Template(LIB_PATH);
$Body = & new Template(LIB_PATH);
$PageId = 'benchmark';
$TemplateName = 'performance.tpl.php';


// GET_VARS ////////////////////////////////////////////////

list($Incl,$Excl) = WhiteListInEx();
$Tests = WhiteListUnique('test.csv',$Incl); // assume test.csv in name order
$Langs = WhiteListUnique('lang.csv',$Incl); // assume lang.csv in name order

if (isset($HTTP_GET_VARS['test'])
      && strlen($HTTP_GET_VARS['test']) && (strlen($HTTP_GET_VARS['test']) <= NAME_LEN)){
   $X = $HTTP_GET_VARS['test'];
   if (ereg("^[a-z]+$",$X) && (isset($Tests[$X]) || $X == 'all' || $X == 'fun')){ $T = $X; }
}
if (!isset($T)){ $T = 'nbody'; }


if (isset($HTTP_GET_VARS['sort'])
      && strlen($HTTP_GET_VARS['sort']) && (strlen($HTTP_GET_VARS['sort']) <= 7)){
   $X = $HTTP_GET_VARS['sort'];
   if (ereg("^[a-z]+$",$X) && ($X == 'fullcpu' || $X == 'kb' || $X == 'gz' || $X == 'elapsed')){ 
      $S = $X; 
   }
}
if (!isset($S)){
   if (SITE_NAME == 'gp4' || SITE_NAME == 'debian'){
      $S = 'fullcpu';
   } else {
      $S = 'elapsed'; 
   }
}


// HEADER ////////////////////////////////////////////////

$mark = MarkTime();
$mark = $mark.' '.SITE_NAME;

$TestName = $Tests[$T][TEST_NAME];
$Title = $TestName.' benchmark';

$bannerUrl = CORE_SITE;
$faqUrl = CORE_SITE.'help.php';


// DATA ////////////////////////////////////////////////

$Data = BenchmarkData(DATA_PATH.'data.csv',$T,$Langs, $Incl,$Excl,$S);

$timeUsed = 'Elapsed secs';
if (SITE_NAME == 'gp4' || SITE_NAME == 'debian'){
   $timeUsed = 'CPU secs';
}


// ABOUT ////////////////////////////////////////////////

$About = & new Template(ABOUT_PATH);
$AboutTemplateName = $T.SEPARATOR.'about.tpl.php';
if (! file_exists(ABOUT_PATH.$AboutTemplateName)){ $AboutTemplateName = 'blank-about.tpl.php'; }


// META ////////////////////////////////////////////////

$metaRobots = '<meta name="robots" content="index,nofollow,noarchive" />';
$MetaKeywords = '<meta name="description" content="For ~30 programming languages compare programs that '.$Tests[$T][TEST_META].' ('.PLATFORM_NAME.')." />';

if (SITE_NAME == 'gp4' || SITE_NAME == 'debian'){
   $metaRobots = '<meta name="robots" content="noindex,nofollow,noarchive" />';
}


// TEMPLATE VARS ////////////////////////////////////////////////

$Page->set('PageTitle', $Title.BAR.'Computer&nbsp;Language&nbsp;Benchmarks&nbsp;Game');
$Page->set('BannerTitle', BANNER_TITLE);
$Page->set('BannerUrl', $bannerUrl);
$Page->set('FaqTitle', FAQ_TITLE);
$Page->set('FaqUrl', $faqUrl);

$Body->set('Tests', $Tests);
$Body->set('SelectedTest', $T);
$Body->set('Langs', $Langs);
$Body->set('Excl', $Excl);
$Body->set('Mark', $mark);
$Body->set('TimeUsed', $timeUsed);
$Body->set('Sort', $S);
$Body->set('Data', $Data );
$Body->set('Title', $Title);

$About->set('SelectedTest', $T);
$Body->set('About', $About->fetch($AboutTemplateName));

$Page->set('PageBody', $Body->fetch($TemplateName));
$Page->set('Robots', $metaRobots);
$Page->set('MetaKeywords', $MetaKeywords);
$Page->set('PageId', $PageId);

echo $Page->fetch('page.tpl.php');
?>