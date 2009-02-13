<?php
// Copyright (c) Isaac Gouy 2004-2009

// LIBRARIES ////////////////////////////////////////////////

require_once(LIB_PATH.'lib_whitelist.php');
require_once(LIB_PATH.'lib_common.php');
require_once(LIB); 

// DATA ////////////////////////////////////////////////

list($Incl,$Excl) = WhiteListInEx();
$Tests = WhiteListUnique('test.csv',$Incl);

$Langs = WhiteListUnique('lang.csv',$Incl);
uasort($Langs, 'CompareLangName');

list ($mark,$mtime)= MarkTime();
$mark = $mark.' '.SITE_NAME;

// TEMPLATE VARS ///////////////////////////////////////////

$Page = & new Template(LIB_PATH);  
$Page->set('PageTitle', SITE_TITLE);
$Page->set('BannerTitle', BANNER_TITLE);
$Page->set('FaqTitle', FAQ_TITLE);

$Body = & new Template(LIB_PATH); 
$Body->set('Tests', $Tests);
$Body->set('Langs', $Langs);

$Body->set('Mark', $mark);
$Body->set('MTime', $mtime);
$Body->set('Data', TestData(DATA_PATH.'data.csv', $Tests, $Langs, $Incl, $Excl));

$Intro = & new Template(ABOUT_PATH);
$Body->set('Intro', $Intro->fetch(SITE_NAME.SEPARATOR.'intro.about'));

$Feature = & new Template(ABOUT_PATH);
$Body->set('Feature', $Feature->fetch('feature.about'));

$About = & new Template(ABOUT_PATH);
$Body->set('About', $About->fetch(SITE_NAME.SEPARATOR.'home.about'));

$Page->set('PageBody', $Body->fetch('home.tpl.php'));

$metaRobots = '<meta name="robots" content="follow,index,noarchive" /><meta name="revisit" content="1 days" />';

$Page->set('Robots', $metaRobots);
$Page->set('PageId', 'nav');

echo $Page->fetch('homepage.tpl.php');
?>

