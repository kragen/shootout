<?php
// Copyright (c) Isaac Gouy 2010

// LIBRARIES ////////////////////////////////////////////////

require_once(LIB_PATH.'lib_whitelist.php');
require_once(LIB);
require_once(LIB_PATH.'lib_data.php');

// DATA LAYOUT ///////////////////////////////////////////////////

define('N_TEST',0);
define('N_LANG',1);
define('N_ID',2);
define('N_NAME',3);
define('N_FULL',4);
define('N_HTML',5);
define('N_FULLCPU',6);
define('N_MEMORY',7);
define('N_CPU_MAX',8);
define('N_MEMORY_MAX',9);
define('N_COLOR',10);

define('N_N',3);
define('N_LINES',8);
define('N_GZ',9);
define('N_EXCLUDE',10);

define('EXCLUDED','X');
define('PROGRAM_TIMEOUT',-1);
define('PROGRAM_ERROR',-2);
define('PROGRAM_SPECIAL','-3');
define('PROGRAM_EXCLUDED',-4);
define('LANGUAGE_EXCLUDED',-5);
define('NO_COMPARISON',-6);
define('NO_PROGRAM_OUTPUT',-7);


// FUNCTIONS ///////////////////////////////////////////

function HeadToHeadData($FileName,$Tests,$Langs,$Incl,$Excl,$L1,$L2,$HasHeading=TRUE){
   $rows = array();
   $lines = file($FileName);

   $prefixL1 = ','.$L1.',';
   $prefixL2 = ','.$L2.',';
   foreach($lines as $line) {
      if (strpos($line,$prefixL1)||strpos($line,$prefixL2)){
         $rows[] = explode( ',', $line);
      }
   }
   unset($lines);

   // Filter again in memory
   $Data = array();
   foreach($rows as $row){
      if (isset($Incl[$row[DATA_TEST]])){
         settype($row[DATA_ID],'integer');
         settype($row[DATA_TESTVALUE],'integer');
         settype($row[DATA_GZ],'integer');
         settype($row[DATA_FULLCPU],'double');
         settype($row[DATA_MEMORY],'integer');
         settype($row[DATA_STATUS],'integer');
         settype($row[DATA_ELAPSED],'double');

         $ex = ExcludeData($row,$Langs,$Excl);
         if ($ex != PROGRAM_SPECIAL && $ex != PROGRAM_EXCLUDED && $ex != LANGUAGE_EXCLUDED){
            $Data[] = $row;
         }
      }
   }
   unset($rows);

// SELECTION DEPENDS ON THIS SORT ORDER
   usort($Data,'CompareTestValue2');

// TRANSFORM SELECTED DATA
   $lang = ""; $id = ""; $test = ""; $n = 0;
   $NData = array();
   $comparable = array();
   $errorRowL1 = NULL;
   $measurements = array();


   $i=0; $j=0;
   while ($i<sizeof($Data)){

      $n = $Data[$i][DATA_TESTVALUE];
      $test = $Data[$i][DATA_TEST];                

      do {
         $dj = $Data[$j];
                              
         if ($dj[DATA_STATUS] > PROGRAM_TIMEOUT){
            if (isset($comparable[$dj[DATA_LANG]])){
               if ($dj[DATA_TIME] < $comparable[$dj[DATA_LANG]][DATA_TIME]){
                  if ($isComparable){
                     if ($dj[DATA_TESTVALUE]==$comparable[$dj[DATA_LANG]][DATA_TESTVALUE]){
                        $comparable[$dj[DATA_LANG]] = $Data[$j];
                     }
                  }
                  else {
                     $comparable[$dj[DATA_LANG]] = $Data[$j];                   
                  }                                        
                                
               }
            } else {
               $comparable[$dj[DATA_LANG]] = $Data[$j];
               if ($dj[DATA_LANG] = $L1){ $errorRowMeasurement = $Data[$j]; }
            }
         }
         elseif ($dj[DATA_LANG]==$L1){
            $errorRowL1 = $Data[$j];
         }
                    
         $isComparable = isset($comparable[$L1]) && isset($comparable[$L2])
            && ($comparable[$L1][DATA_TESTVALUE]==$comparable[$L2][DATA_TESTVALUE]);

         $j++;
         $hasMore = $j<sizeof($Data);
         $isSameTest = $hasMore && ($test==$Data[$j][DATA_TEST]);
         
      } while ($isSameTest);


      if (isset($comparable[$L1])){
         $r1 = $comparable[$L1];

         if (isset($comparable[$L2])){
            $r2 = $comparable[$L2];
            $full = 1;
            $mem = 1;
            $lines = 1;
            $cpu = 1; 
            $gz = 1;
            
            $measurements[$r1[DATA_TEST]] = array($r1,$r2);

            if ($r2[DATA_TIME]>0){ $full = $r1[DATA_TIME] / $r2[DATA_TIME]; }
            if ($r2[DATA_MEMORY]>0){ $mem = $r1[DATA_MEMORY] / $r2[DATA_MEMORY]; }
            if ($r2[DATA_GZ]>0){ $gz = $r1[DATA_GZ] / $r2[DATA_GZ]; }
                                 
            $NData[$r1[DATA_TEST]] = array(
                 $r1[DATA_TEST]
               , $r1[DATA_LANG]
               , $r1[DATA_ID]
               , ($r1[DATA_TESTVALUE] == $n) ? 0 : $r1[DATA_TESTVALUE]
               , $Langs[$r1[DATA_LANG]][LANG_FULL].IdName($r1[DATA_ID])
               , $Langs[$r1[DATA_LANG]][LANG_HTML].IdName($r1[DATA_ID])
               , $full
               , $mem
               , $lines
               , $gz
               , 0
               );
                                                    
            while ($j<sizeof($Data) && $test==$Data[$j][DATA_TEST]){ $j++; }
         }
         else {
            
            $measurements[$r1[DATA_TEST]] = array($errorRowMeasurement);

            $NData[$r1[DATA_TEST]] = array(
                 $r1[DATA_TEST]
               , $L2
               , $r1[DATA_ID]
               , ($errorRowMeasurement[DATA_TESTVALUE] == $n) ? 0 : $errorRowMeasurement[DATA_TESTVALUE]
               , $Langs[$r1[DATA_LANG]][LANG_FULL].IdName($r1[DATA_ID])
               , $Langs[$r1[DATA_LANG]][LANG_HTML].IdName($r1[DATA_ID])
               , 0
               , 0
               , NO_COMPARISON
               , 0
               , 0
               );
         
            while ($j<sizeof($Data) && $test==$Data[$j][DATA_TEST]){ $j++; }
         }                                             
      }
      elseif (!$isSameTest && isset($errorRowL1)){
         $e = $errorRowL1;    
         $exclude = ExcludeData($e,$Langs,$Excl);

         $NData[$e[DATA_TEST]] = array(
              $e[DATA_TEST]
            , $e[DATA_LANG]
            , $e[DATA_ID]
            , $e[DATA_TESTVALUE]
            , $Langs[$e[DATA_LANG]][LANG_FULL].IdName($e[DATA_ID])
            , $Langs[$e[DATA_LANG]][LANG_HTML].IdName($e[DATA_ID])
            , 0
            , 0
            , $exclude
            , 0
            , 0
            );

      }

      unset($comparable[$L1]);
      unset($comparable[$L2]);
      unset($errorRowL1);
      $i = $j;
   }
   uasort($NData,'CompareTimeRatio');

   // sort by x times faster
   $SortedTests = array();
   $reorder = array();
   foreach($NData as $k => $v){ $SortedTests[$k] = $Tests[$k]; }
   foreach($Tests as $k => $v){ 
      if (!isset($SortedTests[$k])){ $SortedTests[$k] = $Tests[$k]; }
   }

   // extract minimum values for chart
   $ratios = array();
   foreach($Tests as $Row){
      if (($Row[TEST_WEIGHT]<=0)){ continue; }
      if (isset($NData[$Row[TEST_LINK]])){
         $v = $NData[$Row[TEST_LINK]];
         $ratios[] = $v[N_FULLCPU];
         $ratios[] = $v[N_MEMORY];
         $ratios[] = $v[N_GZ];
      } else {
         $ratios[] = NO_VALUE; $ratios[] = NO_VALUE; $ratios[] = NO_VALUE;
      }
   }
   return array($NData,$SortedTests,$ratios,$measurements);
}


