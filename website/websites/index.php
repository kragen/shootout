<?php 
ob_start('ob_gzhandler');

$s = time(); $m = floor($s/60); $h = floor($m/60); $rotate = floor($h/7); 

// REVISED - don't have all pages expire at the same time!
// EXPIRE pages 31 hours after they are visited.
header("Pragma: public");
header("Cache-Control: maxage=".(31*3600).",public");
header("Expires: " . gmdate("D, d M Y H:i:s", $s + (31*3600)) . " GMT");
?>
<?php echo '<?xml version="1.0" encoding="utf-8"?>'; ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="content-type" content="text/html;charset=utf-8" />
<meta http-equiv="Content-Style-Type" content="text/css" />

<meta name="robots" content="all" /><meta name="revisit" content="1 days" />

<meta name="description" content="Compare the performance of ~30 programming languages using ~12 flawed benchmarks and ~1100 programs. Contribute faster more elegant programs." />

<title>Computer Language Benchmarks Game</title>
<link rel="stylesheet" type="text/css" href="http://shootout.alioth.debian.org/benchmark_css_22dec2009.php" />
<link rel="shortcut icon" href="http://shootout.alioth.debian.org/favicon_ico_11dec2009.php" />
</head>

<body id="core">

<table class="banner"><tr>
<td><h1><a>The&nbsp;Computer&nbsp;<strong>Language</strong>&nbsp; <br/><strong>Benchmarks</strong>&nbsp;Game</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="http://shootout.alioth.debian.org/help.php" title="How to compare these programming language measurements. How programs were measured. How to contribute programs. FAQs">Help</a></h1></td>
</tr></table>


<?php

require_once('../lib/lib_whitelist.php');

function ReadA($FileName){
   $rows = array();
   $lines = file($FileName);
   unset($lines[0]); // remove header line
   foreach($lines as $s) {
      $row = explode( ',', $s);
      if (!is_array($row)){ continue; }
      $rows[ $row[0] ] = $row;
   }
   return $rows;
}

function Keys($sites){
   $siteKeys = array();
   foreach($sites as $s){
      $a = array_flip( array_keys( ReadA('http://shootout.alioth.debian.org/'.$s.'/include.csv') ));
      $akeys = array_keys($a);
      foreach($akeys as $k){ $a[$k] = $s; }
      $siteKeys[] = $a;
   }
   return $siteKeys;
}

function CompareLangName($b, $a){
   if (isset($a[LANG_FULL]) && isset($b[LANG_FULL])){
      return strcasecmp($a[LANG_FULL],$b[LANG_FULL]);
   } else {
      return 0;
   }
}

function PrintIncludedLanguages(&$sites,&$a,$notShown0 ){
   $link = $a[LANG_LINK];
   $notShown = $notShown0;
   foreach($sites as $keys){
      if (isset($keys[$link]) && !empty($link)){
         $notShown = FALSE;
         $tag = $a[LANG_TAG];
         $site = $keys[$link];

         if (isset($a[LANG_SPECIALURL]) && !empty($a[LANG_SPECIALURL])){ // special_url
             printf('<p><a href="./%s/%s.php" title="Compare %s performance against one other programming language">%s</a> <span class="smaller">%s</span></p>',
                $site, $a[LANG_SPECIALURL], $a[LANG_FULL], $a[LANG_HTML], $tag);
         } else {
             printf('<p><a href="./%s/benchmark.php?test=all&amp;lang=%s" title="Compare %s performance against one other programming language">%s</a> <span class="smaller">%s</span></p>',
                $site, $link, $a[LANG_FULL], $a[LANG_HTML], $tag);
         }

      }
   }
   return $notShown;
}

$Tests = ReadA('../desc/test.csv');
$Langs = ReadA('../desc/lang.csv');

$choices = array(
   array('u32','u64q'),
   array('u64q','u32'),
   array('u32q','u64q'),
   array('u64','u32'),
   array('u32q','u64'),
   array('u64','u32q'),
   array('u32','u64'),
   array('u64q','u32q')
   );

