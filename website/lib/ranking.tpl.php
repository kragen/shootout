<?   // Copyright (c) Isaac Gouy 2004, 2005 ?>

<!-- // MENU /////////////////////////////////////////////////// -->

<div>
<? 
MkMenuForm($Tests,$SelectedTest,$Langs,$SelectedLang,$Sort); 
$Row = $Langs[$SelectedLang];
$LangName = $Row[LANG_FULL];
$LangTag = $Row[LANG_TAG];
?>
</div>

<!-- // TAG /////////////////////////////////////////////////// -->

<table class="div">
<tr><td>
<h4 class="rev">&nbsp;<?=$LangName;?> benchmark rankings </h4>
<p><?=$LangTag;?></p>
</td></tr>


<!-- // RANKINGS TABLE ////////////////////////////////////////////// -->
<tr><td><table>
<tr>
<th>Program &amp; Logs</th>
<th>Full&nbsp;CPU Time</th>
<th>Memory Use</th>
<th>CPU Time</th>
<th>Code Lines</th>
</tr>

<tr>
<th>&nbsp;</th>
<th>rank</th>
<th>rank</th>
<th>rank</th>
<th>rank</th>
</tr>

<? 
$RowClass = 'c';
foreach($Tests as $Row){
   printf('<tr class="%s">',$RowClass); echo "\n";
   $Link = $Row[TEST_LINK];
   $Name = $Row[TEST_NAME];

   if (isset($Rank[$Link])){
      $v = $Rank[$Link];   

      printf('<td><a href="benchmark.php?test=%s&amp;lang=%s&amp;id=%d&amp;sort=%s" 
         title="%s program and logs for the %s performance benchmark">%s</a></td>', 
         $Link, $SelectedLang, $v[DATA_ID], $Sort, $LangName, $Name, $Name);

      if ($v[DATA_LINES] > 0){ 
         if ($Link==STARTUP){
            printf('<td class="r">%d</td><td class="r">%s</td><td class="r">%s</td><td class="r">%d</td>', 
               $v[DATA_FULLCPU], $v[DATA_MEMORY], '&nbsp;', $v[DATA_LINES]); 
         } else {
            printf('<td class="r">%d</td><td class="r">%s</td><td class="r">%s</td><td class="r">%d</td>', 
               $v[DATA_FULLCPU], $v[DATA_MEMORY], $v[DATA_CPU], $v[DATA_LINES]); 
         }

      } else {   
         if ($v[DATA_LINES] == PROGRAM_ERROR){ $message = 'Error'; } 
         elseif ($v[DATA_LINES] == PROGRAM_TIMEOUT){ $message = 'Timout'; } 
         else { $message = 'X'; } 
         printf('<td class="r">%s</td><td></td><td></td><td></td>', $message); 
      }

   } else {
      printf('<td><a href="benchmark.php?test=%s&amp;lang=%s&amp;sort=%s" 
         title="No %s program has been written for the %s performance benchmark">%s</a></td>', 
         $Link, $SelectedLang, $Sort, $LangName, $Name, $Name); echo "\n";
      $message = 'No&nbsp;program';
      printf('<td class="r">%s</td><td></td><td></td><td></td>', $message); 
   }
   echo "</tr>\n";
   if ($RowClass=='a'){ $RowClass='c'; } else { $RowClass='a'; } 
}
?>
</table></td></tr>


<!-- // ABOUT /////////////////////////////////////////////////// -->

<tr><td><h4 class="rev">&nbsp;about the <?=$LangName;?> language</h4></td></tr>
<tr><td><?=$About;?></td></tr>  

</table>