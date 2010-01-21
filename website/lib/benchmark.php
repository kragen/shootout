<?php
// Copyright (c) Isaac Gouy 2004-2010
// LIBRARIES ////////////////////////////////////////////////
require_once(LIB_PATH.'lib_whitelist.php');
require_once(LIB_PATH.'lib_common.php');
require_once(LIB);

// DATA ///////////////////////////////////////////

list($Incl,$Excl) = WhiteListInEx();
$Tests = WhiteListUnique('test.csv',$Incl); // assume test.csv in name order
$Langs = WhiteListUnique('lang.csv',$Incl); // assume lang.csv in name order

$mark = MarkTime();
$mark = $mark.' '.SITE_NAME;


if (isset($HTTP_GET_VARS['test'])
      && strlen($HTTP_GET_VARS['test']) && (strlen($HTTP_GET_VARS['test']) <= NAME_LEN)){
   $X = $HTTP_GET_VARS['test'];
   if (ereg("^[a-z]+$",$X) && (isset($Tests[$X]) || $X == 'all' || $X == 'fun')){ $T = $X; }
}
if (!isset($T)){ $T = 'nbody'; }


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
   if ($L=='all'){ $L2 = $L; }
   else { $L2 = $Langs[$L][LANG_COMPARE]; }
}


if (isset($HTTP_GET_VARS['id']) && strlen($HTTP_GET_VARS['id']) == 1){
   $X = $HTTP_GET_VARS['id'];
   if (ereg("^[0-9]$",$X)){ $I = $X; }
}
if (!isset($I)){ $I = -1; }


if (isset($HTTP_GET_VARS['calc'])
      && strlen($HTTP_GET_VARS['calc']) && (strlen($HTTP_GET_VARS['calc']) <= 9)){
   $X = $HTTP_GET_VARS['calc'];
   if (ereg("^[a-z]+$",$X) && ($X == 'reset')){ $Action = $X; }
}
if (!isset($Action)){ $Action = 'calculate'; }



$MetaKeywords = '';

// PAGES ///////////////////////////////////////////////////
// There are 6 kinds of test/lang combination
// - all tests all languages - Scorecard
// - all tests all languages box 1 - Boxplot Summary
// - all tests two languages  - Head to Head
// - one test all languages  - Benchmark
// - all tests one language  - Language data
// - one test one language   - Program

$Page = & new Template(LIB_PATH);
$Body = & new Template(LIB_PATH);

