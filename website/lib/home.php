<?php 
// Copyright (c) Isaac Gouy 2004


// LIBRARIES ////////////////////////////////////////////////

require_once(BLIB); 
require_once(LIB); 


// $HTTP_GET_VARS ///////////////////////////////////////////

if (isset($HTTP_GET_VARS['sort'])){ $S = $HTTP_GET_VARS['sort']; } 
else { $S = 'cpu'; }


// DATA ////////////////////////////////////////////////

$Tests = ReadUniqueArrays('test.csv');
uasort($Tests, 'CompareTestName');

$Langs = ReadUniqueArrays('lang.csv');
uasort($Langs, 'CompareLangName');


// TEMPLATE VARS /////////////////////////////////////////// 

$Page = & new Template(LIB_PATH);  
$Page->set('PageTitle', SITE_TITLE);
$Page->set('BannerTitle', BANNER_TITLE);
$Page->set('FaqTitle', FAQ_TITLE);
$Page->set('Sort', $S);

$Body = & new Template(LIB_PATH); 
$Body->set('Tests', $Tests);
$Body->set('Langs', $Langs);
$Body->set('Sort', $S);
$Body->set('AboutName', 'The Shootout');
$Body->set('About', HtmlFragment( ABOUT_PATH.'home.about' ));

$Page->set('PageBody', $Body->fetch('home.tpl.php'));

echo $Page->fetch('homepage.tpl.php');
?>
