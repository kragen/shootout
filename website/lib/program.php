<?php
// Copyright (c) Isaac Gouy 2010

// LIBRARIES ////////////////////////////////////////////////

require_once(LIB_PATH.'lib_whitelist.php');
require_once(LIB);
require_once(LIB_PATH.'lib_data.php');


// FUNCTIONS ///////////////////////////////////////////

// Some code duplication


function BestRows($rows){
   $testvalue = -2; // assume not test value is < 0
   $time = 360000.0; // assume no program was allowed to run for 100 hours
   $id = -2; // assume no id is < 0

   // Identify id of fastest row at largest n, or whatever rows there are
   foreach($rows as $row) {
      $row_testvalue = $row[DATA_TESTVALUE];
      if ($row[DATA_STATUS] > PROGRAM_TIMEOUT){
         if ($row_testvalue > $testvalue){
            $testvalue = $row_testvalue;
            $time = $row[DATA_TIME];
            $id = $row[DATA_ID];
         } elseif ($row_testvalue == $testvalue){
            $row_time = $row[DATA_TIME];
            if ($row_time < $time){
               $time = $row_time;
               $id = $row[DATA_ID];
            }
         }
      } else {
         $failed_id = $row[DATA_ID];
      }
   }
   if ($id < 0){ $id = $failed_id; } // assume no id is < 0

   // filter and return the best of the rows
   $best = array();
   foreach($rows as $row) {
      if ($row[DATA_ID] == $id){
         $best[] = $row;
      }
   }
   return $best;
}


function ProgramData($FileName,$T,$L,$I,$Langs,$Incl,$Excl){
   $rows = array();
   
   if (isset($Incl[$T]) && isset($Incl[$L])){
      $prefix = substr($T,1).','.$L.',';
      $lines = file($FileName);

      foreach($lines as $line) {
         if (strpos($line,$prefix)){
            $row = explode( ',', $line);
            $key = $T.$L.$row[DATA_ID];
            settype($row[DATA_ID],'integer');

            if ($row[DATA_ID]==$I || ($I == -1 && !isset($Excl[$key]))){
               settype($row[DATA_TESTVALUE],'integer');
               settype($row[DATA_GZ],'integer');
               settype($row[DATA_FULLCPU],'double');
               settype($row[DATA_MEMORY],'integer');
               settype($row[DATA_STATUS],'integer');
               settype($row[DATA_ELAPSED],'double');
               $rows[] = $row;
            }
         }
      }
      if ($I == -1){
         $rows = BestRows($rows);
      }
   }
   return $rows;
}


// PAGE ////////////////////////////////////////////////

$Page = & new Template(LIB_PATH);
$Body = & new Template(LIB_PATH);
$PageId = 'program';
$TemplateName = 'program.tpl.php';


// GET_VARS ////////////////////////////////////////////////

list($Incl,$Excl) = WhiteListInEx();
$Tests = WhiteListUnique('test.csv',$Incl); // assume test.csv in name order
$Langs = WhiteListUnique('lang.csv',$Incl); // assume lang.csv in name order

if (isset($HTTP_GET_VARS['test'])
      && strlen($HTTP_GET_VARS['test']) && (strlen($HTTP_GET_VARS['test']) <= NAME_LEN)){
   $X = $HTTP_GET_VARS['test'];
   if (ereg("^[a-z]+$",$X) && isset($Tests[$X])){ $T = $X; }
}
if (!isset($T)){ $T = 'nbody'; }


if (isset($HTTP_GET_VARS['lang'])
      && strlen($HTTP_GET_VARS['lang']) && (strlen($HTTP_GET_VARS['lang']) <= NAME_LEN)){
   $X = $HTTP_GET_VARS['lang'];
   if (ereg("^[a-z0-9]+$",$X) && isset($Langs[$X])){ $L = $X; }
}
if (!isset($L)){ $L = 'java'; }


if (isset($HTTP_GET_VARS['id']) && strlen($HTTP_GET_VARS['id']) == 1){
   $X = $HTTP_GET_VARS['id'];
   if (ereg("^[0-9]$",$X)){ $I = $X; }
}
if (!isset($I)){ $I = -1; }


// DATA ////////////////////////////////////////////////

$Data = ProgramData(DATA_PATH.'ndata.csv',$T,$L,$I,$Langs,$Incl,$Excl);
if (sizeof($Data)>0){ $I = $Data[0][DATA_ID]; }
$Id = '';
if ($I > 1){ $Id = SEPARATOR.$I;}

$timeUsed = 'Elapsed secs';
if (SITE_NAME == 'gp4' || SITE_NAME == 'debian'){
   $timeUsed = 'CPU secs';
}


// HEADER ////////////////////////////////////////////////

$mark = MarkTime();
$mark = $mark.' '.SITE_NAME;

$TestName = $Tests[$T][TEST_NAME];
$LangName = $Langs[$L][LANG_FULL];
$Title = $TestName.' '.$LangName.IdName($I).' program';

$bannerUrl = CORE_SITE;
$faqUrl = CORE_SITE.'help.php';


// ABOUT ////////////////////////////////////////////////

$About = & new Template(ABOUT_PROGRAMS_PATH);
$AboutTemplateName = $T.SEPARATOR.$L.$Id.SEPARATOR.'about.tpl.php';
if (! file_exists(ABOUT_PROGRAMS_PATH.$AboutTemplateName)){ $AboutTemplateName = 'blank-about.tpl.php'; }


// META ////////////////////////////////////////////////

$MetaKeywords = '';
$metaRobots = '<meta name="robots" content="noindex,nofollow,noarchive" />';


// TEMPLATE VARS ////////////////////////////////////////////////

$Page->set('PageTitle', $Title.BAR.'Computer&nbsp;Language&nbsp;Benchmarks&nbsp;Game');
$Page->set('BannerTitle', BANNER_TITLE);
$Page->set('BannerUrl', $bannerUrl);
$Page->set('FaqTitle', FAQ_TITLE);
$Page->set('FaqUrl', $faqUrl);

$Body->set('Tests', $Tests);
$Body->set('SelectedTest', $T);
$Body->set('Langs', $Langs);
$Body->set('SelectedLang', $L);
$Body->set('Excl', $Excl);
$Body->set('Mark', $mark);
$Body->set('TimeUsed', $timeUsed);

$Body->set('Data', $Data );
$Body->set('Code', HtmlFragment( CODE_PATH.$T.'.'.$I.'.'.$L.'.code' ));
$Body->set('Log', HtmlFragment( LOG_PATH.$T.'.'.$I.'.'.$L.'.log' ));
$Body->set('Id', $I);
$Body->set('Title', $Title);

$About->set('SelectedTest', $T);
$About->set('SelectedLang', $L);
$Body->set('About', $About->fetch($AboutTemplateName));

$Page->set('PageBody', $Body->fetch($TemplateName));
$Page->set('Robots', $metaRobots);
$Page->set('MetaKeywords', $MetaKeywords);
$Page->set('PageId', $PageId);

echo $Page->fetch('page.tpl.php');
?>