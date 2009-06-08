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

$PageId = 'summarydata';
$Title = 'Summary Data';
$TemplateName = 'summarydata.tpl.php';
if ($DataSet == 'ndata'){ $Title = $Title.' - Full Data'; $mark = $mark.' n'; }
$Body->set('DataSet', $DataSet);
$Body->set('Data', DataRows(DATA_PATH.$DataSet.'.csv', $Tests, $Langs, $Incl, $Excl));
$Body->set('Title', $Title);
$metaRobots = '<meta name="robots" content="noindex,nofollow,noarchive" />';


// TEMPLATE VARS ////////////////////////////////////////////////

$Page->set('PageTitle', $Title.BAR.SITE_TITLE);
$Page->set('BannerTitle', BANNER_TITLE);
$Page->set('FaqTitle', FAQ_TITLE);
$Body->set('Mark', $mark);

$Page->set('PageBody', $Body->fetch($TemplateName));
$Page->set('Robots', $metaRobots);
$Page->set('MetaKeywords', $MetaKeywords);
$Page->set('PageId', $PageId);

echo $Page->fetch('page.tpl.php');
?>



