<?php
// Copyright (c) Isaac Gouy 2004-2009

// LIBRARIES ////////////////////////////////////////////////

require_once(LIB_PATH.'lib_whitelist.php');
require_once(LIB); 

// DATA ///////////////////////////////////////////

list($Incl,$Excl) = WhiteListInEx();
$Tests = WhiteListUnique('test.csv',$Incl);

if (isset($HTTP_GET_VARS['test'])
      && strlen($HTTP_GET_VARS['test']) && (strlen($HTTP_GET_VARS['test']) <= NAME_LEN)){
   $X = $HTTP_GET_VARS['test'];
   if (ereg("^[a-z]+$",$X) && (isset($Tests[$X]) || $X == 'all')){ $T = $X; }
}
if (!isset($T)){ $T = 'nbody'; }


if (isset($HTTP_GET_VARS['file'])
      && strlen($HTTP_GET_VARS['file']) && (strlen($HTTP_GET_VARS['file']) <= 6)){
   $X = $HTTP_GET_VARS['file'];
   if (ereg("^[a-z]+$",$X) && ($X == 'input')){ $F = $X; }
}
if (!isset($F)){ $F = 'output'; }

if (!isset($E)){ $E = 'txt'; }


$TestName = $Tests[$T][TEST_NAME];

if ($F == 'input'){ $Title = $TestName.' input file'; } 
elseif ($F == 'output'){ $Title = $TestName.' output file'; }
else { $Title = $TestName; }

$faqUrl = CORE_SITE.'help.php';
$bannerUrl = CORE_SITE;

// TEMPLATE VARS ////////////////////////////////////////////////

$Page = & new Template(LIB_PATH);
$Page->set('PageTitle', $Title.BAR.'Computer&nbsp;Language&nbsp;Benchmarks&nbsp;Game');
$Page->set('BannerTitle', BANNER_TITLE);
$Page->set('FaqTitle', FAQ_TITLE);
$Page->set('BannerUrl', $bannerUrl);
$Page->set('FaqUrl', $faqUrl);
$Page->set('PageBody', BLANK);

$Body = & new Template(LIB_PATH);
$Body->set('Title', $Title);
$Body->set('Download', DOWNLOAD_PATH.$T.SEPARATOR.$F.'.'.$E);
$Body->set('Text', HtmlFragment( DOWNLOAD_PATH.$T.SEPARATOR.$F.'.'.$E ));

$Page->set('PageBody', $Body->fetch('iofile.tpl.php'));
$Page->set('Robots', '<meta name="robots" content="noindex,nofollow,noarchive" />');
$Page->set('MetaKeywords', '');
$Page->set('PageId', 'iofile');
echo $Page->fetch('page.tpl.php');
?>

