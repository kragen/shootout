<?php
// Copyright (c) Isaac Gouy 2010

// LIBRARIES ////////////////////////////////////////////////

require_once(LIB_PATH.'lib_whitelist.php');
require_once(LIB);
require_once(LIB_PATH.'lib_data.php');

// FUNCTIONS ///////////////////////////////////////////

function LanguageData($FileName,$Langs,$Incl,$Excl,$L,$HasHeading=TRUE){
   $rows = array();
   $lines = file($FileName);

   $prefixL = ','.$L.',';
   foreach($lines as $line) {
      if (strpos($line,$prefixL)){
         $row = explode( ',', $line);
         $test = $row[DATA_TEST];
         $key = $test.$L.$row[DATA_ID];

         // $L has already been checked
         if (isset($Incl[$test]) && isset($Incl[$L]) && !isset($Excl[$key])){
            settype($row[DATA_STATUS],'integer');
            $rows[] = $row;
         }

      }
   }
   return $rows;
}


// PAGE ////////////////////////////////////////////////

$Page = & new Template(LIB_PATH);
$Body = & new Template(LIB_PATH);
$PageId = 'headtohead';
$TemplateName = 'measurements.tpl.php';


// GET_VARS ////////////////////////////////////////////////

list($Incl,$Excl) = WhiteListInEx();
$Tests = WhiteListUnique('test.csv',$Incl); // assume test.csv in name order
$Langs = WhiteListUnique('lang.csv',$Incl); // assume lang.csv in name order

if (isset($HTTP_GET_VARS['lang'])
      && strlen($HTTP_GET_VARS['lang']) && (strlen($HTTP_GET_VARS['lang']) <= NAME_LEN)){
   $X = $HTTP_GET_VARS['lang'];
   if (ereg("^[a-z0-9]+$",$X) && (isset($Langs[$X]) || $X == 'all' || $X == 'fun')){ $L = $X; }
}
if (!isset($L)){ $L = ''; }


// HEADER ////////////////////////////////////////////////

$mark = MarkTime();
$mark = $mark.' '.SITE_NAME;

$LangName = $Langs[$L][LANG_FULL];
$Title = $LangName.' measurements';

$bannerUrl = CORE_SITE;
$faqUrl = CORE_SITE.'help.php';


// DATA ////////////////////////////////////////////////

$Body->set('Data', LanguageData(DATA_PATH.'ndata.csv',$Langs,$Incl,$Excl,$L));

$timeUsed = 'Elapsed secs';
if (SITE_NAME == 'gp4' || SITE_NAME == 'debian'){
   $timeUsed = 'CPU secs';
}


// ABOUT ////////////////////////////////////////////////

$About = & new Template(ABOUT_PATH);
$AboutTemplateName = $L.SEPARATOR.'about.tpl.php';
if (! file_exists(ABOUT_PATH.$AboutTemplateName)){ $AboutTemplateName = 'blank-about.tpl.php'; }
$About->set('Version', HtmlFragment(VERSION_PATH.$L.SEPARATOR.'version.php'));


// META ////////////////////////////////////////////////

$MetaKeywords = '<meta name="description" content="Performance measurements for all the '.$LangName.' programs implementing ~12 flawed benchmarks ('.PLATFORM_NAME.')." />';

$metaRobots = '<meta name="robots" content="index,follow,noarchive" />';
if (SITE_NAME == 'gp4' || SITE_NAME == 'debian'){
   $metaRobots = '<meta name="robots" content="noindex,nofollow,noarchive" />';
}


// TEMPLATE VARS ////////////////////////////////////////////////

$Page->set('PageTitle', $Title.BAR.'Computer&nbsp;Language&nbsp;Benchmarks&nbsp;Game');
$Page->set('BannerTitle', BANNER_TITLE);
$Page->set('BannerUrl', $bannerUrl);
$Page->set('FaqTitle', FAQ_TITLE);
$Page->set('FaqUrl', $faqUrl);

$Body->set('Tests', $Tests);
$Body->set('Langs', $Langs);
$Body->set('SelectedLang', $L);
$Body->set('Excl', $Excl);
$Body->set('Mark', $mark);
$Body->set('TimeUsed', $timeUsed);

$About->set('SelectedLang', $L);

$Body->set('About', $About->fetch($AboutTemplateName));
$Page->set('PageBody', $Body->fetch($TemplateName));
$Page->set('Robots', $metaRobots);
$Page->set('MetaKeywords', $MetaKeywords);
$Page->set('PageId', $PageId);

echo $Page->fetch('page.tpl.php');
?>