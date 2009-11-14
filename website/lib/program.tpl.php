<?   // Copyright (c) Isaac Gouy 2004-2008 ?>

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

<h2><a href="#prog" name="prog">&nbsp;<?=$Title;?></a></h2>
<p>Read <a href="#log">&darr;&nbsp;the build log</a>.</p>

<table>
<colgroup span="4" class="num"></colgroup>
<tr>
<th><a href="help.php#nmeans">&nbsp;N&nbsp;</a></th>
<th><a href="help.php#measurecpu">CPU&nbsp;secs</a></th>
<th><a href="help.php#memory">Memory&nbsp;KB</a></th>
<th><a href="help.php#gzbytes">Size B</a></th>
<th><a href="help.php#measurecpu">Elapsed&nbsp;secs</a></th>
<th><a href="help.php#loadstring">~&nbsp;CPU&nbsp;Load</a></th>
</tr>
<?
if (sizeof($Data)>0){
      if ($Id==$Data[DATA_ID]){
         if ($Data[DATA_STATUS]<0){
            $n = '&nbsp;'; $kb = '&nbsp;'; $fullcpu = '&nbsp;';$elapsed = '&nbsp;'; $load = '&nbsp;';
            $fullcpu = StatusMessage($Data[DATA_STATUS]);
         } else {
            if ($Data[DATA_MEMORY]==0){
               $kb = '?';
            } else {
               if ($TestName=='startup'){ $kb = '&nbsp;'; }
               else { $kb = number_format((double)$Data[DATA_MEMORY]); }
            }
            if ($Data[DATA_TESTVALUE]>0){ $n = number_format((double)$Data[DATA_TESTVALUE]); } else { $n = '?'; }
            $fullcpu = sprintf('%0.2f',$Data[DATA_FULLCPU]);
            $elapsed = ElapsedTime($Data);
            $load = CpuLoad($Data);
         }

         printf('<tr class="a"><td class="r">%s</td><td class="r">%s</td><td class="r">%s</td><td class="r">%d</td><td class="r">%s</td><td class="r">&nbsp;&nbsp;%s</td></tr>',
            $n,$fullcpu,$kb,$Data[DATA_GZ],$elapsed,$load); echo "\n";
      }
} else {
   echo '<tr class="a"><td></td> <td></td> <td></td> <td></td> <td></td></tr>'; echo "\n";
}
?>
</table>
<pre><?=$Code;?></pre>

<h3><a href="#about" name="about">&nbsp;about the program</a></h3>
<?=$About;?>

<h3><a href="#log" name="log">&nbsp;build &amp; benchmark results</a></h3>
<pre><?=$Log;?></pre>


