<?   // Copyright (c) Isaac Gouy 2004-2009 ?>
<?php echo '<?xml version="1.0" encoding="utf-8"?>'; ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="content-type" content="text/html;charset=utf-8" />
<meta http-equiv="Content-Style-Type" content="text/css" />

<?=$Robots;?>
<?=$MetaKeywords;?>

<title><?=$PageTitle;?></title>
<link rel="shortcut icon" href="./favicon.ico" />
<style type="text/css" media="all">
   @import "<?=IMAGE_PATH;?>highlight.css";
   @import "<?=IMAGE_PATH;?>benchmark.css";
</style>
</head>

<body id="<?=SITE_NAME;?>">
<table class="banner"><tr>
<td><h1><a href="index.php"><?=$BannerTitle;?></a>&nbsp;(<a href="faq.php"><?=$FaqTitle;?></a>)</h1></td>
</tr></table>

<div id="<?=$PageId;?>">
<?=$PageBody;?>

<p class="imgfooter">
<a href="miscfile.php?sort=<?=$Sort;?>&amp;file=license&amp;title=Revised BSD license" title="Software contributed to the Shootout is published under this revised BSD license" >
   <img src="<?=IMAGE_PATH;?>open_source_button.png" alt="Revised BSD license" height="31" width="88" />
</a>
</p>
</div>

<? include_once(IMAGE_PATH.'analyticstracking.php'); ?>
</body>
</html>
