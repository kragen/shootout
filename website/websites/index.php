<?php 
ob_start('ob_gzhandler');

$s = time(); $m = floor($s/60); $h = floor($m/60); $rotate = floor($h/36); 

// REVISED - don't have all pages expire at the same time!
// EXPIRE pages 16 hours after they are visited.
header("Pragma: public");
header("Cache-Control: maxage=".(16*3600).",public");
header("Expires: " . gmdate("D, d M Y H:i:s", $s + (16*3600)) . " GMT");
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
<link rel="stylesheet" type="text/css" href="http://shootout.alioth.debian.org/benchmark_css_13dec2009.php" />
<link rel="shortcut icon" href="http://shootout.alioth.debian.org/favicon_ico_11dec2009.php" />
</head>

<body id="core">

<?
$choices = array(
   array('u32q/','which-languages-are-fastest.php','Which programming languages have the fastest benchmark programs on quad-core Ubuntu?'),
   array('u64q/','code-used-time-used-shapes.php','Look for patterns in Code-used Time-used Shapes on quad-core x64 Ubuntu'),
   array('u32/','which-language-is-best.php','Compare programming language performance using your choice of benchmarks and Time-used Memory-used Code-used weights'),
   array('','which-programming-language-is-fastest.php.php','Which programming language has the fastest benchmark programs on Q6600 Ubuntu?'),

   array('u64/','which-languages-are-fastest.php','Which programming languages have the fastest benchmark programs on one-core x64 Ubuntu?'),
   array('u32q/','code-used-time-used-shapes.php','Look for patterns in Code-used Time-used Shapes on quad-core Ubuntu'),
   array('u64q/','which-language-is-best.php','Compare programming language performance using your choice of benchmarks and Time-used Memory-used Code-used weights'),
   array('','which-programming-language-is-fastest.php.php','Which programming language has the fastest benchmark programs on Q6600 Ubuntu?'),

   array('u32/','which-languages-are-fastest.php','Which programming languages have the fastest benchmark programs on one-core Ubuntu?'),
   array('u64/','code-used-time-used-shapes.php','Look for patterns in Code-used Time-used Shapes on one-core x64 Ubuntu'),
   array('u32q/','which-language-is-best.php','Compare programming language performance using your choice of benchmarks and Time-used Memory-used Code-used weights'),
   array('','which-programming-language-is-fastest.php.php','Which programming language has the fastest benchmark programs on Q6600 Ubuntu?'),

   array('u64q/','which-languages-are-fastest.php','Which programming languages have the fastest benchmark programs on quad-core x64 Ubuntu?'),
   array('u32/','code-used-time-used-shapes.php','Look for patterns in Code-used Time-used Shapes on one-core Ubuntu'),
   array('u64/','which-language-is-best.php','Compare programming language performance using your choice of benchmarks and Time-used Memory-used Code-used weights'),
   array('','which-programming-language-is-fastest.php.php','Which programming language has the fastest benchmark programs on Q6600 Ubuntu?')
   );

$nchoices = sizeof($choices);
$chosen = $choices[$rotate%$nchoices];
$ChosenSite = $chosen[0];
$ChosenUrl = $chosen[1];
$ChosenTip = $chosen[2];
?>


<table class="banner"><tr>
<td><h1><a>The&nbsp;Computer&nbsp;<strong>Language</strong>&nbsp; <br/><strong>Benchmarks</strong>&nbsp;Game</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="http://shootout.alioth.debian.org/help.php" title="How to compare programming languages. How to contribute programs. How programs were measured.">Help</a></h1></td>
</tr></table>

<div id="home">
<h5><strong>Benchmarking programming languages</strong>?</h5>
<p>How can we benchmark a programming language?<br/>
We can't - we benchmark programming language implementations.</p>
<p>How can we benchmark language implementations?<br/>
We can't - <strong>we measure particular programs</strong>.</p><br/>

<h5><a href="http://shootout.alioth.debian.org/<?=$ChosenSite;?><?=$ChosenUrl;?>" title="<?=$ChosenTip;?>"><strong>Which programming languages have the fastest programs?</strong></a></h5><br/>

<p>There are 4 sets of up-to-date measurements. Click one of these <br/>color-coded links to see one benchmark for a particular OS/machine -</p>

