<?   // Copyright (c) Isaac Gouy 2009 ?>

<?
if (SITE_NAME == 'gp4' || SITE_NAME == 'debian'){
   printf('<p><strong>&nbsp;Please choose the <a href="faq.php#means">up-to-date measurements</a>!</strong><br/></p>');
}
?>

<h2>&nbsp;<?= $Title." [".$Mark."]" ?></h2>

<?
echo '<pre>name,lang,id,n,size(B),cpu(s),mem(KB),status,load,elapsed(s) [', $Mark, "]\n";
foreach($Data as $d){
   echo implode(',', $d), "\n";
}
echo '</pre>';
?>


