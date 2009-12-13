<?php
// Copyright (c) Isaac Gouy 2004-2009

// LIBRARIES ////////////////////////////////////////////////

require_once(LIB_PATH.'lib_whitelist.php');
require_once(LIB); 

// DATA ///////////////////////////////////////////

if (isset($HTTP_GET_VARS['file'])
      && strlen($HTTP_GET_VARS['file']) && (strlen($HTTP_GET_VARS['file']) <= NAME_LEN)){
   $X = $HTTP_GET_VARS['file'];
   if (ereg("^[a-z]+$",$X) && (
         $X == 'benchmarking' ||
         $X == 'license'
      )){ $F = $X; }
}
if (!isset($F)){ $F = 'license'; }


if (isset($HTTP_GET_VARS['title'])
      && strlen($HTTP_GET_VARS['title']) && (strlen($HTTP_GET_VARS['title']) <= 2*NAME_LEN)){
   $T = strip_tags($HTTP_GET_VARS['title']);
}
if (!isset($T)){ $T = ''; }


if (SITE_NAME == 'u32' || SITE_NAME == 'u32q' || SITE_NAME == 'u64' || SITE_NAME == 'u64q'){
   $faqUrl = 'help.php';
   if ($F == 'benchmarking'){ 
      $metaRobots = '<meta name="robots" content="index,follow,noarchive" /><meta name="revisit"  content="10 days" />';
      $metaKeywords = '<meta name="description" content="Some of the many ways in which benchmark comparisons of programming language performance are flawed." />';
   } else {
      $metaRobots = '<meta name="robots" content="noindex,nofollow,noarchive" />';
      $metaKeywords = '<meta name="description" content="Software contributed to The Computer Language Benchmarks Game is published under this revised BSD license." />';
   }

} else {
   // Help people choose the up-to-date measurements
   $faqUrl = '../u64/help.php#means';
   $metaRobots = '<meta name="robots" content="noindex,nofollow,noarchive" />';
}

// TEMPLATE VARS ////////////////////////////////////////////////

$Page = & new Template(LIB_PATH);  
$Page->set('PageTitle', $T.BAR.'Computer&nbsp;Language&nbsp;Benchmarks&nbsp;Game');
$Page->set('BannerTitle', 'The&nbsp;Computer&nbsp;Language&nbsp; <br/>Benchmarks&nbsp;Game');
$Page->set('FaqTitle', 'Help');
$Page->set('BannerUrl', '../index.php');
$Page->set('FaqUrl', $faqUrl);
$Page->set('PageBody', BLANK);
$Page->set('PicturePath', CORE_SITE);

$Body = & new Template(LIB_PATH);
$Body->set('Title', $T);
$Body->set('MiscFile', MISC_PATH.$F.'.php');
$Body->set('Changed', filemtime(MISC_PATH.$F.'.php'));

$Page->set('PageBody', $Body->fetch('misc.tpl.php'));

$Page->set('Robots', $metaRobots);
$Page->set('MetaKeywords', $metaKeywords);
$Page->set('PageId', 'miscfile');

echo $Page->fetch('page.tpl.php');
?>
