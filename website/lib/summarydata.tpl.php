<?   // Copyright (c) Isaac Gouy 2009 ?>

<?
if (SITE_NAME == 'gp4' || SITE_NAME == 'debian'){
   printf('<p><strong>&nbsp;PLEASE CHOOSE THE <a href="faq.php#means">UP-TO-DATE MEASUREMENTS</a> INSTEAD OF THESE!</strong><br/></p>');
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


