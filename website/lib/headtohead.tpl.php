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
<p><a href="#about" title="Read about <?=$LangName;?>"><?=$LangTag;?></a></p>
</td></tr>



<!-- // CHART //////////////////////////////////////////////////// -->

<tr><td class="center">

<img src="chartvs.php?test=<?=$SelectedTest;?>&amp;lang=<?=$SelectedLang;?>&amp;lang2=<?=$SelectedLang2;?>&amp;sort=<?=$Sort;?>"
   alt="Side by side comparison between <?=$LangName;?> and <?=$LangName2;?> on all performance benchmarks"
   title="Side by side comparison between <?=$LangName;?> and <?=$LangName2;?> on all performance benchmarks"
   width="300" height="350"
 />
</td></tr>

<tr><td>&nbsp;</td></tr>


<!-- // TABLE ////////////////////////////////////////////// -->


<tr><td>
<h4 class="rev"><a class="arev" href="#ratio" name="ratio">&nbsp;<?=$LangName;?> / <?=$LangName2;?></a></h4>
</td></tr>


<tr><td><table>
<tr>
<th class="c">&nbsp;</th>
<th>Full&nbsp;CPU Time</th>
<th>Memory Use</th>
<th>CPU Time</th>
<th>Code Lines</th>
<th class="c">&nbsp;</th>
</tr>

<tr>
<th>Program &amp; Logs</th>
<th colspan="4"><?=$LangName;?>&nbsp;/ <?=$LangName2;?></th>
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

   
<tr><td colspan="6">&nbsp;</td></tr>
   


<!-- // SUMMARY /////////////////////////////////////////////////// -->   

<tr class="b"><td colspan="6">
<a class="ab" href="#summary" name="summary">&nbsp;summary</a>
</td></tr>
    
<tr><td>
<tr class="a">
<th class="c">&nbsp;</th>
<th>Full&nbsp;CPU Time</th>
<th>Memory Use</th>
<th>CPU Time</th>
<th>Code Lines</th>
<th class="c">&nbsp;</th>
</tr>   
<tr>
<th class="c">&nbsp;</th>
<th colspan="4"><?=$LangName;?> better - <?=$LangName2;?> better</th>
<th class="c">&nbsp;</th>
</tr>  


<? // this should be in a function

$fullb = 0; $fullw = 0; $memb = 0; $memw = 0; 
$cpub = 0; $cpuw = 0; $linesb = 0; $linesw = 0;

foreach($Tests as $Row){
   $Link = $Row[TEST_LINK];
   if (isset($Data[$Link])){
      $v = $Data[$Link];    
      
      if ($v[N_LINES] > 0){           
      
         if ($v[N_FULLCPU] <= 0.999){ $fullb++; } 
         elseif ($v[N_FULLCPU] >= 1.001){ $fullw++; } 
         
         if ($v[N_MEMORY] <= 0.999){ $memb++; } 
         elseif ($v[N_MEMORY] >= 1.001){ $memw++; }   
         
         if ($v[N_CPU] <= 0.999){ $cpub++; } 
         elseif ($v[N_CPU] >= 1.001){ $cpuw++; }   
         
         if ($v[N_LINES] <= 0.999){ $linesb++; } 
         elseif ($v[N_LINES] >= 1.001){ $linesw++; }                                                                    
      }      
   }
}
?>

<tr class="a">
<td class="c">&nbsp;</td>
<td class="r"><?=$fullb;?>-<?=$fullw;?></td>
<td class="r"><?=$memb;?>-<?=$memw;?></td>
<td class="r"><?=$cpub;?>-<?=$cpuw;?></td>
<td class="r"><?=$linesb;?>-<?=$linesw;?></td>
<td class="c">&nbsp;</td>
</tr>
<tr><td colspan="6">&nbsp;</td></tr>  

</table>
</td></tr>


<tr><td><h4 class="rev"><a class="arev" href="#about" name="about">&nbsp;about the <?=$LangName;?> language</a></h4></td></tr>
<tr><td><?=$About;?></td></tr>  

</table>