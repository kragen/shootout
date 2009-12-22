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

list ($mark,$mtime)= MarkTime();
$mark = $mark.' '.SITE_NAME;

if (isset($HTTP_GET_VARS['d'])
      && strlen($HTTP_GET_VARS['d']) && (strlen($HTTP_GET_VARS['d']) <= 5)){
   $X = $HTTP_GET_VARS['d'];
   if (ereg("^[a-z]+$",$X) && ($X == 'ndata')){ $DataSet = $X; }
}
if (!isset($DataSet)){ $DataSet = 'data'; }


$MetaKeywords = '';

// PAGES ///////////////////////////////////////////////////

$Page = & new Template(LIB_PATH);
$Body = & new Template(LIB_PATH);

require_once(LIB_PATH.'lib_scorecard.php');

$PageId = 'shapes';
$Title = 'Code-used Time-used Shapes';
if ($DataSet == 'ndata'){ $mark = $mark.' n'; }
$Body->set('Title', $Title);
$TemplateName = 'shapes.tpl.php';
$About = & new Template(ABOUT_PATH);
$AboutTemplateName = 'shapes-about.tpl.php';
if (! file_exists(ABOUT_PATH.$AboutTemplateName)){ $AboutTemplateName = 'blank-about.tpl.php'; }
$Body->set('DataSet', $DataSet);
$Body->set('Data', TimeSizeShapes(DATA_PATH.$DataSet.'.csv', $Tests, $Langs, $Incl, $Excl));

$faqUrl = CORE_SITE.'help.php';
$bannerUrl = CORE_SITE;
$bannerTitleTag = 'title="Go to Computer Language Benchmarks Game Home"';

if (SITE_NAME == 'u32' || SITE_NAME == 'u32q' || SITE_NAME == 'u64' || SITE_NAME == 'u64q'){
   $metaRobots = '<meta name="robots" content="noindex,follow,noarchive" />';
} else {
   $metaRobots = '<meta name="robots" content="noindex,nofollow,noarchive" />';
   // Help people choose the up-to-date measurements
   $faqUrl = $faqUrl.'#means';
}
$metaKeywords = '<meta name="description" content="Look for patterns in Code-used Time-used Shapes ('.PLATFORM_NAME.') & find out how your favorite language compares." />';

// TEMPLATE VARS ////////////////////////////////////////////////

$Page->set('PageTitle', $Title.BAR.'Computer&nbsp;Language&nbsp;Benchmarks&nbsp;Game');
$Page->set('BannerTitle', BANNER_TITLE);
$Page->set('BannerTitleTag', $bannerTitleTag);
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



