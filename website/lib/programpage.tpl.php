<?   // Copyright (c) Isaac Gouy 2004 ?>

<?      echo '<?xml version="1.0" encoding="iso-8859-1" ?>';      ?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta name="robots" content="all" />
<meta name="revisit" content="10 days" />

<title><?=$PageTitle;?></title>
<style type="text/css" media="all">
   @import "<?=CSS_PATH.$SelectedLang;?>.css";
   @import "benchmark.css";
</style>
</head>

<body>
<table class="hf"><tr><td>
<h2><a class="arev" href="index.php?sort=<?=$Sort;?>"><?=$BannerTitle;?></a>
<h2></td><td class="hftag"><a class="arev" href="faq.php?sort=<?=$Sort;?>"><?=$FaqTitle;?> </a>
</td></tr></table>

<?=$PageBody;?>

<form><input type="hidden" name="sort" value="<?=$Sort;?>"/></form>
<div class="center"><p><a href="miscfile.php?sort=<?=$Sort;?>&file=license&title=revised BSD license">revised&nbsp;BSD&nbsp;license</a> | <b>Hosted</b>&nbsp;by&nbsp;<a href="http://alioth.debian.org/">Alioth&nbsp;Debian.org</a></p></div>
</body>
</html>