<?   // Copyright (c) Isaac Gouy 2004-2006 ?>

<? 
MkMenuForm($Tests,$SelectedTest,$Langs,$SelectedLang,"fullcpu"); 
$TestName = $Tests[$SelectedTest][TEST_NAME];
$LangName = $Langs[$SelectedLang][LANG_FULL];
$P = $SelectedLang.'-'.$Id;
?>

<p>
<a href="benchmark.php?test=<?=$SelectedTest;?>&amp;lang=all"
title="Check CPU times and source-code for the <?=$TestName;?> <?=TESTS_PHRASE;?>" ><?=$TestName;?> <?=TESTS_PHRASE;?></a> 
<?=BAR;?>
<a href="benchmark.php?test=all&amp;lang=<?=$SelectedLang;?>&amp;lang2=<?=$SelectedLang;?>"  
title="Show <?=$LangName;?> <?=TESTS_PHRASE;?> summary" >
<?=$LangName;?></a>
<?=BAR;?>
<a href="fulldata.php?test=<?=$SelectedTest;?>&amp;p1=<?=$P;?>&amp;p2=<?=$P;?>&amp;p3=<?=$P;?>&amp;p4=<?=$P;?>"  
title="Check all the data for the <?=$TestName;?> <?=TESTS_PHRASE;?>" ><?=$TestName;?> full data</a>
</p>

<h2><a href="#program" name="program">&nbsp;<?=$Title;?></a></h2>
<table>
<colgroup span="4" class="num"></colgroup>
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
        
            $fullcpu = sprintf('%0.2f',$d[DATA_FULLCPU]);
         } else {
            $kb = '&nbsp;'; $fullcpu = '&nbsp;';
            if ($d[DATA_FULLCPU]==PROGRAM_TIMEOUT){ $fullcpu = 'Timout'; }
            if ($d[DATA_FULLCPU]==PROGRAM_ERROR){ $fullcpu = 'Error'; }         
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
</table>
<pre><?=$Code;?></pre>

<h3><a href="#log" name="log">&nbsp;build &amp; benchmark results</a></h3>
<pre><?=$Log;?></pre>

<h3><a href="#about" name="about">&nbsp;about the program</a></h3>
<?=$About;?>