function CompareTimeRatio($a, $b){
   if ($a[N_LINES] < 1 && $b[N_LINES] < 1){
      return ($a[TEST_LINK] < $b[TEST_LINK]) ? -1 : 1;
   } 
   elseif ($a[N_LINES] > 0 && $b[N_LINES] > 0){
      if ($a[N_FULLCPU] == $b[N_FULLCPU]){ return 0; }
      else { return ($a[N_FULLCPU] < $b[N_FULLCPU]) ? -1 : 1; }
   }
   else {
      return ($a[N_LINES] < $b[N_LINES]) ? 1 : -1;
   }
}


function CompareTestValue2($a, $b){
   if ($a[DATA_TEST] == $b[DATA_TEST]){
         if ($a[DATA_TESTVALUE] == $b[DATA_TESTVALUE]) return 0;
         return ($a[DATA_TESTVALUE] > $b[DATA_TESTVALUE]) ? -1 : 1;
   }
   else {
      return ($a[DATA_TEST] < $b[DATA_TEST]) ? -1 : 1;      
   }
}

function ExcludeData($d,$langs,$Excl){
   if( !isset($langs[$d[DATA_LANG]]) ) { return LANGUAGE_EXCLUDED; }

   $key = $d[DATA_TEST].$d[DATA_LANG].strval($d[DATA_ID]);
   if (isset($Excl[$key])){
      if ($Excl[$key]){ return PROGRAM_EXCLUDED; }
      else { return PROGRAM_SPECIAL; }
   }
   return $d[DATA_STATUS];
}


