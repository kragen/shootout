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
<br/>
<h5>Benchmarking programming languages?</h5>
<p>How can we benchmark a programming language?<br/>
We can't - we benchmark programming language implementations.</p>
<p>How can we benchmark language implementations?<br/>
We can't - <strong>we measure particular programs</strong>.</p><br/>


<table class="layout">
<tr class="test">
<th colspan="2">Rankings, Benchmarks, Programs</th>
</tr>
<tr class="test">
<td>
<p class="timestamp"><a href="./gp4/"><? printf('%s', gmdate("d M Y", $G)) ?></a></p>
<h3><span class="gp4">
<a title="Computer Language Benchmarks on Gentoo : Intel&#174; Pentium&#174;"
href="./gp4/">&nbsp;Gentoo&nbsp;:&nbsp;Intel&#174;&nbsp;Pentium&#174;&nbsp;4&nbsp;</a></span></h3>
</td>
<td>
<p class="timestamp"><a href="./debian/"><? printf('%s', gmdate("d M Y", $D)) ?></a></p>
<h3><span class="debian">
<a title="Computer Language Benchmarks on Debian : AMD&#8482; Sempron&#8482;"
href="./debian/">&nbsp;Debian&nbsp;:&nbsp;AMD&#8482;&nbsp;Sempron&#8482;&nbsp;</a></span></h3>
</td>
</tr>
<tr class="test">
<td>
<h3><span class="sandbox">
<a title="Extra languages on Gentoo : Intel&#174; Pentium&#174;"
href="./gp4sandbox/">&nbsp;Gentoo&nbsp;:&nbsp;Intel&#174;&nbsp;Pentium&#174;&nbsp;4&nbsp;</a></span></h3>
</td>
<td>
<h3><span class="sandbox">
<a title="Extra languages on Debian : AMD&#8482; Sempron&#8482;"
href="./sandbox/">&nbsp;Debian&nbsp;:&nbsp;AMD&#8482;&nbsp;Sempron&#8482;&nbsp;</a></span></h3>
</td>
</tr>
</table><br/>


<p class="imgfooter">
<a href="http://shootout.alioth.debian.org/gp4/miscfile.php?file=license&amp;title=Revised BSD license" title="Software contributed to The Computer Language Benchmarks Game is published under this revised BSD license" >
   <img src="./open_source_button.png" alt="Revised BSD license" height="31" width="88" />
</a>
</p>

</div>

<? $virtual_page="home"; include_once("analyticstracking.php") ?>
</body>
</html>
