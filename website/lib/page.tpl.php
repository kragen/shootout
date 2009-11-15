<?   // Copyright (c) Isaac Gouy 2004-2009 ?>
<?php // website content changes at-most once an hour - say ten past the hour
$m = floor(time()/60); $h = floor($m/60); $after_the_hour = $m - $h*60; $countdown = 10;
if ($countdown <= $after_the_hour) { $countdown += 60; $h++; }
header("Pragma: public");
header("Cache-Control: maxage=".($countdown - $after_the_hour)*60);
header("Expires: " . gmdate("D, d M Y H:i:s", $h*3600 + 600) . " GMT");
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
<link rel="stylesheet" type="text/css" href="<?=IMAGE_PATH;?>benchmark.css" />
<link rel="shortcut icon" href="./favicon.ico" />
</head>

<body id="<?=SITE_NAME;?>">
<table class="banner"><tr>
<td><h1><a href="<?=$BannerUrl;?>"><?=$BannerTitle;?></a>&nbsp;(<a href="<?=$FaqUrl;?>"><?=$FaqTitle;?></a>)</h1></td>
</tr></table>

<div id="<?=$PageId;?>">
<?=$PageBody;?>

<p class="imgfooter">
<a href="miscfile.php?file=license&amp;title=Revised BSD license" title="Software contributed to the Shootout is published under this revised BSD license" >
   <img src="<?=IMAGE_PATH;?>open_source_button.png" alt="Revised BSD license" height="31" width="88" />
</a>
</p>
</div>

<? include_once(IMAGE_PATH.'analyticstracking.php'); ?>
</body>
</html>