// should these be on the tpl.php?


function MkHeadToHeadMenuForm($Tests,$SelectedTest,$Langs,$SelectedLang,$SelectedLang2){
   echo '<form method="get" action="benchmark.php">', "\n";
   echo '<p><select name="test">', "\n";
   echo '<option value="all">- all ', TESTS_PHRASE, 's -</option>', "\n";

   foreach($Tests as $Row){
      $Link = $Row[TEST_LINK];
      $Name = $Row[TEST_NAME];
      if ($Link==$SelectedTest){
         $Selected = 'selected="selected"';
      } else {
         $Selected = '';
      }
      printf('<option %s value="%s">%s</option>', $Selected,$Link,$Name); echo "\n";
   }
   echo '</select>', "\n";


   echo '<select name="lang">', "\n";
   echo '<option value="all">- all ', LANGS_PHRASE, 's -</option>', "\n";
   foreach($Langs as $Row){
      $Link = $Row[LANG_LINK];
      $Name = $Row[LANG_FULL];
      if ($Link==$SelectedLang){
         $Selected = 'selected="selected"';
      } else {
         $Selected = '';
      }
      printf('<option %s value="%s">%s</option>', $Selected,$Link,$Name); echo "\n";
   }
   echo '</select></p>', "\n";
   
   
   echo '<p><strong>&#247;</strong> <select name="lang2">', "\n";
   foreach($Langs as $Row){
      $Link = $Row[LANG_LINK];
      $Name = $Row[LANG_FULL];
      if ($Link==$SelectedLang2){
         $Selected = 'selected="selected"';
      } else {
         $Selected = '';
      }
      printf('<option %s value="%s">%s</option>', $Selected,$Link,$Name); echo "\n";
   }
   echo '</select>', "\n";   

   echo '<input type="submit" value="Show" />', "\n";
   echo '</p></form>', "\n";
}

function MkLangsMenuForm($Langs,$SelectedLang,$Action='measurements.php'){
   echo '<form method="get" action="'.$Action.'">', "\n";
   echo '<p><select name="lang">', "\n";
   foreach($Langs as $Row){
      $Link = $Row[LANG_LINK];
      $Name = $Row[LANG_FULL];
      if ($Link==$SelectedLang){
         $Selected = 'selected="selected"';
      } else {
         $Selected = '';
      }
      printf('<option %s value="%s">%s</option>', $Selected,$Link,$Name); echo "\n";
   }
   echo '</select>', "\n";
   echo '<input type="submit" value="Show" />', "\n";
   echo '</p></form>', "\n";
}

function MkTestsMenuForm($Tests,$SelectedTest){
   echo '<form method="get" action="performance.php">', "\n";
   echo '<p><select name="test">', "\n";
   foreach($Tests as $Row){
      $Link = $Row[TEST_LINK];
      $Name = $Row[TEST_NAME];
      if ($Link==$SelectedTest){
         $Selected = 'selected="selected"';
      } else {
         $Selected = '';
      }
      printf('<option %s value="%s">%s</option>', $Selected,$Link,$Name); echo "\n";
   }
   echo '</select>', "\n";
   echo '<input type="submit" value="Show" />', "\n";
   echo '</p></form>', "\n";
}

