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

<table class="banner"><tr>
<td><h1><a>The&nbsp;Computer&nbsp;<strong>Language</strong>&nbsp; <br/><strong>Benchmarks</strong>&nbsp;Game</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="http://shootout.alioth.debian.org/help.php" title="How to compare programming languages. How to contribute programs. How programs were measured.">Help</a></h1></td>
</tr></table>

<div id="home">
<h5><strong>Compare the performance of ~30 programming languages</strong> using ~12 flawed benchmarks and ~1100 programs</h5><br/>
<p>Read the source code. Contribute faster more elegant programs.</p>
<p>Compare performance on both 32 bit and 64 bit Ubuntu&#8482;.</p>
<p>Compare performance both when programs are allowed to use quad-core and when programs are forced to use one-core.</p>



<h5><br/><strong>Programming language performance comparisons</strong> Z to A</h5><br/>

<?php

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

<? include_once('analyticstracking.php'); ?>
</body>
</html>
