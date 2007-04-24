<?php
echo '<?xml version="1.0" encoding="iso-8859-1" ?>';      
$D = filemtime('../data/data.csv');
$G = filemtime('./gp4/data/data.csv');
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
<td><h1><a>The&nbsp;Computer&nbsp;Language&nbsp; <br/>Benchmarks&nbsp;Game</a></h1></td>
<td><a href="./feeds/rss.xml"><img src="./orangexml.gif" alt="Really Simple Syndication" title="Really Simple Syndication" /></a></td>
</tr></table>

<div id="home">

<p>It can be fun to watch the Benchmarks Game<br/> but like other games <a href="./gp4/faq.php#play">it's more fun to <strong>play</strong>!</a></p>

<h5>Benchmarking programming languages?</h5>
<p>How can we benchmark a programming language?<br/>
We can't - we benchmark programming language implementations.</p>
<p>How can we benchmark language implementations?<br/>
We can't - <strong>we measure particular programs</strong>.</p><br/>


<table class="layout">
<tr>
<td>
<p class="timestamp"><a href="./gp4/"><? printf('%s', gmdate("d M Y", $G)) ?></a></p>
<h3><span class="gp4">
<a title="Browse the Gentoo : Intel&#174; Pentium&#174; Computer Language Benchmarks"
href="./gp4/">&nbsp;Gentoo&nbsp;:&nbsp;Intel&#174;&nbsp;Pentium&#174;&nbsp;4&nbsp;</a></span></h3>
</td>
<td>
<p class="timestamp"><a href="./debian/"><? printf('%s', gmdate("d M Y", $D)) ?></a></p>
<h3><span class="debian">
<a title="Browse the Debian : AMD&#8482; Sempron&#8482; Computer Language Benchmarks"
href="./debian/">&nbsp;Debian&nbsp;:&nbsp;AMD&#8482;&nbsp;Sempron&#8482;&nbsp;</a></span></h3>
</td>
</tr>
<tr>
<td>
<p class="timestamp"><a href="./gp4sandbox/"><? printf('%s', gmdate("d M Y", $G)) ?></a></p>
<h3><span class="sandbox">
<a title="Extra languages on Gentoo : Intel&#174; Pentium&#174;"
href="./gp4sandbox/">&nbsp;Gentoo&nbsp;:&nbsp;Intel&#174;&nbsp;Pentium&#174;&nbsp;4&nbsp;</a></span></h3>
</td>
<td>
<p class="timestamp"><a href="./sandbox/"><? printf('%s', gmdate("d M Y", $D)) ?></a></p>
<h3><span class="sandbox">
<a title="Extra languages on Debian : AMD&#8482; Sempron&#8482;"
href="./sandbox/">&nbsp;Debian&nbsp;:&nbsp;AMD&#8482;&nbsp;Sempron&#8482;&nbsp;</a></span></h3>
</td>
</tr>
</table><br/>


<?php
$Now = time()/(3600 * 5);

