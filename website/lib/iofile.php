<?php 
// Copyright (c) Isaac Gouy 2004, 2005

// LIBRARIES ////////////////////////////////////////////////

require_once(BLIB);  
require_once(LIB); 

// DATA ///////////////////////////////////////////

list($Incl,$Excl) = ReadIncludeExclude();
$Tests = ReadUniqueArrays('test.csv',$Incl);

if (isset($HTTP_GET_VARS['test'])){ $T = $HTTP_GET_VARS['test']; } 
else { $T = 'ackermann'; }

if (isset($HTTP_GET_VARS['sort'])){ $S = $HTTP_GET_VARS['sort']; } 
else { $S = 'cpu'; }

if (isset($HTTP_GET_VARS['file'])){ $F = $HTTP_GET_VARS['file']; } 
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
$Body->set('Download', DOWNLOAD_PATH.$T.SEPARATOR.$F.'.txt');
$Body->set('Text', HtmlFragment( DOWNLOAD_PATH.$T.SEPARATOR.$F.'.txt' ));

$Page->set('PageBody', $Body->fetch('iofile.tpl.php'));
$Page->set('Robots', '<meta name="robots" content="noindex,nofollow" />');
echo $Page->fetch('page.tpl.php');
?>