if ($T=='all'){
   if ($L=='all'){

         $S = '';
         $PageId = 'boxplot';

         require_once(LIB_PATH.'lib_boxplot.php');

         $Title = 'Which programming languages are fastest?';
         $Body->set('Title', $Title);
         $TemplateName = 'boxplot.tpl.php';
         $About = & new Template(ABOUT_PATH);
         $AboutTemplateName = 'boxplot-about.tpl.php';
         $SLangs = SelectedLangs($Langs, $Action, $HTTP_GET_VARS);
         if (! file_exists(ABOUT_PATH.$AboutTemplateName)){ $AboutTemplateName = 'blank-about.tpl.php'; }
         $Body->set('DataSet', 'data');
         $Body->set('Data', FullUnweightedData(DATA_PATH.'data.csv', $Tests, $Langs, $Incl, $Excl, $SLangs));
         $metaRobots = '<meta name="robots" content="noindex,follow,noarchive" /><meta name="revisit" content="4 days" />';
         $MetaKeywords = '<meta name="description" content="Which programming languages have the fastest benchmark programs ('.PLATFORM_NAME.') and how your favorite language compares." />';

   } else {           // Head to Head
   

      $S = '';
      $PageId = 'headtohead';
      require_once(LIB_PATH.'lib_headtohead.php');
      $LangName = $Langs[$L][LANG_FULL];

      if ($L!=$L2){
         $LangName2 = $Langs[$L2][LANG_FULL];
         $Title = 'speed and size '.$LangName.'&nbsp;&#247;&nbsp;'.$LangName2;
         $TemplateName = 'headtohead.tpl.php';
         $Body->set('Data', HeadToHeadData(DATA_PATH.'ndata.csv',$Tests,$Langs,$Incl,$Excl,$L,$L2));

         $metaRobots = '<meta name="robots" content="index,follow,noarchive" /><meta name="revisit" content="4 days" />';
         $Family = $Langs[$L][LANG_FAMILY];
         $MetaKeywords = '<meta name="description" content="Compare the speed and size of '.$LangName.' programs against '.$LangName2.' programs ('.PLATFORM_NAME.')." />';

      } else {
         

        $Title = $LangName.' measurements';
        $TemplateName = 'language.tpl.php';
        $Body->set('Data', LanguageData(DATA_PATH.'ndata.csv',$Langs,$Incl,$Excl,$L));

        $metaRobots = '<meta name="robots" content="index,follow,noarchive" />';
        $MetaKeywords = '<meta name="description" content="Performance measurements for all the '.$LangName.' programs implementing ~12 flawed benchmarks ('.PLATFORM_NAME.')." />';
      }

      $About = & new Template(ABOUT_PATH);
      $AboutTemplateName = $L.SEPARATOR.'about.tpl.php';
      if (! file_exists(ABOUT_PATH.$AboutTemplateName)){ $AboutTemplateName = 'blank-about.tpl.php'; }
      $About->set('Version', HtmlFragment(VERSION_PATH.$L.SEPARATOR.'version.php'));
      }



   } elseif ($L=='all'){ // Benchmark
      $PageId = 'benchmark';
      require_once(LIB_PATH.'lib_benchmark.php');

      if (isset($HTTP_GET_VARS['sort'])
            && strlen($HTTP_GET_VARS['sort']) && (strlen($HTTP_GET_VARS['sort']) <= 7)){
         $X = $HTTP_GET_VARS['sort'];
         if (ereg("^[a-z]+$",$X) && ($X == 'fullcpu' || $X == 'kb' || $X == 'gz' || $X == 'elapsed')){ $S = $X; }
      }
      if (!isset($S)){
         if (SITE_NAME == 'gp4' || SITE_NAME == 'debian'){
            $S = 'fullcpu';
         } else {
            $S = 'elapsed'; 
         }
      }

      $TestName = $Tests[$T][TEST_NAME];
      $Title = $TestName.' benchmark';
      $TemplateName = 'benchmark.tpl.php';
      $About = & new Template(ABOUT_PATH);
      $AboutTemplateName = $T.SEPARATOR.'about.tpl.php';
      if (! file_exists(ABOUT_PATH.$AboutTemplateName)){ $AboutTemplateName = 'blank-about.tpl.php'; }
      $Body->set('Data', BenchmarkData(DATA_PATH.'data.csv',$T,$Langs, $Incl,$Excl,$S) );
      $metaRobots = '<meta name="robots" content="index,nofollow,noarchive" />';
      $MetaKeywords = '<meta name="description" content="For ~30 programming languages compare programs that '.$Tests[$T][TEST_META].' ('.PLATFORM_NAME.')." />';



   } else {              // Program
   
      $S = '';
      $PageId = 'program';
      $D = ProgramData(DATA_PATH.'ndata.csv',$T,$L,$I,$Langs,$Incl,$Excl);
      if (sizeof($D)>0){ $I = $D[0][DATA_ID]; }
      
      $TestName = $Tests[$T][TEST_NAME];
      $LangName = $Langs[$L][LANG_FULL];
      $TemplateName = 'program.tpl.php';
      $Title = $TestName.' '.$LangName.IdName($I).' program';

      $Id = '';
      if ($I > 1){ $Id = SEPARATOR.$I; }
      
      $About = & new Template(ABOUT_PROGRAMS_PATH);
      $AboutTemplateName = $T.SEPARATOR.$L.$Id.SEPARATOR.'about.tpl.php';
      if (! file_exists(ABOUT_PROGRAMS_PATH.$AboutTemplateName)){ $AboutTemplateName = 'blank-about.tpl.php'; }

      $Body->set('Data', $D );
      $Body->set('Code', HtmlFragment( CODE_PATH.$T.'.'.$I.'.'.$L.'.code' ));
      $Body->set('Log', HtmlFragment( LOG_PATH.$T.'.'.$I.'.'.$L.'.log' ));

      $Body->set('Id', $I);
      $Body->set('Title', $Title);
      $metaRobots = '<meta name="robots" content="noindex,nofollow,noarchive" />';
}

$faqUrl = CORE_SITE.'help.php';
$timeUsed = 'Elapsed secs';
$bannerUrl = CORE_SITE;

if (!(SITE_NAME == 'u32' || SITE_NAME == 'u32q' || SITE_NAME == 'u64' || SITE_NAME == 'u64q')){
   $metaRobots = '<meta name="robots" content="noindex,nofollow,noarchive" />';
   $timeUsed = 'CPU secs';
}


// TEMPLATE VARS ////////////////////////////////////////////////

$Page->set('PageTitle', $Title.BAR.'Computer&nbsp;Language&nbsp;Benchmarks&nbsp;Game');
$Page->set('BannerTitle', BANNER_TITLE);
$Page->set('BannerUrl', $bannerUrl);
$Page->set('FaqTitle', FAQ_TITLE);
$Page->set('FaqUrl', $faqUrl);
$Page->set('Sort', $S);

$Body->set('Tests', $Tests);
$Body->set('SelectedTest', $T);
$Body->set('Langs', $Langs);
$Body->set('SelectedLang', $L);
$Body->set('SelectedLang2', $L2);
$Body->set('Sort', $S);
$Body->set('Excl', $Excl);
$Body->set('Mark', $mark);
$Body->set('TimeUsed', $timeUsed);

$About->set('SelectedTest', $T);
$About->set('SelectedLang', $L);
$About->set('Sort', $S);

$Body->set('About', $About->fetch($AboutTemplateName));

$Page->set('PageBody', $Body->fetch($TemplateName));
$Page->set('Robots', $metaRobots);
$Page->set('MetaKeywords', $MetaKeywords);
$Page->set('PageId', $PageId);

echo $Page->fetch('page.tpl.php');
?>



