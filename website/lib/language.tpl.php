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
<th>Program Source Code</th>
<th><a href="help.php#measurecpu">Time&nbsp;secs</a></th>
<th><a href="help.php#memory">Memory&nbsp;KB</a></th>
<th><a href="help.php#gzbytes">Size B</a></th>
<th><a href="help.php#nmeans">&nbsp;N&nbsp;</a></th>
</tr>

<?
foreach($Data as $row){
   $test = $row[N_TEST];
   $id = $row[N_ID];
   $TestName = $Tests[$row[N_TEST]][TEST_NAME];

   $BAR = '';
   if (isset($prevTest)&&isset($prevId)){
      if ($test != $prevTest || $id != $prevId){ $BAR = ' class="bar"'; }
   } 
   $prevTest = $test;
   $prevId = $id;

   printf('<tr><td %s><a href="benchmark.php?test=%s&amp;lang=%s&amp;id=%d" title="Read the Program Source Code : %s %s">%s %s</a></td>',
      $BAR,$row[N_TEST],$row[N_LANG],$id,$TestName,IdName($id),$TestName,IdName($id)); echo "\n";

   if ($row[N_N]==0){ $n = '?'; } else { $n = '&nbsp;'.number_format($row[N_N]); }

   if ($row[N_EXCLUDE] >= 0){
      if ($test=='startup'){ $kb = '&nbsp;'; } 
      elseif ($row[N_MEMORY]==0){ $kb = '?'; } else { $kb = number_format((double)$row[N_MEMORY]); }

      printf('<td %s>%0.2f</td><td %s>%s</td><td %s>%s</td><td %s><span class="numN">%s</span></td>',
         $BAR,$row[N_FULLCPU], $BAR,$kb, $BAR,$row[N_GZ], $BAR,$n);

   } else {
      $message = StatusMessage($row[N_EXCLUDE]);
      printf('<td %s><span class="message">%s</span></td><td %s></td><td %s>%s</td><td %s><span class="numN">%s</span></td>', $BAR,$message, $BAR, $BAR,$row[N_GZ], $BAR,$n);
   }
   echo "</tr>\n";
}
?>
</table>


<h3><a href="#about" name="about">&nbsp;<?=$LangName;?></a>&nbsp;:&nbsp;<?=$LangTag;?>&nbsp;</h3>
<p></p>
<?=$About;?>
