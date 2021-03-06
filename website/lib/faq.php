<?php
// Copyright (c) Isaac Gouy 2004-2009

// LIBRARIES ////////////////////////////////////////////////

require_once(LIB_PATH.'lib_common.php');  
require_once(LIB); 


// TEMPLATE VARS ////////////////////////////////////////////////

$Page = & new Template(LIB_PATH);
$Page->set('PageTitle', 'Help'.BAR.'The&nbsp;Computer&nbsp;Language&nbsp;Benchmarks&nbsp;Game');
$Page->set('BannerTitle', 'The&nbsp;Computer&nbsp;Language&nbsp; <br/>Benchmarks&nbsp;Game');
$Page->set('FaqTitle', 'Help');
$Page->set('PageBody', BLANK);

$Body = & new Template(LIB_PATH);
$Body->set('Download', DOWNLOAD_PATH);
$Body->set('Changed', filemtime(LIB_PATH.'help.tpl.php'));

$Page->set('PageBody', $Body->fetch('help.tpl.php'));

if (SITE_NAME == 'u32' || SITE_NAME == 'u32q' || SITE_NAME == 'u64' || SITE_NAME == 'u64q'){
   $metaRobots = '<meta name="robots" content="follow,index,noarchive" /><meta name="revisit" content="10 days" />';
   $faqUrl = 'help.php';
} else {
   $metaRobots = '<meta name="robots" content="noindex,nofollow,noarchive" />';
   // Help people choose the up-to-date measurements
   $faqUrl = '../u64/help.php#means';
}

$Page->set('Robots', $metaRobots);
$Page->set('BannerUrl', '../index.php');
$Page->set('FaqUrl', $faqUrl);
$Page->set('MetaKeywords', '');
$Page->set('PageId', 'faq');

echo $Page->fetch('page.tpl.php');
?>

