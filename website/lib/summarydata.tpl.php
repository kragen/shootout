<?   // Copyright (c) Isaac Gouy 2009 ?>

<h2>&nbsp;<?= $Title." [".$Mark."]" ?></h2>


<?

if (isset($Data)){
   echo '<pre>name,lang,id,n,size(B),cpu(s),mem(KB),status,load,elapsed(s) [', $Mark, "]\n";
   foreach($Data as $d){
      echo implode(',', $d), "\n";
   }
   echo '</pre>';
} else {
   echo '<p><br/><strong>&nbsp;Please choose <a href="faq.php#means">up-to-date measurements</a>.</strong></p>';
}
?>


