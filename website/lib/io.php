<?php 
// Copyright (c) Isaac Gouy 2004


// LIBRARIES ////////////////////////////////////////////////

require_once(BLIB);  
require_once(LIB); 


// DATA ///////////////////////////////////////////

$Tests = ReadUniqueArrays(DATA_PATH.'test.csv');

if (isset($HTTP_GET_VARS['test'])){ $T = $HTTP_GET_VARS['test']; } 
else { $T = 'ackermann'; }

if (isset($HTTP_GET_VARS['sort'])){ $S = $HTTP_GET_VARS['sort']; } 
else { $S = 'cpu'; }

if (isset($HTTP_GET_VARS['io'])){ $F = $HTTP_GET_VARS['io']; } 
else { $F = 'input'; }

$TestName = $Tests[$T][TEST_NAME];

if ($F == 'input'){ $Title = $TestName.' input file'; } 
elseif ($F == 'output'){ $Title = $TestName.' output file'; }
elseif ($F == 'dict') { $Title = $TestName.' Usr.Dict.Words file'; }
else { $Title = $TestName; }


// TEMPLATE VARS //////////////////////////////////////////////// 

$Page = & new Template(LIB_PATH);  
$Page->set('PageTitle', $Title.BAR.SITE_TITLE);
$Page->set('BannerTitle', BANNER_TITLE);
$Page->set('FaqTitle', FAQ_TITLE);
$Page->set('PageBody', BLANK);
$Page->set('Sort', $S);

$Body = & new Template(LIB_PATH); 
$Body->set('Title', $Title);
$Body->set('Text', HtmlFragment( DATA_PATH.$T.SEPARATOR.$F.'.txt' ));

$Page->set('PageBody', $Body->fetch('pre.tpl.php'));

echo $Page->fetch('page.tpl.php');

?>
