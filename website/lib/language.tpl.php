<?   // Copyright (c) Isaac Gouy 2004, 2005 ?>

<div>
<? 
$Row = $Langs[$SelectedLang];
$LangName = $Row[LANG_FULL];
$LangTag = $Row[LANG_TAG];
$LangName2 = $Langs[$SelectedLang2][LANG_FULL];
$Link = $Row[LANG_LINK];
$Family = $Row[LANG_FAMILY];
?>

<p>For more information about a Timeout or Error click the program name and scroll-down to the 'build &amp; benchmark results'.</p>

</div>


<!-- // MENU /////////////////////////////////////////////////// -->
<div>
<? MkHeadToHeadMenuForm($Tests,$SelectedTest,$Langs,$SelectedLang,$SelectedLang2,"fullcpu"); ?>
</div>

<!-- // TAG /////////////////////////////////////////////////// -->

<table class="div">
<tr><td>
<h4 class="rev"><a class="arev" href="#title" name="title">&nbsp;<?=$LangName;?> measurements</a></h4>
</td></tr>




<!-- // TABLE ////////////////////////////////////////////// -->

<tr><td><table>
<tr>
<th>Program &amp; Logs</th>
<th>Full&nbsp;CPU Time</th>
<th>Memory Use</th>
<th>Code Lines</th>
<th>&nbsp;N&nbsp;</th>
</tr>

<? 
$RowClass = 'c';
foreach($Tests as $Row){
   printf('<tr class="%s">',$RowClass); echo "\n";
   $Link = $Row[TEST_LINK];
   $Name = $Row[TEST_NAME];

   if (isset($Data[$Link])){
      $v = $Data[$Link];     

      printf('<td><a href="benchmark.php?test=%s&amp;lang=%s&amp;id=%d">%s</a></td>', 
         $Link, $SelectedLang, $v[N_ID], $Name);
                
      if ($v[N_N]==0){ $n = '?'; } else { $n = '&nbsp;'.number_format($v[N_N]); }                
                
      if ($v[N_EXCLUDE] >= 0){                                                  
         if ($Link==STARTUP){
            printf('<td class="r">%0.2f</td><td class="r">%s</td>
                  <td class="r">%s</td><td class="r"><span class="s">%s</span></td>', 
               $v[N_FULLCPU], number_format($v[N_MEMORY]), $v[N_LINES], $n); 
         } else {
            printf('<td class="r">%0.2f</td><td class="r">%s</td>
                  <td class="r">%s</td><td class="r"><span class="s">%s</span></td>', 
               $v[N_FULLCPU], number_format($v[N_MEMORY]), $v[N_LINES], $n);                   
         }

      } else {      
         if ($v[N_EXCLUDE] == PROGRAM_ERROR){ $message = 'Error'; } 
         elseif ($v[N_EXCLUDE] == PROGRAM_TIMEOUT){ $message = 'Timout'; } 
         else { $message = 'X'; } 
         
         printf('<td class="rb">%s</td><td></td><td class="r">%s</td>
            <td class="r"><span class="s">%s</span></td>', $message, $v[N_LINES], $n);
      }

   } else {
      printf('<td><a href="benchmark.php?test=%s&amp;lang=%s">%s</a></td>', 
         $Link, $SelectedLang, $Name); echo "\n";
      $message = 'No&nbsp;program';
      printf('<td class="r">%s</td><td></td><td></td><td></td>', $message); 
   }
   echo "</tr>\n";
   if ($RowClass=='a'){ $RowClass='c'; } else { $RowClass='a'; } 
}
?> 

<tr><td colspan="5">&nbsp;</td></tr>

</table>
</td></tr>


<tr><td><h4 class="rev"><a class="arev" href="#about" name="about">&nbsp;about <?=$LangName;?></a></h4></td></tr>
<tr><td><?=$About;?></td></tr>  

</table>