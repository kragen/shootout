<?php
// Copyright (c) Isaac Gouy 2009-2010

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

// Some code duplication

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


if (isset($HTTP_GET_VARS['calc'])
      && strlen($HTTP_GET_VARS['calc']) && (strlen($HTTP_GET_VARS['calc']) <= 9)){
   $X = $HTTP_GET_VARS['calc'];
   if (ereg("^[a-z]+$",$X) && ($X == 'reset')){ $Action = $X; }
}
if (!isset($Action)){ $Action = 'calculate'; }


$Page = & new Template(LIB_PATH);
$Body = & new Template(LIB_PATH);

$S = '';
$PageId = 'boxplot';

require_once(LIB_PATH.'lib_boxplot.php');

$mark= MarkTime('u64q/');
$mark = $mark.' Q6600';

$Title = 'Which programming language is fastest?';
$Body->set('Title', $Title);
$TemplateName = 'fastest.tpl.php';
$About = & new Template(ABOUT_PATH);
$AboutTemplateName = 'fastest-about.tpl.php';
$About->set('DataSet', $DataSet);
$SLangs = SelectedLangs($Langs, $Action, $HTTP_GET_VARS);
if (! file_exists(ABOUT_PATH.$AboutTemplateName)){ $AboutTemplateName = 'blank-about.tpl.php'; }
$Body->set('DataSet', $DataSet);
$metaRobots = '<meta name="robots" content="all" /><meta name="revisit" content="4 days" />';
$MetaKeywords = '<meta name="description" content="Find out which programming language has the fastest benchmark programs ('.PLATFORM_NAME.') &amp; how your favorite language compares." />';
$faqUrl = CORE_SITE.'help.php';
$bannerUrl = CORE_SITE;
$timeUsed = 'Elapsed secs';


$Data = FullRatios('u64/'.DATA_PATH.'data.csv', $Tests, $Langs, $Incl, $Excl, $SLangs);
$Data = array_merge_recursive($Data,FullRatios('u64q/'.DATA_PATH.'data.csv', $Tests, $Langs, $Incl, $Excl, $SLangs));
$Data = array_merge_recursive($Data,FullRatios('u32/'.DATA_PATH.'data.csv', $Tests, $Langs, $Incl, $Excl, $SLangs));
$Data = array_merge_recursive($Data,FullRatios('u32q/'.DATA_PATH.'data.csv', $Tests, $Langs, $Incl, $Excl, $SLangs));
$Body->set('Data', FullScores($SLangs,$Data));

// TEMPLATE VARS ////////////////////////////////////////////////

$Page->set('PageTitle', $Title.BAR.'Computer&nbsp;Language&nbsp;Benchmarks&nbsp;Game');
$Page->set('BannerTitle', BANNER_TITLE);
$Page->set('FaqTitle', FAQ_TITLE);
$Page->set('BannerUrl', $bannerUrl);
$Page->set('FaqUrl', $faqUrl);

$Body->set('Tests', $Tests);
$Body->set('Langs', $Langs);
$Body->set('Excl', $Excl);
$Body->set('Mark', $mark );
$Body->set('TimeUsed', $timeUsed);

$Body->set('About', $About->fetch($AboutTemplateName));

$Page->set('PageBody', $Body->fetch($TemplateName));
$Page->set('Robots', $metaRobots);
$Page->set('MetaKeywords', $MetaKeywords);
$Page->set('PageId', $PageId);

echo $Page->fetch('page.tpl.php');
?>



