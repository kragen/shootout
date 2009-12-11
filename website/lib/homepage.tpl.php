<?   // Copyright (c) Isaac Gouy 2004-2009 ?>
<?php 
// REVISED - don't have all pages expire at the same time!
// EXPIRE pages 8 hours after they are visited.
$s = time();
header("Pragma: public");
header("Cache-Control: maxage=".(8*3600));
header("Expires: " . gmdate("D, d M Y H:i:s", $s + (8*3600)) . " GMT");
?>
<?php echo '<?xml version="1.0" encoding="utf-8"?>'; ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="content-type" content="text/html;charset=utf-8" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<?=$Robots;?>

<title><?=$PageTitle;?></title>
<link rel="stylesheet" type="text/css" href="<?=IMAGE_PATH;?>benchmark.css" />
<link rel="shortcut icon" href="./favicon.ico" />
</head>

<body id="<?=SITE_NAME;?>">

<table class="banner"><tr>
<td><h1><a href="<?=$BannerUrl;?>"><?=$BannerTitle;?></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="<?=$FaqUrl;?>"><?=$FaqTitle;?></a></h1></td>
</tr></table>

<div id="nav">
<?=$PageBody;?>

<p class="img">
<a href="miscfile.php?file=license&amp;title=Revised BSD license" title="Software contributed to the Shootout is published under this revised BSD license" >
   <img src="<?=IMAGE_PATH;?>open_source_button.png" alt="Revised BSD license" height="31" width="88" /></a>
</p>
</div>
</body>
</html>
