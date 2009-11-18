<?   // Copyright (c) Isaac Gouy 2004-2009 ?>

<? 
MkMenuForm($Tests,$SelectedTest,$Langs,$SelectedLang,"fullcpu"); 
$TestName = $Tests[$SelectedTest][TEST_NAME];
$LangName = $Langs[$SelectedLang][LANG_FULL];
$P = $SelectedLang.'-'.$Id;
?>

<h2><a href="#prog" name="prog">&nbsp;<?=$Title;?></a></h2>

<p>Does this <?=$LangName;?> program work for all the input values? Why not? Read&nbsp;<a href="#log">&darr;&nbsp;the&nbsp;log</a>. Is this program small and simple, or very optimized? How could this program be improved?</p>

<table>
<colgroup span="4" class="num"></colgroup>
<tr>
<th><a href="help.php#nmeans">&nbsp;N&nbsp;</a></th>
<th><a href="help.php#measurecpu">CPU&nbsp;secs</a></th>
<th><a href="help.php#measurecpu">Elapsed&nbsp;secs</a></th>
<th><a href="help.php#memory">Memory&nbsp;KB</a></th>
<th><a href="help.php#gzbytes">Code B</a></th>
<th><a href="help.php#loadstring">~&nbsp;CPU&nbsp;Load</a></th>
</tr>
<?  
foreach($Data as $d){
      if ($Id==$d[DATA_ID]){
         if ($d[DATA_STATUS]<0){
            $n = '&nbsp;'; $kb = '&nbsp;'; $fullcpu = '&nbsp;';$elapsed = '&nbsp;'; $load = '&nbsp;';
            $fullcpu = StatusMessage($d[DATA_STATUS]);
         } else {
            if ($d[DATA_MEMORY]==0){
               $kb = '?';
            } else {
               if ($TestName=='startup'){ $kb = '&nbsp;'; }
               else { $kb = number_format((double)$d[DATA_MEMORY]); }
            }
            if ($d[DATA_TESTVALUE]>0){ $n = number_format((double)$d[DATA_TESTVALUE]); } else { $n = '?'; }
            $fullcpu = number_format($d[DATA_FULLCPU],2); 
            $elapsed = ElapsedTime($d);
            $load = CpuLoad($d);
         }

         printf('<tr class="a"><td class="r">%s</td><td class="r">%s</td><td class="r">%s</td><td class="r">%s</td><td class="r">%d</td><td class="r">&nbsp;&nbsp;%s</td></tr>',
            $n,$fullcpu,$elapsed,$kb,$d[DATA_GZ],$load); echo "\n";
      }
}
?>
</table>
<pre><?=$Code;?></pre>

<h3><a href="#about" name="about">&nbsp;about the program</a></h3>
<?=$About;?>

<h3><a href="#log" name="log">&nbsp;build &amp; benchmark results</a></h3>
<pre><?=$Log;?></pre>


