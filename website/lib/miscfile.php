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
         $X == 'acknowledgements' ||
         $X == 'benchmarking' ||
         $X == 'dynamic' ||
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
   $bannerUrl = 'index.php'; $faqUrl = 'help.php';
   if ($F == 'benchmarking'){ $metaRobots = '<meta name="robots" content="all" /><meta name="revisit"  content="10 days" />'; }
   else { $metaRobots = '<meta name="robots" content="noindex,nofollow,noarchive" />'; }

} else {
   // Help people choose the up-to-date measurements
   $bannerUrl = 'http://shootout.alioth.debian.org/index.php'; 
   $faqUrl = 'http://shootout.alioth.debian.org/u32q/help.php#means';
   $metaRobots = '<meta name="robots" content="noindex,nofollow,noarchive" />';
}

// TEMPLATE VARS ////////////////////////////////////////////////

$Page = & new Template(LIB_PATH);  
$Page->set('PageTitle', $T.BAR.SITE_TITLE);
$Page->set('BannerTitle', BANNER_TITLE);
$Page->set('FaqTitle', FAQ_TITLE);
$Page->set('BannerUrl', $bannerUrl);
$Page->set('FaqUrl', $faqUrl);
$Page->set('PageBody', BLANK);
$Page->set('PicturePath', CORE_SITE);

$Body = & new Template(LIB_PATH);
$Body->set('Title', $T);
$Body->set('MiscFile', MISC_PATH.$F.'.php');
$Body->set('Changed', filemtime(MISC_PATH.$F.'.php'));

$Page->set('PageBody', $Body->fetch('misc.tpl.php'));

$Page->set('Robots', $metaRobots);
$Page->set('MetaKeywords', '');
$Page->set('PageId', 'miscfile');

echo $Page->fetch('page.tpl.php');
?>
