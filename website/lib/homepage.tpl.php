<?   // Copyright (c) Isaac Gouy 2004 ?>

<?php      echo '<?xml version="1.0" encoding="iso-8859-1" ?>';      ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta name="robots" content="all" />
<meta name="revisit" content="10 days" />
<meta name="keywords" content="compare performance ranking computer program language benchmark shootout " />
<meta name="description" content="Compare the performance of 50 computer languages on each of 25 benchmark programs." />

<title><?=$PageTitle;?></title>
<link rel="stylesheet" type="text/css" href="benchmark.css" />
</head>


<body>
<table class="hf"><tr>
<td><h2><?=$BannerTitle;?></h2></td>
<td class="hftag"><a class="arev" href="faq.php?sort=<?=$Sort;?>"><?=$FaqTitle;?></a></td>
</tr></table>

<?=$PageBody;?>


<form><input type="hidden" name="sort" value="<?=$Sort;?>" /></form>
<div class="center"><p><a href="miscfile.php?sort=<?=$Sort;?>&file=license&title=revised BSD license">revised&nbsp;BSD&nbsp;license</a> | <b>Hosted</b>&nbsp;by&nbsp;<a href="http://alioth.debian.org/">Alioth&nbsp;Debian.org</a></p></div>
</body>
</html>