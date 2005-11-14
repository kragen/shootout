<?   // Copyright (c) Isaac Gouy 2004, 2005 ?>
<?      echo '<?xml version="1.0" encoding="iso-8859-1" ?>';      ?>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<?=$Robots;?>
<?=$MetaKeywords;?>

<title><?=$PageTitle;?></title>
<style type="text/css" media="all">
   @import "<?=CORE_SITE;?>highlight.css";
   @import "<?=CORE_SITE;?>benchmark.css";
   .hf, .rev, .arev, .arev:visited { background-color: <?=REV_COLOR;?>; }
   .arevCore { background-color: <?=REV_COLOR_CORE;?>; }
   .arevGreat { background-color: <?=REV_COLOR_GREAT;?>; }
   .arevSandbox { background-color: <?=REV_COLOR_SANDBOX;?>; }  
   .arevOld { background-color: <?=REV_COLOR_OLD;?>; }
   .arevGP4 { background-color: <?=REV_COLOR_GP4;?>; }
   .arevContests { background-color: <?=REV_COLOR_CONTESTS;?>; }   
</style>
</head>

<body>
<table class="hf"><tr>
<td>
<h2><a class="arev" href="index.php" ><?=$BannerTitle;?></a></h2></td>
<td class="hftag"><a class="arev" href="faq.php" ><?=$FaqTitle;?> </a>
</td>
</tr></table>

<?=$PageBody;?>

<p class="center">
<a href="miscfile.php?sort=<?=$Sort;?>&amp;file=license&amp;title=Revised BSD license" title="Software contributed to the Shootout is published under this revised BSD license" >
   <img src="<?=IMAGE_PATH;?>open_source_button.png" alt="Revised BSD license" height="31" width="88" />
</a>

<a href="http://jigsaw.w3.org/css-validator/">
   <img src="<?=IMAGE_PATH;?>vcss.png" alt="Valid CSS!" height="31" width="88" />
</a>

<a href="http://validator.w3.org/check?uri=referer">
   <img src="<?=IMAGE_PATH;?>valid-xhtml10.png" alt="Valid XHTML 1.0!" height="31" width="88" />
</a>
</p>
</body>
</html>