<?
$choices = array(
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

$nchoices = sizeof($choices);
$k = $rotate%$nchoices;

$u32qChosen = $choices[$k];
$u64qChosen = $choices[($k+3)%$nchoices];
$u64Chosen = $choices[($k+6)%$nchoices];
$u32Chosen = $choices[($k+9)%$nchoices];

require_once('../lib/lib_whitelist.php');

function ReadA($FileName){
   $f = @fopen($FileName,'r') or die('Cannot open '.$FileName);
   $row = @fgetcsv($f,1024,',');
   while (!@feof ($f)){
      $row = @fgetcsv($f,1024,',');
      if (!is_array($row)){ continue; }
      $rows[ $row[0] ] = $row;
   }
   @fclose($f);
   return $rows;
}

$Tests = ReadA('../desc/test.csv');
$u32qChosenTip = 'Fastest in each programming language to '.$Tests[$u32qChosen][4];
$u64qChosenTip = 'Fastest in each programming language to '.$Tests[$u64qChosen][4];
$u64ChosenTip = 'Fastest in each programming language to '.$Tests[$u64Chosen][4];
$u32ChosenTip = 'Fastest in each programming language to '.$Tests[$u32Chosen][4];
unset($Tests);
?>


<table class="layout">
<tr class="test">
<td>
<p class="timestamp"><a title="<?=$u32qChosenTip?>" href="http://shootout.alioth.debian.org/u32q/benchmark.php?test=<?=$u32qChosen?>&amp;lang=all"><? printf('%s', gmdate("d M Y", filemtime('./u32q/data/data.csv'))) ?></a></p>
<h3><span class="u32q">
<a title="<?=$u32qChosenTip?>"
href="http://shootout.alioth.debian.org/u32q/benchmark.php?test=<?=$u32qChosen?>&amp;lang=all">&nbsp;Ubuntu&#8482;&nbsp;:&nbsp;Intel&#174;&nbsp;Q6600&#174;&nbsp;quad-core&nbsp;</a></span></h3>
</td>
</tr>
</table>

<table class="layout">
<tr class="test">
<td>
<p class="timestamp"><a title="<?=$u64qChosenTip?>" href="http://shootout.alioth.debian.org/u64q/benchmark.php?test=<?=$u64qChosen?>&amp;lang=all"><? printf('%s', gmdate("d M Y", filemtime('./u64q/data/data.csv'))) ?></a></p>
<h3><span class="u64q">
<a title="<?=$u64qChosenTip?>"
href="http://shootout.alioth.debian.org/u64q/benchmark.php?test=<?=$u64qChosen?>&amp;lang=all">&nbsp;x64&nbsp;Ubuntu&#8482;&nbsp;:&nbsp;Intel&#174;&nbsp;Q6600&#174;&nbsp;quad-core&nbsp;</a></span></h3>
</td>
</tr>
</table>


<table class="layout">
<tr class="test">
<td>
<p class="timestamp"><a title="<?=$u64ChosenTip?>" href="http://shootout.alioth.debian.org/u64/benchmark.php?test=<?=$u64Chosen?>&amp;lang=all"><? printf('%s', gmdate("d M Y", filemtime('./u64/data/data.csv'))) ?></a></p>
<h3><span class="u64q">
<a title="<?=$u64ChosenTip?>" href="http://shootout.alioth.debian.org/u64/benchmark.php?test=<?=$u64Chosen?>&amp;lang=all">&nbsp;x64&nbsp;Ubuntu&#8482;&nbsp;:&nbsp;Intel&#174;&nbsp;Q6600&#174;&nbsp;one&nbsp;core&nbsp;</a></span></h3>
</td>
</tr>
</table>

<table class="layout">
<tr class="test">
<td>
<p class="timestamp"><a title="<?=$u32ChosenTip?>" href="http://shootout.alioth.debian.org/u32/benchmark.php?test=<?=$u32Chosen?>&amp;lang=all"><? printf('%s', gmdate("d M Y", filemtime('./u32/data/data.csv'))) ?></a></p>
<h3><span class="u32">
<a title="<?=$u32ChosenTip?>" href="http://shootout.alioth.debian.org/u32/benchmark.php?test=<?=$u32Chosen?>&amp;lang=all">&nbsp;Ubuntu&#8482;&nbsp;:&nbsp;Intel&#174;&nbsp;Q6600&#174;&nbsp;one&nbsp;core&nbsp;</a></span></h3>
</td>
</tr>
</table>


<h5><br/><strong>Programming language comparisons</strong> Z to A</h5><br/>


<?php

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
   $showTag = TRUE;
   foreach($sites as $keys){
      if (isset($keys[$link]) && !empty($link)){
         $notShown = FALSE;
         $notShownYet =$showTag;
         if ($showTag) {
            $tag = $a[LANG_TAG];
            $showTag = FALSE;
         } else { $tag = ''; }

         if ($notShownYet){

            $arch = '';
            $site = $keys[$link];
            if ($site == 'debian'){ $arch = '<em>Debian</em>'; }
            elseif ($site == 'gp4'){ $arch = '<em>Gentoo</em>'; }

            if (isset($a[LANG_SPECIALURL]) && !empty($a[LANG_SPECIALURL])){ // special_url
                printf('<p><a href="http://shootout.alioth.debian.org/%s/%s.php" title="Compare %s against one other language implementation">%s</a> <span class="smaller">%s %s</span></p>',
                   $site, $a[LANG_SPECIALURL], $a[LANG_FULL], $a[LANG_HTML], $tag, $arch);
            } else {
                printf('<p><a href="http://shootout.alioth.debian.org/%s/benchmark.php?test=all&amp;lang=%s" title="Compare %s against one other language implementation">%s</a> <span class="smaller">%s %s</span></p>',
                   $site, $link, $a[LANG_FULL], $a[LANG_HTML], $tag, $arch);
            }

         }
      }
   }
   return $notShown;
}

$Langs = ReadA('../desc/lang.csv');
uasort($Langs, 'CompareLangName');

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

foreach($Langs as $a){
   $notShown = PrintIncludedLanguages($a_list,$a,TRUE);
   if ($notShown){ $notShown = PrintIncludedLanguages($b_list,$a,$notShown); }
//   if ($notShown){ $notShown = PrintIncludedLanguages($u32,$a,$notShown); }
}
?>



<p class="imgfooter">
<a href="http://shootout.alioth.debian.org/license.php" title="The Computer Language Benchmarks Game is published under this revised BSD license" >
   <img src="http://shootout.alioth.debian.org/open_source_button_png_11dec2009.php" alt="Revised BSD license" height="31" width="88" />
</a>
</p>

</div>

</body>
</html>
