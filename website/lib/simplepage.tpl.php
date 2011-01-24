<?php echo '<?xml version="1.0" encoding="utf-8"?>'; ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="content-type" content="text/html;charset=utf-8" />
<meta http-equiv="Content-Style-Type" content="text/css" />

<?=$Robots;?>
<?=$MetaKeywords;?>

<title><?=$PageTitle;?></title>
<link rel="stylesheet" type="text/css" href="<?=IMAGE_PATH;?>benchmark_simple.css" />
</head>

<body id="<?=SITE_NAME;?>">

<h1><a href="<?=$BannerUrl;?>">The Computer Language Benchmarks Game</a></h1>
<div id="<?=$PageId;?>">
<?=$PageBody;?>
</div>
</body>
</html>
