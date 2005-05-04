<?   // Copyright (c) Isaac Gouy 2004, 2005 ?>

<!-- // MENU /////////////////////////////////////////////////// -->

<div>
<? 
MkHeadToHeadMenuForm($Tests,$SelectedTest,$Langs,$SelectedLang,$SelectedLang2,$Sort); 
$Row = $Langs[$SelectedLang];
$LangName = $Row[LANG_FULL];
$LangTag = $Row[LANG_TAG];
$LangName2 = $Langs[$SelectedLang2][LANG_FULL];
?>
</div>

<!-- // TAG /////////////////////////////////////////////////// -->

<table class="div">
<tr><td>
<h4 class="rev"><a class="arev" href="#title" name="title">&nbsp;<?=$LangName;?> benchmarks <em>vs</em> <?=$LangName2;?></a></h4>
<p><?=$LangTag;?></p>
</td></tr>
</table>

<!-- // CHART //////////////////////////////////////////////////// -->

<table class="div">
<tr><td>

<img src="chartvs.php?test=<?=$SelectedTest;?>&amp;lang=<?=$SelectedLang;?>&amp;lang2=<?=$SelectedLang2;?>&amp;sort=<?=$Sort;?>"
   width="300" height="350"
 />
</td></tr>
</table>


<!-- // TABLE ////////////////////////////////////////////// -->

<table class="div">
<tr><td><table>
<tr>
<th>Program &amp; Logs</th>
<th>Full&nbsp;CPU Time</th>
<th>Memory Use</th>
<th>CPU Time</th>
<th>Code Lines</th>
<th>&nbsp;N&nbsp;</th>
</tr>

<tr>
<th>&nbsp;</th>
<th colspan="4"><?=$LangName;?>&nbsp;/ <?=$LangName2;?></th>
<th>&nbsp;</th>
</tr>

<? 
$RowClass = 'c';
foreach($Tests as $Row){
   printf('<tr class="%s">',$RowClass); echo "\n";
   $Link = $Row[TEST_LINK];
   $Name = $Row[TEST_NAME];

   if (isset($Data[$Link])){
      $v = $Data[$Link];     

      printf('<td><a href="benchmark.php?test=%s&amp;lang=%s&amp;id=%d&amp;sort=%s" 
         title="%s program and logs for the %s performance benchmark">%s</a></td>', 
         $Link, $SelectedLang, $v[N_ID], $Sort, $LangName, $Name, $Name);
                
      if ($v[N_LINES] > 0){ 
      
         if ($v[N_N]==0){ $n = '?'; } else { $n = '&nbsp;'.number_format($v[N_N]); }                         
                  
         if ($Link==STARTUP){
            printf('<td class="r">%s</td><td class="r">%s</td><td class="r">%s</td>
                  <td class="r">%s</td><td class="r"><span class="s">%s</span></td>', 
               PF($v[N_FULLCPU]), PF($v[N_MEMORY]), '&nbsp;', PF($v[N_LINES]), $n); 
         } else {
            printf('<td class="r">%s</td><td class="r">%s</td><td class="r">%s</td>
                  <td class="r">%s</td><td class="r"><span class="s">%s</span></td>', 
               PF($v[N_FULLCPU]), PF($v[N_MEMORY]), PF($v[N_CPU]), PF($v[N_LINES]), $n);                   
         }

      } else {      
         $r = FALSE;
         if ($v[N_LINES] == PROGRAM_ERROR){ $message = 'Error'; } 
         elseif ($v[N_LINES] == PROGRAM_TIMEOUT){ $message = 'Timout'; } 
         elseif ($r = $v[N_LINES] == NO_COMPARISON){ $message = '<span class="s">No '.$Langs[$v[N_LANG]][LANG_NAME].'</span>'; } 
         else { $message = 'X'; } 
         
         if ($r) { printf('<td></td><td></td><td></td><td colspan="2" class="r">%s</td>', $message); }
         else { printf('<td class="r">%s</td><td></td><td></td><td></td><td></td>', $message); }
      }

   } else {
      printf('<td><a href="benchmark.php?test=%s&amp;lang=%s&amp;sort=%s" 
         title="No %s program has been written for the %s performance benchmark">%s</a></td>', 
         $Link, $SelectedLang, $Sort, $LangName, $Name, $Name); echo "\n";
      $message = 'No&nbsp;program';
      printf('<td class="r">%s</td><td></td><td></td><td></td><td></td>', $message); 
   }
   echo "</tr>\n";
   if ($RowClass=='a'){ $RowClass='c'; } else { $RowClass='a'; } 
}
?>
</table></td></tr>


<!-- // ABOUT /////////////////////////////////////////////////// -->

<tr><td><h4 class="rev"><a class="arev" href="#about" name="about">&nbsp;about the <?=$LangName;?> language</a></h4></td></tr>
<tr><td><?=$About;?></td></tr>  

</table>