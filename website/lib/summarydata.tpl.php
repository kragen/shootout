<?   // Copyright (c) Isaac Gouy 2009-2010 ?>

<h2>&nbsp;<?= $Title." [".$Mark."]" ?></h2>

<?
echo '<p>name,lang,id,n,size(B),cpu(s),mem(KB),status,load,elapsed(s) [', $Mark, "]<br/>";

foreach($Data as $i => $row){
   $row[DATA_TEST] = $Tests[ $row[DATA_TEST] ][TEST_NAME];
   $row[DATA_LANG] = $Langs[ $row[DATA_LANG] ][LANG_FULL];
   echo implode(',', $row),'<br/>';
}
echo '</p>';
?>