<?   // Copyright (c) Isaac Gouy 2004, 2005 ?>

<?php      echo '<?xml version="1.0" encoding="iso-8859-1" ?>';      ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<?=$Robots;?>

<!-- Benchmarking programming languages -->
<meta name="keywords" content="benchmarking fast programming language benchmark performance benchmarks shootout program" />
<meta name="description" content="Compare programming language performance on a few dozen flawed benchmarks and contribute faster more elegant programs." />

<title><?=$PageTitle;?></title>
<link rel="stylesheet" type="text/css" href="<?=CORE_SITE;?>benchmark.css" />
<link href="<?=CORE_SITE;?>/feeds/rss.xml" rel="alternate" type="application/rss+xml" title="Computer Language Shootout" />
<style type="text/css" media="all">
   .hf, .rev, .arev, .arev:visited { background-color: <?=REV_COLOR;?>; }
   .arevCore { background-color: <?=REV_COLOR_CORE;?>; }
   .arevGreat { background-color: <?=REV_COLOR_GREAT;?>; }
   .arevSandbox { background-color: <?=REV_COLOR_SANDBOX;?>; }
   .arevOld { background-color: <?=REV_COLOR_OLD;?>; }   
   .arevGP4 { background-color: <?=REV_COLOR_GP4;?>; }
</style>
</head>

<body>
<table class="hf"><tr>
<td><h2><?=$BannerTitle;?></h2></td>
<td class="hftag"><a class="arev" href="faq.php" ><?=$FaqTitle;?></a></td>
</tr></table>

<?=$PageBody;?>
<br/>
<p class="center">
<a href="miscfile.php?file=license&amp;title=Revised BSD license" title="Software contributed to the Shootout is published under this revised BSD license" >
   <img src="<?=IMAGE_PATH;?>open_source_button.png" alt="Revised BSD license" height="31" width="88" />
</a>

<a href="http://jigsaw.w3.org/css-validator/">
   <img src="<?=IMAGE_PATH;?>vcss.png" alt="Valid CSS!" height="31" width="88" />
</a>

<a href="http://validator.w3.org/check?uri=referer">
   <img src="<?=IMAGE_PATH;?>valid-xhtml10.png" alt="Valid XHTML 1.0!" height="31" width="88" />
</a>

<a href="http://feedvalidator.org/">
   <img src="<?=IMAGE_PATH;?>valid-rss.png" alt="Valid RSS" title="Valid RSS" /></a>
</p>

</body>
</html>