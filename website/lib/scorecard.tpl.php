<?   // Copyright (c) Isaac Gouy 2004-2009 ?>

<?
MkMenuForm($Tests,$SelectedTest,$Langs,$SelectedLang,"fullcpu"); 
?>

<!-- <h3><a href="#faster" name="faster">"For every complex problem</a> there is an answer that is clear, simple, and wrong." &nbsp;H.&nbsp;L.&nbsp;Mencken</h3> -->

<?
   list($score,$ratio) = $Data;
   unset($Data);
?>

<h2><a href="#chart" name="chart">&nbsp;How big is the difference between languages?</a></h2>

<p>This chart shows 1 or 2 or 3 <em>comparisons</em> - Time-used and/or Memory-used and/or Code-used.</p>

<p>Selected and weighted "<i>how many times more</i> compared to the program that used least <i>scores</i>" are compressed into one number - <a href="#about">&darr;&nbsp;a weighted geometric mean</a>.</p>

<p>Each chart bar shows that weighted geometric mean for one unidentified programming language implementation.</p>



<p><img src="chartscore.php?<?='g='.Encode($ratio);?>&amp;<?='m='.Encode($Mark);?>"
   width="480" height="225" alt=""
 /></p>


<h2><a href="#best" name="best">&nbsp;<strong>Which language is best?</strong></a></h2>

<p>This table shows shows 1 or 2 or 3 <em>comparisons</em> - <a href="help.php#measurecpu">Time-used</a> and/or <a href="help.php#memory">Memory-used</a> and/or <a href="help.php#gzbytes">Code-used</a> - compressed into <a href="#about">&darr;&nbsp;a weighted geometric mean</a>.</p>

<p>Column &#215; shows <i>how many times more</i> that geometric mean is for a programming language than for the language that used least.</p>

<p>Select the weights you want to give each comparison and each benchmark then click the <b>calculate</b> button.</p>

<p>Also, follow the links to <b>compare 2</b> language implementations directly - one-against-another for all the benchmarks - on Time-used, Memory-used and Code-used.</p>

<table class="layout"><tr><td>

<table>
<colgroup span="2" class="txt"></colgroup>
<colgroup span="2" class="num"></colgroup>
<tr>
<th>&nbsp;&nbsp;&#215;&nbsp;&nbsp;</th>
<th>compare&nbsp;2</th>
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

<form class="score" method="get" action="which-language-is-best.php">

<table>
<colgroup span="2" class="txt"></colgroup>
<tr><td colspan="2"><? MkDataSetMenu($DataSet); ?></td></tr>
<tr><td colspan="2" class="num">
<input type="submit" name="calc" value="calculate" />
<input type="submit" name="calc" value="reset" />
</td></tr>

<tr><th colspan="2">weight</th></tr>
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

<h3><a href="#about" name="about">&nbsp;<?=$Title;?> <i>The Weighted Geometric Mean</i></a></h3>
<?=$About;?>
