<?   // Copyright (c) Isaac Gouy 2004-2009 ?>

<p>Does the <?=$LangName;?> program work for each input value? Why not? Read <a href="#log">&darr;&nbsp;the log</a>.</p>
<p>Are you able to understand the program? How could it be improved?</p>

<? 
MkMenuForm($Tests,$SelectedTest,$Langs,$SelectedLang,"fullcpu"); 
$TestName = $Tests[$SelectedTest][TEST_NAME];
$LangName = $Langs[$SelectedLang][LANG_FULL];
$P = $SelectedLang.'-'.$Id;
?>

<h2><a href="#prog" name="prog">&nbsp;<?=$Title;?></a></h2>

<table>
<colgroup span="4" class="num"></colgroup>
<tr>
<th><a href="help.php#nmeans">&nbsp;N&nbsp;</a></th>
<th><a href="help.php#measurecpu">CPU&nbsp;secs</a></th>
<th><a href="help.php#memory">Memory&nbsp;KB</a></th>
<th><a href="help.php#gzbytes">Code B</a></th>
<th><a href="help.php#measurecpu">Elapsed&nbsp;secs</a></th>
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
            $fullcpu = sprintf('%0.2f',$d[DATA_FULLCPU]);
            $elapsed = ElapsedTime($d);
            $load = CpuLoad($d);
         }

         printf('<tr class="a"><td class="r">%s</td><td class="r">%s</td><td class="r">%s</td><td class="r">%d</td><td class="r">%s</td><td class="r">&nbsp;&nbsp;%s</td></tr>',
            $n,$fullcpu,$kb,$d[DATA_GZ],$elapsed,$load); echo "\n";
      }
}
?>
</table>
<pre><?=$Code;?></pre>

<h3><a href="#about" name="about">&nbsp;about the program</a></h3>
<?=$About;?>

<h3><a href="#log" name="log">&nbsp;build &amp; benchmark results</a></h3>
<pre><?=$Log;?></pre>


