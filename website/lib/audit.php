<?php 

// Copyright (c) Isaac Gouy 2004, 2005

// LIBRARIES ////////////////////////////////////////////////

require_once(BLIB); 
require_once(LIB); 

// DATA ///////////////////////////////////////////

list($Incl,$Excl) = ReadIncludeExclude();

$Tests = ReadUniqueArrays('test.csv',$Incl);
uasort($Tests, 'CompareTestName');

$Langs = ReadUniqueArrays('lang.csv',$Incl);
uasort($Langs, 'CompareLangName');


// PAGE ///////////////////////////////////////////////////

$Page = & new Template(LIB_PATH);
$Body = & new Template(LIB_PATH); 

$Title = 'audit'; 
$TemplateName = 'audit.tpl.php'; 
$AboutTemplateName = 'blank-about.tpl.php';

list($d,$n,$t) = ReadCsv(DATA_PATH.'ndata.csv');
$Body->set('NData', $d);
$Body->set('NDataN', $n);
$Body->set('NDataTimeL', $t);

list($d,$n,$t) = ReadCsv(DATA_PATH.'data.csv');
$Body->set('Data', $d);


// TEMPLATE VARS //////////////////////////////////////////////// 

$Page->set('PageTitle', $Title.BAR.SITE_TITLE);
$Page->set('BannerTitle', BANNER_TITLE);
$Page->set('FaqTitle', FAQ_TITLE);

$About = & new Template(ABOUT_PATH);
$Body->set('About', $About->fetch($AboutTemplateName));
$Page->set('PageBody', $Body->fetch($TemplateName));
$Page->set('Robots', '<meta name="robots" content="noindex,nofollow" />');

echo $Page->fetch('page.tpl.php');
?>

