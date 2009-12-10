<?   // Copyright (c) Isaac Gouy 2004-2006 ?>

<? 
$Row = $Langs[$SelectedLang];
$LangName = $Row[LANG_FULL];
$LangTag = $Row[LANG_TAG];
$LangName2 = $Langs[$SelectedLang2][LANG_FULL];
$Link = $Row[LANG_LINK];
$Family = $Row[LANG_FAMILY];
?>

<p>For more information about a Timeout or Error click the program name and scroll-down to the "make, command line, and program output logs".</p>
<? MkHeadToHeadMenuForm($Tests,$SelectedTest,$Langs,$SelectedLang,$SelectedLang2,"fullcpu"); ?>
<h2><a href="#title" name="title">&nbsp;<?=$LangName;?> measurements</a></h2>

<table>
<colgroup span="1" class="txt"></colgroup>
<colgroup span="4" class="num"></colgroup>
<tr>
<th>Program&nbsp;Source&nbsp;Code</th>
<th><a href="help.php#nmeans">&nbsp;N&nbsp;</a></th>
<th><a href="help.php#measurecpu">CPU&nbsp;secs</a></th>
<th><a href="help.php#measurecpu">Elapsed&nbsp;secs</a></th>
<th><a href="help.php#memory">Memory&nbsp;KB</a></th>
<th><a href="help.php#gzbytes">Size&nbsp;B</a></th>
</tr>

<?
foreach($Data as $row){
   $test = $row[DATA_TEST];
   $id = $row[DATA_ID];
   $TestName = $Tests[$row[DATA_TEST]][TEST_NAME];

   $BAR = '';
   if (isset($prevTest)&&isset($prevId)){
      if ($test != $prevTest || $id != $prevId){ $BAR = ' class="bar"'; }
   }
   $prevTest = $test;
   $prevId = $id;

   printf('<tr><td %s><a href="benchmark.php?test=%s&amp;lang=%s&amp;id=%d" title="Read the Program Source Code : %s %s">%s&nbsp;%s</a></td>', $BAR,$test,$row[DATA_LANG],$id,$TestName,IdName($id),$TestName,IdName($id)); echo "\n";

   if ($row[DATA_TESTVALUE]==0){ $n = '?'; } else { $n = '&nbsp;'.number_format($row[DATA_TESTVALUE]); }

   if ($row[DATA_STATUS]<0){
      $kb = '&nbsp;'; $fullcpu = '&nbsp;';$elapsed = '&nbsp;'; $load = '&nbsp;';
      $fullcpu = StatusMessage($row[DATA_STATUS]);
   } else {
      if ($row[DATA_MEMORY]==0){
         $kb = '?';
      } else {
         if ($TestName=='startup'){ $kb = '&nbsp;'; }
         else { $kb = number_format((double)$row[DATA_MEMORY]); }
      }
      $fullcpu = number_format($row[DATA_FULLCPU],2);
      $elapsed = ElapsedTime($row);
   }

   printf('<td %s><span class="numN">%s</span></td><td %s>%s</td><td %s>%s</td><td %s>%s</td><td %s>%s</td></tr>', $BAR,$n, $BAR,$fullcpu, $BAR,$elapsed, $BAR,$kb, $BAR,$row[DATA_GZ]);
}
?>
</table>


<h3><a href="#about" name="about">&nbsp;<?=$LangName;?></a>&nbsp;:&nbsp;<?=$LangTag;?>&nbsp;</h3>
<p></p>
<?=$About;?>
