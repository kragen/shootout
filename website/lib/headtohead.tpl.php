<?   // Copyright (c) Isaac Gouy 2004-2008 ?>


<?
// sort by x times faster than ratio
$SortedTests = array();
$reorder = array();
foreach($Data as $k => $v){ $SortedTests[$k] = $Tests[$k]; }
foreach($Tests as $k => $v){ 
   if (!isset($SortedTests[$k])){ $SortedTests[] = $Tests[$k]; }
}

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

<h2><a href="#title" name="title">&nbsp;Are the <?=$LangName;?> programs better?</a></h2>
<p>For each one of our benchmarks, a white bar shows when it had the better time, a black bar shows when it had the better memory use, and a white outline bar shows when it had smaller program source code.</p>


<p><img src="chartvs.php?<?='d='.HttpVarsEncodeHeadToHead(&$SortedTests,&$Data);?>&amp;<?='a='.HttpVarsEncodeLabels(array($LangName,$LangName2));?>"
   alt=""
   title=""
   width="480" height="300"
 /></p>


<p>How many times <em>faster or smaller</em> are the <strong><?=$LangName;?></strong> programs than the corresponding <?=$LangName2;?> programs?</p>


<table>
<colgroup span="1" class="txt"></colgroup>
<colgroup span="4" class="num"></colgroup>
<tr><th colspan="5"><?=$LangName;?> <a href="#ratio" name="ratio"><em>x&nbsp;times</em>&nbsp;better</a> <span class="num2"><br/>~ <?=$LangName2;?> <em>x&nbsp;times</em>&nbsp;better</span></th></tr>

<tr>
<th>Program &amp; Logs</th>
<th>&nbsp;Faster&nbsp;</th>
<th>Smaller: Memory Use</th>
<th>Smaller: GZip Bytes</th>
<th>Reduced N</th>
</tr>

<?
foreach($SortedTests as $Row){
   if (($Row[TEST_WEIGHT]<=0)){ continue; }
   printf('<tr>'); echo "\n";
   $Link = $Row[TEST_LINK];
   $Name = $Row[TEST_NAME];

   if (isset($Data[$Link])){
      $v = $Data[$Link];

      printf('<td><a href="benchmark.php?test=%s&amp;lang=%s&amp;id=%d">%s</a></td>', 
         $Link, $SelectedLang, $v[N_ID], $Name);

      if ($v[N_LINES] >= 0){
      
         if ($v[N_N]==0){ $n = '<td></td>'; } 
         else { $n = '<td><span class="numN">&nbsp;'.number_format($v[N_N]).'</span></td>'; }

         if ($Name=='startup'){ $kb = 1.0; } else { $kb = $v[N_MEMORY]; }

         printf('%s%s%s%s',
            PF($v[N_FULLCPU]), PF($kb), PF($v[N_GZ]), $n);

      } else {
         if ($v[N_LINES] == NO_COMPARISON){
            $message = 'No '.$Langs[$v[N_LANG]][LANG_NAME]; 
            printf('<td>&nbsp;</td><td>&nbsp;</td><td colspan="2"><span class="message">%s</span></td>', $message);
         } else {
            $message = StatusMessage($v[N_LINES]);
            printf('<td><span class="message">%s</span></td><td></td><td></td><td></td>', $message);
         }
      }

   } else {
      printf('<td><a href="benchmark.php?test=%s&amp;lang=%s">%s</a></td>', 
         $Link, $SelectedLang, $Name); echo "\n";
      $message = 'No&nbsp;program';
      printf('<td><span class="message">%s</span></td><td></td><td></td><td></td>', $message); 
   }
   echo "</tr>\n";
}
?>   
</table>

<h3><a href="#about" name="about">&nbsp;about <?=$LangName;?></a></h3>
<?=$About;?>
