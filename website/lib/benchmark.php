<?php 
// Copyright (c) Isaac Gouy 2004


// LIBRARIES ////////////////////////////////////////////////

require_once(BLIB); 
require_once(LIB); 


// DATA ///////////////////////////////////////////

$Tests = ReadUniqueArrays('test.csv');
uasort($Tests, 'CompareTestName');

$Langs = ReadUniqueArrays('lang.csv');
uasort($Langs, 'CompareLangName');

if (isset($HTTP_GET_VARS['test'])){ $T = $HTTP_GET_VARS['test']; } 
else { $T = 'ackermann'; }

if (isset($HTTP_GET_VARS['lang'])){ $L = $HTTP_GET_VARS['lang']; } 
else { $L = 'all'; }

if (isset($HTTP_GET_VARS['id'])){ $I = $HTTP_GET_VARS['id']; } 
else { $I = 0; }

if (isset($HTTP_GET_VARS['sort'])){ $S = $HTTP_GET_VARS['sort']; } 
else { $S = 'cpu'; }


// PAGES ///////////////////////////////////////////////////

// There are 4 kinds of test/lang combination
// - all tests all languages - Scorecard
// - all tests one language  - Ranking
// - one test all languages  - Benchmark
// - one test one language   - Program


$Page = & new Template(LIB_PATH);
$Body = & new Template(LIB_PATH); 


if ($T=='all'){
   if ($L=='all'){    // Scorecard
   
      $Title = 'The Scorecard';
      $TemplateName = 'scorecard.tpl.php';
      $AboutTemplateName = 'scorecard-about.tpl.php'; 

      $Weights = $HTTP_GET_VARS;
      unset($Weights['test'],$Weights['lang'],$Weights['id'],$Weights['sort']);
      $Body->set('W', $Weights);  

      $Body->set('Data', ScoreData(DATA_PATH.'data.csv', $Tests, $Langs)); 

   } else {           // Ranking 
   
      $LangName = $Langs[$L][LANG_FULL];    
      $Title = $LangName.' rankings'; 
      $TemplateName = 'ranking.tpl.php';
      $AboutTemplateName = $L.SEPARATOR.'about.tpl.php';
      if (! file_exists(ABOUT_PATH.$AboutTemplateName)){ $AboutTemplateName = 'blank-about.tpl.php'; }

      $Body->set('Rank', RankData(DATA_PATH.'data.csv', $Langs, $L));    
  
   }
} elseif ($L=='all'){ // Benchmark 

      $TestName = $Tests[$T][TEST_NAME];
      $Title = $TestName.' benchmark'; 
      $TemplateName = 'benchmark.tpl.php'; 
      $AboutTemplateName = $T.SEPARATOR.'about.tpl.php'; 
      if (! file_exists(ABOUT_PATH.$AboutTemplateName)){ $AboutTemplateName = 'blank-about.tpl.php'; }

      $Body->set('Data', ReadSelectedDataArrays(DATA_PATH.'data.csv', $T, DATA_TEST, DATA_LANG) );

} else {              // Program

      $TestName = $Tests[$T][TEST_NAME];
      $LangName = $Langs[$L][LANG_FULL];       
      $TemplateName = 'program.tpl.php';
      $Title = $TestName.' '.$LangName.IdName($I).' program';
      
      // NOTE Sometimes there's an alternative program for the benchmark test and language
      //      so we need to look for files with a particular Id, as-well-as test and language 
    
      $Id = '';
      if ($I > 0){ $Id = SEPARATOR.$I; } 
            
      $AboutTemplateName = $T.SEPARATOR.$L.$Id.SEPARATOR.'about.tpl.php'; 
      if (! file_exists(ABOUT_PATH.$AboutTemplateName)){ $AboutTemplateName = 'blank-about.tpl.php'; }

      $Body->set('Data', ReadSelectedDataArrays(DATA_PATH.'data.csv', $T, DATA_TEST, DATA_LANG) );      
      $Body->set('Code', HtmlFragment( CODE_PATH.$T.SEPARATOR.$L.$Id.'.code' ));    
      $Body->set('Log', HtmlFragment( LOG_PATH.$T.SEPARATOR.$L.$Id.'.log' ));
      $Body->set('Id', $I);
      $Body->set('Title', $Title);
}
 

// TEMPLATE VARS //////////////////////////////////////////////// 
 
$Page->set('PageTitle', $Title.BAR.SITE_TITLE);
$Page->set('BannerTitle', BANNER_TITLE);
$Page->set('FaqTitle', FAQ_TITLE);
$Page->set('Sort', $S);
 
$Body->set('Tests', $Tests);
$Body->set('SelectedTest', $T);
$Body->set('Langs', $Langs);
$Body->set('SelectedLang', $L);
$Body->set('Sort', $S);


$About = & new Template(ABOUT_PATH);
$About->set('SelectedTest', $T);
$About->set('SelectedLang', $L);
$About->set('Sort', $S);
$Body->set('About', $About->fetch($AboutTemplateName));


$Page->set('PageBody', $Body->fetch($TemplateName));

echo $Page->fetch('page.tpl.php');
?>
