<?   // Copyright (c) Isaac Gouy 2004-2009 ?>

<?
   list($data,$sTests,$ratios) = $Data;
   unset($Data);
?>

<?
$Row = $Langs[$SelectedLang];
$LangName = $Row[LANG_FULL];
$LangTag = $Row[LANG_TAG];
$LangName2 = $Langs[$SelectedLang2][LANG_FULL];
$Link = $Row[LANG_LINK];
$Family = $Row[LANG_FAMILY];
$ShortName = $Row[LANG_NAME];
$ShortName2 = $Langs[$SelectedLang2][LANG_NAME];
?>

<p>Compare the performance of <strong><?=$LangName;?></strong> programs against some other language implementation, or check the <?=$Family;?> <a href="benchmark.php?test=all&amp;lang=<?=$Link;?>&amp;lang2=<?=$Link;?>" title="Show <?=$LangName;?> measurements">Time and Memory measurements</a>.</p>

<p>For more information about the <?=$Family;?> implementation we measured see
<a href="#about" title="Read about the <?=$LangName;?>language implementation">&darr;&nbsp;about <?=$LangName;?></a>.</p>

<? MkHeadToHeadMenuForm($Tests,$SelectedTest,$Langs,$SelectedLang,$SelectedLang2,"fullcpu"); ?>

<h2><a href="#title" name="title">&nbsp;The <?=$LangName;?> programs compared</a></h2>

<p><br/><img src="chartvs.php?<?='r='.Encode($ratios);?>&amp;<?='m='.Encode($Mark.' n');?>&amp;<?='w='.Encode($SelectedLang.'O'.$SelectedLang2);?>"
   alt=""
   title=""
   width="480" height="300"
 /></p>


<table>
<colgroup span="1" class="txt"></colgroup>
<colgroup span="4" class="num"></colgroup>
<tr><th colspan="5"><a href="#ratio" name="ratio"><sup><?=$LangName;?></sup>&nbsp;/&nbsp;<sub><?=$LangName2;?></sub></a> [smaller is better]</th></tr>

<tr>
<th>Program&nbsp;&amp;&nbsp;Logs</th>
<th>Time</th>
<th>Memory&nbsp;Use</th>
<th>Source&nbsp;Size</th>
<th>Reduced&nbsp;N</th>
</tr>


<?

$noprogram = array();
$nocomparison = array();
$failed = array();

foreach($sTests as $row){
   if ($row[TEST_WEIGHT]<=0){ continue; }
   $Link = $row[TEST_LINK];
   $Name = $row[TEST_NAME];
   if (isset($data[$Link])){
      $v = $data[$Link];
      if ($v[N_LINES] < 0){
         if ($v[N_LINES] == NO_COMPARISON){
            $nocomparison[] = array($Link,$SelectedLang,$v[N_ID],$Name,'No '.$Langs[$v[N_LANG]][LANG_NAME]);

         } else {
            $failed[] = array($Link,$SelectedLang,$v[N_ID],$Name,StatusMessage($v[N_LINES]) );
         }
      }
   } else {
      $noprogram[] = array($Link,$SelectedLang,0,$Name,'No&nbsp;program');
   }
}

foreach($noprogram as $tr){
   printf('<tr><td><a href="benchmark.php?test=%s&amp;lang=%s">%s</a></td><td><span class="message">%s</span></td><td></td><td></td><td></td></tr>',
      $tr[0],$tr[1],$tr[3],$tr[4]);
}

foreach($nocomparison as $tr){
      printf('<tr><td><a href="benchmark.php?test=%s&amp;lang=%s&amp;id=%d">%s</a></td><td>&nbsp;</td><td>&nbsp;</td><td colspan="2"><span class="message">%s</span></td></tr>',
      $tr[0],$tr[1],$tr[2],$tr[3],$tr[4]);
}

foreach($failed as $tr){
      printf('<tr><td><a href="benchmark.php?test=%s&amp;lang=%s&amp;id=%d">%s</a></td><td><span class="message">%s</span></td><td></td><td></td><td></td></tr>',
      $tr[0],$tr[1],$tr[2],$tr[3],$tr[4]);
}

foreach($sTests as $Row){
   if ($Row[TEST_WEIGHT]<=0){ continue; }

   $Link = $Row[TEST_LINK];
   $Name = $Row[TEST_NAME];

   if (isset($data[$Link])){
      $v = $data[$Link];

      if ($v[N_LINES] >= 0){
         printf('<tr><td><a href="benchmark.php?test=%s&amp;lang=%s&amp;id=%d">%s</a></td>',
            $Link, $SelectedLang, $v[N_ID], $Name);

         if ($v[N_N]==0){ $n = '<td></td>';
         } else { $n = '<td><span class="numN">&nbsp;'.number_format($v[N_N]).'</span></td>'; }

         if ($Name=='startup'){ $kb = 1.0; } else { $kb = $v[N_MEMORY]; }

         printf('%s%s%s%s</tr>', PF($v[N_FULLCPU]), PF($kb), PF($v[N_GZ]), $n);
      }
   }
}
?>
</table>

<h3><a href="#about" name="about">&nbsp;about <?=$LangName;?></a></h3>
<?=$About;?>
