<?php 
// Copyright (c) Isaac Gouy 2004


// LIBRARIES ////////////////////////////////////////////////

require_once(BLIB); 
require_once(LIB); 


// DATA ///////////////////////////////////////////


list($Incl,$Excl) = ReadIncludeExclude();

$Tests = ReadUniqueArrays('test.csv',$Incl);
uasort($Tests, 'CompareTestName');

$Langs = ReadUniqueArrays('lang.csv',$Incl);
uasort($Langs, 'CompareLangName');


if (isset($HTTP_GET_VARS['test'])){ $T = $HTTP_GET_VARS['test']; } 
else { $T = 'ackermann'; }

if (isset($HTTP_GET_VARS['lang'])){ $L = $HTTP_GET_VARS['lang']; } 
else { $L = 'all'; }

if (isset($HTTP_GET_VARS['id'])){ $I = $HTTP_GET_VARS['id']; } 
else { $I = 0; }

if (isset($HTTP_GET_VARS['sort'])){ $S = $HTTP_GET_VARS['sort']; } 
else { $S = 'cpu'; }


if (isset($HTTP_GET_VARS['p1'])){ $P1 = $HTTP_GET_VARS['p1']; } 
else { $P1 = ''; }

if (isset($HTTP_GET_VARS['p2'])){ $P2 = $HTTP_GET_VARS['p2']; } 
else { $P2 = ''; }

if (isset($HTTP_GET_VARS['p3'])){ $P3 = $HTTP_GET_VARS['p3']; } 
else { $P3 = ''; }

if (isset($HTTP_GET_VARS['p4'])){ $P4 = $HTTP_GET_VARS['p4']; } 
else { $P4 = ''; }


// PAGE ///////////////////////////////////////////////////


$Page = & new Template(LIB_PATH);
$Body = & new Template(LIB_PATH); 


$TestName = $Tests[$T][TEST_NAME];
$Title = $TestName.' side-by-side'; 
$TemplateName = 'sidebyside.tpl.php'; 

$AboutTemplateName = 'sidebyside-about.tpl.php'; 
if (! file_exists(ABOUT_PATH.$AboutTemplateName)){ $AboutTemplateName = 'blank-about.tpl.php'; }

$Body->set('Data', ReadSelectedDataArrays(DATA_PATH.'ndata.csv', $T, $Incl) );


 

// TEMPLATE VARS //////////////////////////////////////////////// 
 
$Page->set('PageTitle', $Title.BAR.SITE_TITLE);
$Page->set('BannerTitle', BANNER_TITLE);
$Page->set('FaqTitle', FAQ_TITLE);
$Page->set('Sort', $S);
 
$Body->set('Tests', $Tests);
$Body->set('SelectedTest', $T);
$Body->set('Langs', $Langs);
$Body->set('SelectedLang', $L);
$Body->set('Sort', $S);
$Body->set('Excl', $Excl);

$Body->set('P1', $P1);
$Body->set('P2', $P2);
$Body->set('P3', $P3);
$Body->set('P4', $P4);


$About = & new Template(ABOUT_PATH);
$About->set('SelectedTest', $T);
$About->set('SelectedLang', $L);
$About->set('Sort', $S);

$Body->set('About', $About->fetch($AboutTemplateName));


$Page->set('PageBody', $Body->fetch($TemplateName));

echo $Page->fetch('page.tpl.php');
?>
