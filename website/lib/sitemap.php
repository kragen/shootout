<?php
// Copyright (c) Isaac Gouy 2010

// LIBRARIES ////////////////////////////////////////////////

require_once(LIB_PATH.'lib_whitelist.php');
require_once(LIB);


// FUNCTIONS ///////////////////////////////////////////

function SiteWhiteListIn($site){
   $incl = array();
   $lines = @file('./'.$site.'/include.csv') or die('Cannot open ./'.$site.'/include.csv');
   // assume no header line
   foreach($lines as $line) {
      $incl[ chop($line) ] = TRUE;
   }
   return $incl;
}


// DATA ///////////////////////////////////////////

$Sites = array('u32','u32q','u64','u64q');

$SiteLangs = array();
foreach($Sites as $s){
   $Incl = SiteWhiteListIn($s);
   $SiteLangs[$s] = WhiteListUnique('lang.csv',$Incl); // assume lang.csv in name order
   $SiteTests[$s] = WhiteListUnique('test.csv',$Incl); // assume test.csv in name order
}


// TEMPLATE VARS ////////////////////////////////////////////////

$Page = & new Template(LIB_PATH);
$Page->set('PageTitle', 'Site Map'.BAR.'Computer&nbsp;Language&nbsp;Benchmarks&nbsp;Game');
$Page->set('BannerTitle', 'The&nbsp;Computer&nbsp;Language&nbsp; <br/>Benchmarks&nbsp;Game');
$Page->set('FaqTitle', '[[ Help ]]');

$Body = & new Template(LIB_PATH);

$Body->set('Sites', $Sites);
$Body->set('SiteLangs', $SiteLangs);
$Body->set('SiteTests', $SiteTests);

$Page->set('PageBody', $Body->fetch('sitemap.tpl.php'));


$metaRobots = '<meta name="robots" content="index,follow,noarchive" />';
$bannerUrl = CORE_SITE;

$faqUrl = CORE_SITE.'help.php';
$MetaKeywords = '<meta name="description" content="A list of page links for the current Computer Language Benchmarks Game website." />';

$Page->set('Robots', $metaRobots);
$Page->set('BannerUrl', $bannerUrl);
$Page->set('FaqUrl', $faqUrl);
$Page->set('MetaKeywords', $MetaKeywords);
$Page->set('PageId', 'boxplot');

echo $Page->fetch('page.tpl.php');
?>