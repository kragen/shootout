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


$bannerUrl = 'http://shootout.alioth.debian.org/index.php'; 

if (SITE_NAME == 'u32' || SITE_NAME == 'u32q' || SITE_NAME == 'u64' || SITE_NAME == 'u64q'){
   $metaRobots = '<meta name="robots" content="follow,noindex,noarchive" />;
   $faqUrl = 'help.php';
} else {
   $metaRobots = '<meta name="robots" content="noindex,nofollow,noarchive" />';
   // Help people choose the up-to-date measurements
   $faqUrl = 'http://shootout.alioth.debian.org/u32/help.php#means';
}

$Page->set('Robots', $metaRobots);
$Page->set('PageId', 'nav');
$Page->set('BannerUrl', $bannerUrl);
$Page->set('FaqUrl', $faqUrl);

echo $Page->fetch('homepage.tpl.php');
?>