$nchoices = sizeof($choices);
$chosen = $choices[$rotate%$nchoices];
$a_list = Keys( array( $chosen[0] ));
$b_list = Keys( array( $chosen[1] ));


$testchoices = array(
   'fannkuch'
   ,'knucleotide'
   ,'mandelbrot'
   ,'nbody'
   ,'fasta'
   ,'spectralnorm'
   ,'threadring'
   ,'chameneosredux'
   ,'regexdna'
   ,'pidigits'
   ,'binarytrees'
   ,'revcomp'
   );
   
$nchoices = sizeof($testchoices);
$chosentest = $testchoices[$rotate%$nchoices];
$chosenTip = 'Fastest in each programming language to '.$Tests[$chosentest][4];
unset($Tests);

$siteTip = array(
   'u32' => ' on one core x86 Ubuntu'
   ,'u32q' =>' on quad-core x86 Ubuntu'
   ,'u64' =>' on one core x64 Ubuntu'
   ,'u64q' =>' on quad-core x64 Ubuntu'
   );
$chosenSiteTip = $siteTip[$chosen[1]];


$pagechoices = array(
   array(
      '/which-programming-languages-are-fastest.php'
      ,'Which programming languages have the fastest benchmark programs'.$chosenSiteTip.'?')
   ,array(
      '/benchmark.php?test='.$chosentest.'&amp;lang=all'
      ,$chosenTip.$chosenSiteTip)
   ,array(
      '/which-programming-languages-are-fastest.php'
      ,'Which programming languages have the fastest benchmark programs'.$chosenSiteTip.'?')
   ,array(
      '/code-used-time-used-shapes.php'
      ,'Look for patterns in Code-used Time-used Shapes'.$chosenSiteTip)
   ,array(
      '/which-programming-languages-are-fastest.php'
      ,'Which programming languages have the fastest benchmark programs'.$chosenSiteTip.'?')
   ,array(
      '/benchmark.php?test='.$chosentest.'&amp;lang=all'
      ,$chosenTip.$chosenSiteTip)
   );

$nchoices = sizeof($pagechoices);
$chosenpage = $pagechoices[$rotate%$nchoices];
$ChosenSite = $chosen[1];
$ChosenUrl = $chosenpage[0];
$ChosenTip = $chosenpage[1];
?>



<div id="home">
<h5><strong>Compare the performance of &asymp;30 programming languages</strong> <br/>using &asymp;12 <strong>flawed benchmarks</strong> and &asymp;1100 programs</h5>
<p><br/>Read the source code. Contribute faster more elegant programs.</p>
<p><a href="./<?=$ChosenSite;?><?=$ChosenUrl;?>" title="<?=$ChosenTip;?>"><strong>Compare performance</strong></a> on both 32 bit and 64 bit Ubuntu&#8482;.</p>
<p>Compare performance both when programs are allowed to use <br/>quad-core and when programs are forced to use one core.</p>



<h5><br/><strong>Programming language performance comparisons</strong> Z to A</h5><br/>


<?php
foreach($Langs as $a){
   $notShown = PrintIncludedLanguages($a_list,$a,TRUE);
   if ($notShown){ $notShown = PrintIncludedLanguages($b_list,$a,$notShown); }
}
?>



<p class="imgfooter">
<a href="http://shootout.alioth.debian.org/license.php" title="The Computer Language Benchmarks Game is published under this revised BSD license" >
   <img src="http://shootout.alioth.debian.org/open_source_button_png_11dec2009.php" alt="Revised BSD license" height="31" width="88" />
</a>
</p>
<p class="imgfooter">&nbsp; <a href="http://shootout.alioth.debian.org/flawed-benchmarks.php">Flawed</a> &nbsp; <a href="http://shootout.alioth.debian.org/which-programming-language-is-fastest.php">Fastest</a> &nbsp; <a href="http://shootout.alioth.debian.org/license.php">License</a> &nbsp; <a href="http://shootout.alioth.debian.org/help.php">Help</a> &nbsp;</p>

</div>

<? include_once('analyticstracking.php'); ?>
</body>
</html>
