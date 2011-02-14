<?php
// Copyright (c) Isaac Gouy 2009-2011

// LIBRARIES ////////////////////////////////////////////////

require_once(LIB_PATH.'lib_whitelist.php');
require_once(LIB_PATH.'lib_common.php');
require_once(LIB);

// FUNCTIONS ///////////////////////////////////////////

function SelectedLangs($Langs, $Action, $Vars){
   $w = array(); $wd = array();
   foreach($Langs as $lang){
      $link = $lang[LANG_LINK];
      if (isset($Vars[$link])){ $w[$link] = 1; }
      if ($lang[LANG_SELECT]){ $wd[$link] = 1; }
   }
   if ($Action=='reset'||sizeof($w)<=0){ $w = $wd; }
   return $w;
}


// GET_VARS ////////////////////////////////////////////////

list($Incl,$Excl) = WhiteListInEx();
$Tests = WhiteListUnique('test.csv',$Incl); // assume test.csv in name order
$Langs = WhiteListUnique('lang.csv',$Incl); // assume lang.csv in name order

$SLangs = SelectedLangs($Langs, $Action, $HTTP_GET_VARS);

if (isset($HTTP_GET_VARS['calc'])
      && strlen($HTTP_GET_VARS['calc']) && (strlen($HTTP_GET_VARS['calc']) <= 9)){
   $X = $HTTP_GET_VARS['calc'];
   if (ereg("^[a-z]+$",$X) && ($X == 'reset')){ $Action = $X; }
}
if (!isset($Action)){ $Action = 'calculate'; }


if (isset($HTTP_GET_VARS['d'])
      && strlen($HTTP_GET_VARS['d']) && (strlen($HTTP_GET_VARS['d']) <= 5)){
   $X = $HTTP_GET_VARS['d'];
   if (ereg("^[a-z]+$",$X) && ($X == 'ndata')){ $DataSet = $X; }
}
if (!isset($DataSet)||isset($Action)&&$Action=='reset'){ $DataSet = 'data'; }


// HEADER ////////////////////////////////////////////////

list ($mark,$mtime)= MarkTime();
$mark = $mark.' '.SITE_NAME;


// PAGES ///////////////////////////////////////////////////


$Page = & new Template(LIB_PATH);
$Body = & new Template(LIB_PATH);

$PageId = 'scorecard';

require_once(LIB_PATH.'lib_scorecard.php');

$mark = MarkTime();

$Title = 'Which programming language is best?';
if ($DataSet == 'ndata'){ $Title = $Title.' - Full Data'; $mark = $mark.' n'; }
$Body->set('Title', $Title);
$TemplateName = 'scorecard.tpl.php';
$About = & new Template(ABOUT_PATH);
$AboutTemplateName = 'scorecard-about.tpl.php';
$About->set('DataSet', $DataSet);
$W = Weights($Tests, $Action, $HTTP_GET_VARS);
$Body->set('DataSet', $DataSet);
$Body->set('W', $W);
$Body->set('Data', FullWeightedData(DATA_PATH.$DataSet.'.csv', $Tests, $Langs, $Incl, $Excl, $W));
$metaRobots = '<meta name="robots" content="noindex,follow,noarchive" />';
$MetaKeywords = '<meta name="description" content="Compare programming language performance using your choice of benchmarks &amp; Time-used Memory-used Code-used weights ('.PLATFORM_NAME.')." />';

$faqUrl = CORE_SITE.'help.php';
$timeUsed = 'Elapsed secs';
$bannerUrl = CORE_SITE;

if (!(SITE_NAME == 'u32' || SITE_NAME == 'u32q' || SITE_NAME == 'u64' || SITE_NAME == 'u64q')){
   $metaRobots = '<meta name="robots" content="noindex,nofollow,noarchive" />';
   // Help people choose the up-to-date measurements
   $timeUsed = 'CPU secs';
}


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

$Body->set('Selected', $SLangs );

$Body->set('About', $About->fetch($AboutTemplateName));

$Page->set('PageBody', $Body->fetch($TemplateName));
$Page->set('Robots', $metaRobots);
$Page->set('MetaKeywords', $MetaKeywords);
$Page->set('PageId', $PageId);

echo $Page->fetch('page.tpl.php');
?>
