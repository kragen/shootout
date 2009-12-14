<?php
// Copyright (c) Isaac Gouy 2009

// LIBRARIES ////////////////////////////////////////////////

require_once(LIB_PATH.'lib_whitelist.php');
require_once(LIB_PATH.'lib_common.php');
require_once(LIB);

// DATA ///////////////////////////////////////////

list($Incl,$Excl) = WhiteListInEx();
$Tests = WhiteListUnique('test.csv',$Incl);
uasort($Tests, 'CompareTestName');

$Langs = WhiteListUnique('lang.csv',$Incl);
uasort($Langs, 'CompareLangName');



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

$Page = & new Template(LIB_PATH);
$Body = & new Template(LIB_PATH);

$S = '';
$PageId = 'boxplot';

require_once(LIB_PATH.'lib_scorecard.php');

list ($mark,$mtime)= MarkTime('u64q/');
$mark = $mark.' 32 64';

$Title = 'Which programming language is fastest?';
if ($DataSet == 'ndata'){ $Title = $Title.' - Full Data'; $mark = $mark.' n'; }
$Body->set('Title', $Title);
$TemplateName = 'fastest.tpl.php';
$About = & new Template(ABOUT_PATH);
$AboutTemplateName = 'fastest-about.tpl.php';
$About->set('DataSet', $DataSet);
$SLangs = SelectedLangs($Langs, $Action, $HTTP_GET_VARS);
if (! file_exists(ABOUT_PATH.$AboutTemplateName)){ $AboutTemplateName = 'blank-about.tpl.php'; }
$Body->set('DataSet', $DataSet);
$metaRobots = '<meta name="robots" content="all" /><meta name="revisit" content="4 days" />';
$MetaKeywords = '<meta name="description" content="Find out which programming language has the fastest benchmark programs ('.PLATFORM_NAME.') & how your favorite language compares." />';
$faqUrl = CORE_SITE.'help.php';
$bannerUrl = 'index.php';
$timeUsed = 'Elapsed secs';


$Data = FullRatios('u64/'.DATA_PATH.$DataSet.'.csv', $Tests, $Langs, $Incl, $Excl, $SLangs);
$Data = array_merge_recursive($Data,FullRatios('u64q/'.DATA_PATH.$DataSet.'.csv', $Tests, $Langs, $Incl, $Excl, $SLangs));
$Data = array_merge_recursive($Data,FullRatios('u32/'.DATA_PATH.$DataSet.'.csv', $Tests, $Langs, $Incl, $Excl, $SLangs));
$Data = array_merge_recursive($Data,FullRatios('u32q/'.DATA_PATH.$DataSet.'.csv', $Tests, $Langs, $Incl, $Excl, $SLangs));
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
$Body->set('MTime', $mtime);
$Body->set('TimeUsed', $timeUsed);

$Body->set('About', $About->fetch($AboutTemplateName));

$Page->set('PageBody', $Body->fetch($TemplateName));
$Page->set('Robots', $metaRobots);
$Page->set('MetaKeywords', $MetaKeywords);
$Page->set('PageId', $PageId);

echo $Page->fetch('page.tpl.php');
?>



