<?   // Copyright (c) Isaac Gouy 2004-2006 ?>

<? 
$Row = $Langs[$SelectedLang];
$LangName = $Row[LANG_FULL];
$LangTag = $Row[LANG_TAG];
?>

<? MkLangsMenuForm($Langs,$SelectedLang); ?>

<h2><a href="#title" name="title">&nbsp;<strong><?=$LangName;?> measurements</strong></a></h2>

<p>This table shows 4 <em>measurements</em> - <a href="<?=CORE_SITE;?>help.php#time" title="? Help">CPU&nbsp;Time</a>, <a href="<?=CORE_SITE;?>help.php#time" title="? Help">Elapsed&nbsp;Time</a>, <a href="<?=CORE_SITE;?>help.php#memory" title="? Help">Memory</a> and <a href="<?=CORE_SITE;?>help.php#gzbytes" title="? Help">Code</a>.</p>

<p>Each row shows those measurements for a particular <?=$LangName;?> program with a particular <a href="<?=CORE_SITE;?>help.php#inputvalue" title="? Help">command-line input value N</a>.</p>

<p>This table shows <b>all the accepted <strong><?=$LangName;?></strong> programs</b>.</p>

<table>
<colgroup span="1" class="txt"></colgroup>
<colgroup span="4" class="num"></colgroup>
<tr>
<th>Program&nbsp;Source&nbsp;Code</th>
<th><a href="<?=CORE_SITE;?>help.php#inputvalue" title="? Help">&nbsp;N&nbsp;</a></th>
<th><a href="<?=CORE_SITE;?>help.php#time" title="? Help">CPU&nbsp;secs</a></th>
<th><a href="<?=CORE_SITE;?>help.php#time" title="? Help">Elapsed&nbsp;secs</a></th>
<th><a href="<?=CORE_SITE;?>help.php#memory" title="? Help">Memory&nbsp;KB</a></th>
<th><a href="<?=CORE_SITE;?>help.php#gzbytes" title="? Help">Code&nbsp;B</a></th>
</tr>

<?
foreach($Data as $row){
   $test = $row[DATA_TEST];
   $id = $row[DATA_ID];
   $TestName = $Tests[$row[DATA_TEST]][TEST_NAME];
   $status = $row[DATA_STATUS];

   $BAR = '';
   if (isset($prevTest) && isset($prevId)){
      if ($test != $prevTest || $id != $prevId){ $BAR = ' class="bar"'; }
      elseif (isset($prevStatus) && $prevStatus<0) { continue; }
   }
   $prevTest = $test;
   $prevId = $id;
   $prevStatus = $status;

   printf('<tr><td %s><a href="benchmark.php?test=%s&amp;lang=%s&amp;id=%d" title="Read the Program Source Code : %s %s %s">%s&nbsp;%s</a></td>', $BAR,$test,$row[DATA_LANG],$id,$TestName,$LangName,IdName($id),$TestName,IdName($id)); echo "\n";

   if ($row[DATA_TESTVALUE]==0){ $n = '?'; } else { $n = '&nbsp;'.number_format($row[DATA_TESTVALUE]); }

   if ($status<0){
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


<h2><a href="#about" name="about">&nbsp;<strong><?=$LangName;?></strong></a>&nbsp;:&nbsp;<?=$LangTag;?>&nbsp;</h2>
<p></p>
<?=$About;?>
