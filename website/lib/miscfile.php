<?php 
// Copyright (c) Isaac Gouy 2004, 2005
// LIBRARIES ////////////////////////////////////////////////
require_once(BLIB);  
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
$Page->set('Sort', $S);$Misc = & new Template(LIB_PATH);$Misc->set('ROOT', CORE_SITE);
$Body = & new Template(LIB_PATH); 
$Body->set('Title', $T);
$Body->set('MiscBody', $Misc->fetch(MISC_PATH.$F.'.php'));
$Page->set('PageBody', $Body->fetch('misc.tpl.php'));
$Page->set('Robots', '<meta name="robots" content="noindex,nofollow" />');
echo $Page->fetch('page.tpl.php');
?>
