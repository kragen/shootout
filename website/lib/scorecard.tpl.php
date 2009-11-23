<?   // Copyright (c) Isaac Gouy 2004-2009 ?>

<?
MkMenuForm($Tests,$SelectedTest,$Langs,$SelectedLang,"fullcpu"); 
?>

<h3><a href="#faster" name="faster">"For every complex problem</a> there is an answer that is clear, simple, and wrong." &nbsp;H.&nbsp;L.&nbsp;Mencken</h3>


<?
   list($score,$ratio) = $Data;
   unset($Data);          
?>

<p>What <strong>fun!</strong> Increase the Code multiplier! Ignore Memory! Zero out those benchmarks that push your favourite language to the bottom!</p>
<p>Which balance between Code-used and Time-used and Memory-used is best for you? Zero out those benchmarks which are unlike what your programs do!</p>


<p><img src="chartscore.php?<?='g='.Encode($ratio);?>&amp;<?='m='.Encode($Mark);?>"
   width="480" height="225" alt=""
 /></p>


<table class="layout"><tr><td>

<table>
<colgroup span="2" class="txt"></colgroup>
<colgroup span="2" class="num"></colgroup>
<tr>
<th>&nbsp;&nbsp;&#215;&nbsp;&nbsp;</th>
<th>language&nbsp;implementation</th>
<th><a href="#about">GM</a></th>
<th><a href="#about">missing</a></th>
</tr>

<?
foreach($score as $k => $v){
   $HtmlName = $Langs[$k][LANG_HTML];
   printf('<tr>');
   printf('<td>%s</td>', PFx($v[SCORE_RATIO]));

   if (isset($Langs[$k][LANG_SPECIALURL]) && !empty($Langs[$k][LANG_SPECIALURL])){
      printf('<td><a href="%s.php">%s</a></td>', $Langs[$k][LANG_SPECIALURL],$HtmlName); 
   } else {
      printf('<td><a href="benchmark.php?test=all&amp;lang=%s">%s</a></td>', $k,$HtmlName); 
   }
   echo "\n";

   printf('<td>%0.2f</td><td>%s</td>',
      $v[SCORE_MEAN], PBlank($v[SCORE_TESTS])); echo "\n";
   echo "</tr>\n";
}
?>
</table>

</td><td>

<form class="score" method="get" action="fun.php">

<table>
<colgroup span="2" class="txt"></colgroup>
<tr><td colspan="2"><? MkDataSetMenu($DataSet); ?></td></tr>
<tr><td colspan="2" class="num">
<input type="submit" name="calc" value="calculate" />
<input type="submit" name="calc" value="reset" />
</td></tr>

<tr><th colspan="2">multipliers</th></tr>
<tr>
<td><a href="help.php#measurecpu">Time&nbsp;secs</a></td>
<td><input type="text" size="2" name="xfullcpu" value="<?=$W['xfullcpu'];?>" /></td>
</tr>
<tr>
<td><a href="help.php#memory">Memory&nbsp;KB</a></td>
<td><input type="text" size="2" name="xmem" value="<?=$W['xmem'];?>" /></td>
</tr>
<tr>
<td><a href="help.php#gzbytes">Code B</a></td>
<td><input type="text" size="2" name="xloc" value="<?=$W['xloc'];?>" /></td>
</tr>

<tr><th>benchmark</th><th>weight</th></tr>
<?
foreach($Tests as $t){
   $Link = $t[TEST_LINK];
   $Name = $t[TEST_NAME];
   $weight = $W[ $t[TEST_LINK] ];

   printf('<tr>'); echo "\n";
   printf('<td><a href="benchmark.php?test=%s&amp;lang=all">%s</a></td>', $Link,$Name); echo "\n";
   printf('<td><p><input type="text" size="2" name="%s" value="%d" /></p></td>', $Link, $weight); echo "\n";
   echo "</tr>\n";
}
?>

<tr><td colspan="2" class="num">
<input type="submit" name="calc" value="calculate" />
<input type="submit" name="calc" value="reset" />
</td></tr>
</table>
</form>

</td></tr></table>

<h3><a href="#about" name="about">&nbsp;<?=$Title;?></a></h3>
<?=$About;?>
