<?php
// Copyright (c) Isaac Gouy 2004-2007

// LIBRARIES ////////////////////////////////////////////////

require_once(LIB_PATH.'lib_common.php'); 
require_once(LIB); 

// DATA ///////////////////////////////////////////

if (isset($HTTP_GET_VARS['sort'])){ $S = $HTTP_GET_VARS['sort']; } 
else { $S = 'cpu'; }

if (isset($HTTP_GET_VARS['file'])){ $F = $HTTP_GET_VARS['file']; } 
else { $F = ''; }

if (isset($HTTP_GET_VARS['title'])){ $T = $HTTP_GET_VARS['title']; }
else { $T = ''; }

// TEMPLATE VARS //////////////////////////////////////////////// 

$Page = & new Template(LIB_PATH);  
$Page->set('PageTitle', $T.BAR.SITE_TITLE);
$Page->set('BannerTitle', BANNER_TITLE);
$Page->set('FaqTitle', FAQ_TITLE);
$Page->set('PageBody', BLANK);
$Page->set('Sort', $S);
$Page->set('PicturePath', CORE_SITE);

$Body = & new Template(LIB_PATH); 
$Body->set('Title', $T);
$Body->set('MiscFile', MISC_PATH.$F.'.php');
$Body->set('Changed', filemtime(MISC_PATH.$F.'.php'));

$Page->set('PageBody', $Body->fetch('misc.tpl.php'));

if ($F == 'benchmarking'){ $metaRobots = '<meta name="robots" content="all" /><meta name="revisit" content="10 days" />'; }
else { $metaRobots = '<meta name="robots" content="noindex,nofollow,noarchive" />'; }

$Page->set('Robots', $metaRobots);
$Page->set('MetaKeywords', '');
$Page->set('PageId', 'miscfile');

echo $Page->fetch('page.tpl.php');
?>
