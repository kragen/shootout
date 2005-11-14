<?   // Copyright (c) Isaac Gouy 2004, 2005 ?>


<!-- // MENU /////////////////////////////////////////////////// -->

<div>
<? 
MkMenuForm($Tests,$SelectedTest,$Langs,$SelectedLang,"fullcpu"); 
$TestName = $Tests[$SelectedTest][TEST_NAME];
$LangName = $Langs[$SelectedLang][LANG_FULL];

$P = $SelectedLang.'-'.$Id;
?>
</div>

<div>
<a href="benchmark.php?test=<?=$SelectedTest;?>&amp;lang=all"
title="Check CPU times and source-code for the <?=$TestName;?> <?=TESTS_PHRASE;?>" ><?=$TestName;?> <?=TESTS_PHRASE;?></a> 
<?=BAR;?>
<a href="benchmark.php?test=all&amp;lang=<?=$SelectedLang;?>&amp;lang2=<?=$SelectedLang;?>"  
title="Show <?=$LangName;?> <?=TESTS_PHRASE;?> summary" >
<?=$LangName;?></a>
<?=BAR;?>
<a href="fulldata.php?test=<?=$SelectedTest;?>&amp;p1=<?=$P;?>&amp;p2=<?=$P;?>&amp;p3=<?=$P;?>&amp;p4=<?=$P;?>"  
title="Check all the data for the <?=$TestName;?> <?=TESTS_PHRASE;?>" ><?=$TestName;?> full data</a>
</div>


<!-- // TAG /////////////////////////////////////////////////// -->

<table class="div">
<tr><td>
<h4 class="rev"><a class="arev" href="#program" name="program">&nbsp;<?=$Title;?></a></h4>
</td></tr>

<!-- // SUMMARY TABLE //////////////////////////////////////// -->

<tr><td><table>
<tr>
<th>&nbsp;N&nbsp;</th>
<th>Full&nbsp;CPU Time&nbsp;s</th>
<th>Memory Use&nbsp;KB</th>
<th>Code Lines</th>
</tr>

<?
if (isset($Data[$SelectedLang])){   
   foreach($Data[$SelectedLang] as $d){                 
      if ($Id==$d[DATA_ID]){             
         if ($d[DATA_FULLCPU]>0){
            if ($d[DATA_MEMORY]==0){ 
               $kb = '?'; 
            } else { 
               $kb = number_format((double)$d[DATA_MEMORY]); 
            }

            if ($SelectedTest==STARTUP){ 
               $cpu = '&nbsp;'; 
            } else { 
               $cpu = sprintf('%0.2f',$d[DATA_CPU]); 
            }         
            $fullcpu = sprintf('%0.2f',$d[DATA_FULLCPU]);
         } else {
            $kb = '&nbsp;'; $fullcpu = '&nbsp;';
            if ($d[DATA_FULLCPU]==PROGRAM_TIMEOUT){ $cpu = 'Timout'; }
            if ($d[DATA_FULLCPU]==PROGRAM_ERROR){ $cpu = 'Error'; }         
         }

         if ($d[DATA_TESTVALUE]>0){ $n = number_format((double)$d[DATA_TESTVALUE]); } else { $n = '?'; }        
         printf('<tr class="a"><td class="r">%s</td><td class="r">%s</td><td class="r">%s</td><td class="r">%d</td></tr>', 
            $n,$fullcpu,$kb,$d[DATA_LINES]); echo "\n";
      }
   }
} else {
   echo '<tr class="a"><td></td> <td></td> <td></td></tr>'; echo "\n";
}        
?>

</table></td></tr>
</table>

<!-- // SOURCE CODE //////////////////////////////////////// -->

<table class="div">
<tr><td><pre><?=$Code;?></pre></td></tr> 
</table>

<!-- // BUILD ///////////////////////////////////////////////// -->

<table class="div">
<tr><td>
<h4 class="rev"><a class="arev" href="#log" name="log">&nbsp;build &amp; benchmark results</a></h4>
</td></tr>
</table>

<table class="div">
<tr><td><pre><?=$Log;?></pre></td></tr>
</table> 

<!-- // ABOUT /////////////////////////////////////////////////// -->

<table class="div">
<tr><td><h4 class="rev"><a class="arev" href="#about" name="about">&nbsp;about the program</a></h4></td></tr>
<tr><td><?=$About;?></td></tr>  
</table>