function PF($d){
   $rounded = round($d);
   if ($rounded>15){ return '<td class="num1">'.number_format($rounded).'&#215;</td>'; }
   elseif ($rounded>1){ return '<td class="num2">'.number_format($rounded).'&#215;</td>'; }
   elseif ($d>1.01){ return '<td class="num2">&#177;</td>'; }
   else {
      if ($d>0){
         $i = 1.0 / $d;
         $rounded = round($i);
         if ($rounded>15){ return '<td class="num5"><sup>1</sup>/<sub>'.number_format($rounded).'</sub></td>'; }
         elseif ($rounded>1){ return '<td><sup>1</sup>/<sub>'.number_format($rounded).'</sub></td>'; }
         else { return '<td class="num2">&#177;</td>'; }
      } else { 
         return '<td>&nbsp;</td>';
      }
   }
}

// PAGE ////////////////////////////////////////////////

$Page = & new Template(LIB_PATH);
$Body = & new Template(LIB_PATH);
$PageId = 'headtohead';
$TemplateName = 'compare.tpl.php';


// GET_VARS ////////////////////////////////////////////////

list($Incl,$Excl) = WhiteListInEx();
$Tests = WhiteListUnique('test.csv',$Incl); // assume test.csv in name order
$Langs = WhiteListUnique('lang.csv',$Incl); // assume lang.csv in name order

if (isset($HTTP_GET_VARS['lang'])
      && strlen($HTTP_GET_VARS['lang']) && (strlen($HTTP_GET_VARS['lang']) <= NAME_LEN)){
   $X = $HTTP_GET_VARS['lang'];
   if (ereg("^[a-z0-9]+$",$X) && (isset($Langs[$X]) || $X == 'all' || $X == 'fun')){ $L = $X; }
}
if (!isset($L)){ $L = 'all'; }


if ($L2 == 'lang'){ $L2 = $L; }
else {
   if (isset($HTTP_GET_VARS['lang2'])
         && strlen($HTTP_GET_VARS['lang2']) && (strlen($HTTP_GET_VARS['lang2']) <= NAME_LEN)){
      $X = $HTTP_GET_VARS['lang2'];
      if (ereg("^[a-z0-9]+$",$X) && (isset($Langs[$X]))){ $L2 = $X; }
   }
}
if (!isset($L2)){
   if ($L!='all'){ $L2 = $Langs[$L][LANG_COMPARE]; }
}


// HEADER ////////////////////////////////////////////////

$mark = MarkTime();
$mark = $mark.' '.SITE_NAME;

$LangName = $Langs[$L][LANG_FULL];
$LangName2 = $Langs[$L2][LANG_FULL];
$Title = 'speed and size '.$LangName.'&nbsp;&#247;&nbsp;'.$LangName2;

$bannerUrl = CORE_SITE;
$faqUrl = CORE_SITE.'help.php';


// DATA ////////////////////////////////////////////////

$Data = HeadToHeadData(DATA_PATH.'ndata.csv',$Tests,$Langs,$Incl,$Excl,$L,$L2);

$timeUsed = 'Elapsed secs';
if (SITE_NAME == 'gp4' || SITE_NAME == 'debian'){
   $timeUsed = 'CPU secs';
}


// ABOUT ////////////////////////////////////////////////

$About = & new Template(ABOUT_PATH);
$AboutTemplateName = $L.SEPARATOR.'about.tpl.php';
if (! file_exists(ABOUT_PATH.$AboutTemplateName)){ $AboutTemplateName = 'blank-about.tpl.php'; }
$About->set('Version', HtmlFragment(VERSION_PATH.$L.SEPARATOR.'version.php'));


// META ////////////////////////////////////////////////

$MetaKeywords = '<meta name="description" content="Compare the speed and size of '.$LangName.' programs against '.$LangName2.' programs ('.PLATFORM_NAME.')." />';
         
$metaRobots = '<meta name="robots" content="index,follow,noarchive" />';
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
$Body->set('Langs', $Langs);
$Body->set('SelectedLang', $L);
$Body->set('SelectedLang2', $L2);
$Body->set('Excl', $Excl);
$Body->set('Mark', $mark);
$Body->set('TimeUsed', $timeUsed);
$Body->set('Data', $Data );

$About->set('SelectedLang', $L);

$Body->set('About', $About->fetch($AboutTemplateName));
$Page->set('PageBody', $Body->fetch($TemplateName));
$Page->set('Robots', $metaRobots);
$Page->set('MetaKeywords', $MetaKeywords);
$Page->set('PageId', $PageId);

echo $Page->fetch('page.tpl.php');
?>