switch ($Now % 32){
   case 0: $S = 'debian'; $T = 'nsieve&amp;lang=all'; break;
   case 1: $S = 'gp4'; $T = 'chameneos&amp;lang=all'; break;
   case 2: $S = 'debian'; $T = 'message&amp;lang=all'; break;
   case 3: $S = 'gp4'; $T = 'fannkuch&amp;lang=all'; break;
   case 4: $S = 'debian'; $T = 'fasta&amp;lang=all'; break;
   case 5: $S = 'gp4'; $T = 'knucleotide&amp;lang=all'; break;
   case 6: $S = 'debian'; $T = 'mandelbrot&amp;lang=all'; break;
   case 7: $S = 'gp4'; $T = 'nbody&lang=ooc&id=0'; break;
   case 8: $S = 'debian'; $T = 'binarytrees&amp;lang=all'; break;
   case 9: $S = 'gp4'; $T = 'nsievebits&amp;lang=all'; break;
   case 10: $S = 'debian'; $T = 'partialsums&amp;lang=all'; break;
   case 11: $S = 'gp4sandbox'; $T = 'pidigits&amp;lang=ghc&id=0'; break;
   case 12: $S = 'debian'; $T = 'recursive&amp;lang=all'; break;
   case 13: $S = 'sandbox'; $T = 'regexdna&amp;lang=all'; break;
   case 14: $S = 'debian'; $T = 'revcomp&amp;lang=all'; break;
   case 15: $S = 'gp4'; $T = 'spectralnorm&amp;lang=sbcl&id=0'; break;
   case 16: $S = 'gp4'; $T = 'nsieve&amp;lang=gnat&id=0'; break;
   case 17: $S = 'debian'; $T = 'chameneos&amp;lang=all'; break;
   case 18: $S = 'gp4'; $T = 'message&amp;lang=hipe&id=2'; break;
   case 19: $S = 'debian'; $T = 'fannkuch&amp;lang=all'; break;
   case 20: $S = 'gp4'; $T = 'fasta&amp;lang=all'; break;
   case 21: $S = 'debian'; $T = 'knucleotide&amp;lang=all'; break;
   case 22: $S = 'gp4'; $T = 'mandelbrot&amp;lang=all'; break;
   case 23: $S = 'debian'; $T = 'nbody&amp;lang=all'; break;
   case 24: $S = 'gp4'; $T = 'binarytrees&amp;lang=mlton&id=2'; break;
   case 25: $S = 'debian'; $T = 'nsievebits&amp;lang=all'; break;
   case 26: $S = 'gp4'; $T = 'partialsums&amp;lang=bigforth&id=0'; break;
   case 27: $S = 'sandbox'; $T = 'pidigits&amp;lang=all'; break;
   case 28: $S = 'gp4'; $T = 'recursive&amp;lang=lua&id=0'; break;
   case 29: $S = 'gp4sandbox'; $T = 'regexdna&amp;lang=tcl&id=2'; break;
   case 30: $S = 'gp4'; $T = 'revcomp&amp;lang=gpp&id=3'; break;
   case 31: $S = 'debian'; $T = 'spectralnorm&amp;lang=all'; break;
}

$A = './'.$S.'/benchmark.php?test='.$T;

switch ($Now % 20){
   case 0: $L = 'zh0'; $R = 'zi0'; break;
   case 1: $L = 'zt1'; $R = 'zb2'; break;
   case 2: $L = 'zh6'; $R = 'zi4'; break;
   case 3: $L = 'zi2'; $R = 'zv3'; break;
   case 4: $L = 'zh2'; $R = 'zb4'; break;
   case 5: $L = 'zi6'; $R = 'zh4'; break;
   case 6: $L = 'zt6'; $R = 'zv1'; break;
   case 7: $L = 'zh7'; $R = 'zt7'; break;
   case 8: $L = 'zh8'; $R = 'zb8'; break;
   case 9: $L = 'zt9'; $R = 'zv8'; break;
   
   case 10: $L = 'zh9'; $R = 'zi9'; break;
   case 11: $L = 'zh4'; $R = 'zb9'; break;
   case 12: $L = 'zt5'; $R = 'zh0'; break;
   case 13: $L = 'zi7'; $R = 'zv9'; break;
   case 14: $L = 'zi1'; $R = 'zh8'; break;
   case 15: $L = 'zv7'; $R = 'zt4'; break;
   case 16: $L = 'zv5'; $R = 'zt7'; break;
   case 17: $L = 'zh1'; $R = 'zb9'; break;
   case 18: $L = 'zi8'; $R = 'zh9'; break;
   case 19: $L = 'zv2'; $R = 'zt2'; break;
}
?>

<p><a href="<?=$A;?>" title="Browse the Programs and CPU times" ><strong>Programs, CPU times, Benchmarks</strong></a></p>
<p style="white-space: nowrap">
<a href="<?=$A;?>">
   <img src="<?='./'.$L.'.png';?>" alt="Browse the Programs and CPU times" height="150" width="200" />
   <img src="<?='./'.$R.'.png';?>" alt="Browse the Programs and CPU times" height="150" width="200" />
</a>
</p><br/>

<p class="imgfooter">
<a href="http://shootout.alioth.debian.org/gp4/miscfile.php?file=license&amp;title=Revised BSD license" title="Software contributed to The Computer Language Benchmarks Game is published under this revised BSD license" >
   <img src="./open_source_button.png" alt="Revised BSD license" height="31" width="88" />
</a>
</p>

</div>

<? $virtual_page="home"; include_once("analyticstracking.php") ?>
</body>
</html>
