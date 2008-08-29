<?php
echo '<?xml version="1.0" encoding="iso-8859-1" ?>';      
$D = filemtime('./debian/data/data.csv');
$G = filemtime('./gp4/data/data.csv');
$U = filemtime('./u64q/data/data.csv');
?>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta name="robots" content="index,follow,archive" /><meta name="revisit" content="1 days" />

<meta name="keywords" content="benchmarking fast faster programming language benchmark performance benchmarks shootout program faster language compare comparison benchmarks game" />
<meta name="description" content="Compare programming language performance on a few dozen flawed benchmarks and contribute faster more elegant programs." />

<title>The Computer Language Benchmarks Game</title>
<link rel="stylesheet" type="text/css" href="./benchmark.css" />
<link href="./feeds/rss.xml" rel="alternate" type="application/rss+xml" title="Computer Language Shootout" />
<link rel="shortcut icon" href="./favicon.ico" />
</head>

<body id="core">
<table class="banner"><tr>
<td><h1><a>The&nbsp;Computer&nbsp;Language&nbsp; <br/>Benchmarks&nbsp;Game</a></h1></td><td><h4><a href="./gp4/faq.php">Read the FAQ!</a></h4></td><td>&nbsp;</td>
<td><a href="./feeds/rss.xml"><img src="./orangexml.gif" alt="Really Simple Syndication" title="Really Simple Syndication" /></a></td>
</tr></table>

<div id="home">
<h5>Benchmarking programming languages?</h5>
<p>How can we benchmark a programming language?<br/>
We can't - we benchmark programming language implementations.</p>
<p>How can we benchmark language implementations?<br/>
We can't - <strong>we measure particular programs</strong>.</p><br/>

<table class="layout">
<tr class="test">
<td>
<p class="timestamp"><a href="./u64q/"><? printf('%s', gmdate("d M Y", $U)) ?></a></p>
<p><a href="./u64q/"><strong>Benchmarks</strong> timed on:</a></p>
<h3><span class="u64q">
<a title="Computer Language Benchmarks on Ubuntu : Intel&#174; Q6600&#8482;"
href="./u64q/">&nbsp;x64&nbsp;Ubuntu&nbsp;:&nbsp;Intel&#174;&nbsp;Q6600&#174;&nbsp;</a></span></h3>
</td>
</tr>

<tr class="test">
<td>
<p class="timestamp"><a href="./gp4/">mid 2008</a></p>
<p><a href="./gp4/"><strong>Benchmarks</strong> timed on:</a></p>
<h3><span class="gp4">
<a title="Computer Language Benchmarks on Gentoo : Intel&#174; Pentium&#174;"
href="./gp4/">&nbsp;Gentoo&nbsp;:&nbsp;Intel&#174;&nbsp;Pentium&#174;&nbsp;4&nbsp;</a></span></h3>
</td>
<td>
<p class="timestamp"><a href="./debian/">late 2007</a></p>
<p><a href="./debian/"><strong>Benchmarks</strong> timed on:</a></p>
<h3><span class="debian">
<a title="Computer Language Benchmarks on Debian : AMD&#8482; Sempron&#8482;"
href="./debian/">&nbsp;Debian&nbsp;:&nbsp;AMD&#8482;&nbsp;Sempron&#8482;&nbsp;</a></span></h3>
</td>
</tr>
</table>


<h5><br/>Programming language measurements A to Z</h5><br/>

<?php // Don't use library functions, define what we need here

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
      $a = array_flip( array_keys( ReadA('./'.$s.'/include.csv') ));
      $akeys = array_keys($a);
      foreach($akeys as $k){ $a[$k] = $s; }
      $siteKeys[] = $a;
   }
   return $siteKeys;
}

function CompareLangName($a, $b){
   if (isset($a[3]) && isset($b[3])){
      return strcasecmp($a[3],$b[3]);
   } else {
      return 0;
   }
}

function PrintIncludedLanguages(&$sites,&$a,$notShown0 ){
   $link = $a[0];
   $notShown = $notShown0;
   $showTag = TRUE;
   foreach($sites as $keys){
      if (isset($keys[$link]) && !empty($link)){
         $notShown = FALSE;
         $notShownYet =$showTag;
         if ($showTag) {
            $tag = $a[5];
            $showTag = FALSE;
         } else { $tag = ''; }

         if ($notShownYet){

            $arch = '';
            $site = $keys[$link];
            if ($site == 'debian' || $site == 'sandbox'){ $arch = '<em>Debian</em>'; }

            if (isset($a[8]) && !empty($a[8])){ // special_url
                printf('<p><a href="./%s/%s.php">%s</a> <span class="smaller">%s %s</span></p>',
                   $site, $a[8], $a[4], $tag, $arch);
            } else {
                printf('<p><a href="./%s/benchmark.php?test=all&amp;lang=%s">%s</a> <span class="smaller">%s %s</span></p>',
                   $site, $link, $a[4], $tag, $arch);
            }

         }
      }
   }
   return $notShown;
}

$Langs = ReadA('../desc/lang.csv');
uasort($Langs, 'CompareLangName');

$gentoo = Keys( array( 'gp4' ));
$debian = Keys( array( 'debian' )); // Debian isn't being updated, only show languages not on Gentoo

foreach($Langs as $a){
   $notShown = PrintIncludedLanguages($gentoo,$a,TRUE);
   if ($notShown){ PrintIncludedLanguages($debian,$a,$notShown); }
}
?>

<p class="imgfooter">
<a href="http://shootout.alioth.debian.org/gp4/miscfile.php?file=license&amp;title=Revised BSD license" title="Software contributed to The Computer Language Benchmarks Game is published under this revised BSD license" >
   <img src="./open_source_button.png" alt="Revised BSD license" height="31" width="88" />
</a>
</p>

</div>

<? $virtual_page="home"; include_once("analyticstracking.php") ?>
</body>
</html>
