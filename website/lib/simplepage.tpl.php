<?php echo '<?xml version="1.0" encoding="utf-8"?>'; ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="content-type" content="text/html;charset=utf-8" />
<meta http-equiv="Content-Style-Type" content="text/css" />

<?=$Robots;?>
<?=$MetaKeywords;?>

<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0"/>
<meta name="HandheldFriendly" content="true" />


<title><?=$PageTitle;?></title>
<link rel="stylesheet" type="text/css" href="<?=IMAGE_PATH;?>benchmark_simple.css" />
</head>

<body id="<?=SITE_NAME;?>">

<h1>The Computer Language Benchmarks Game</h1>
<div id="<?=$PageId;?>">
<?=$PageBody;?>
</div>

<p>And please don't jump to conclusions! "The performance of a benchmark, even if it is derived from a real program, may not help to predict the performance of similar programs that have different hot spots."</p>

<p>&nbsp; <a href="http://shootout.alioth.debian.org/mobile/">Home</a> &nbsp; <a href="http://shootout.alioth.debian.org/mobile/which-programming-languages-are-fastest.php">Fastest</a> &nbsp; <a href="http://shootout.alioth.debian.org/mobile/license.php">License</a> &nbsp; <a href="http://shootout.alioth.debian.org/mobile/help.php">Help</a> &nbsp;</p>
</body>
</html>
