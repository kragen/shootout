<?   // Copyright (c) Isaac Gouy 2004-2009 ?>
<?php 
ini_set('zlib.output_compression',8192);

// REVISED - don't have all pages expire at the same time!
// EXPIRE pages 8 hours after they are visited.
$s = time();
header("Pragma: public");
header("Cache-Control: maxage=".(8*3600).",public");
header("Expires: " . gmdate("D, d M Y H:i:s", $s + (8*3600)) . " GMT");
?>
<?php echo '<?xml version="1.0" encoding="utf-8"?>'; ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="content-type" content="text/html;charset=utf-8" />
<meta http-equiv="Content-Style-Type" content="text/css" />

<?=$Robots;?>
<?=$MetaKeywords;?>

<title><?=$PageTitle;?></title>
<link rel="stylesheet" type="text/css" href="<?=IMAGE_PATH;?>benchmark_css_10dec2009.php" />
<link rel="shortcut icon" href="./favicon_ico_11dec2009.php" />
</head>

<body id="<?=SITE_NAME;?>">
<table class="banner"><tr>
<td><h1><a href="<?=$BannerUrl;?>"><?=$BannerTitle;?></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="<?=$FaqUrl;?>"><?=$FaqTitle;?></a></h1></td>
</tr></table>

<div id="<?=$PageId;?>">
<?=$PageBody;?>

<p class="imgfooter">
<a href="miscfile.php?file=license&amp;title=Revised BSD license" title="Software contributed to the Shootout is published under this revised BSD license" >
   <img src="<?=IMAGE_PATH;?>open_source_button_png_11dec2009.php" alt="Revised BSD license" height="31" width="88" />
</a>
</p>
</div>

<? include_once(IMAGE_PATH.'analyticstracking.php'); ?>
</body>
</html>
