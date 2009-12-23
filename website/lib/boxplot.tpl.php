<?   // Copyright (c) Isaac Gouy 2009 ?>

<? 
   MkMenuForm($Tests,$SelectedTest,$Langs,$SelectedLang);

   list($score,$labels,$stats,$selected) = $Data;
   unset($Data);  

   $pageUrl = CORE_SITE.SITE_NAME.'/which-programming-languages-are-fastest.php'; 
?>

<h2><a href="<?=$pageUrl;?>#chart" name="chart">&nbsp;<strong>Which programming languages are fastest?</strong></a></h2>

<p>This chart shows one <em>comparison</em> - <a href="<?=CORE_SITE;?>help.php#measurecpu" title="? Help">Time-used</a> (<?=$TimeUsed;?>).</p>

<p>Each chart box shows the middle 50% of program times measured for a programming language implementation, and each horizontal black bar shows <a href="#about">&darr;&nbsp;the median</a> program time measured.</p>


<p><img src="chartbox.php?<?='s='.Encode($stats);?>&amp;<?='m='.Encode($Mark);?>&amp;<?='w='.Encode($labels);?>"
   alt=""
   title=""
   width="480" height="300"
 /></p>

<h2><a href="<?=$pageUrl;?>#table" name="table">&nbsp;<strong>Which languages are fastest?</strong></a>&nbsp;<i>Le mieux est l'ennemi du bien.</i></h2>

<p>Select the language implementations you want to chart (deselect those you want to remove) then click the <b>chart</b> button.</p>

<p>Or follow the links to <b>compare 2</b> language implementations directly - one-against-another for all the benchmarks - on Time-used, Memory-used and Code-used.</p>

<form method="get" action="which-programming-languages-are-fastest.php">

<table>
<colgroup span="2" class="txt"></colgroup>
<colgroup span="7" class="num"></colgroup>
<tr class="score">
<td colspan="9" class="num">
<input type="submit" name="calc" value="chart" />
<input type="submit" name="calc" value="reset" />
</td>
</tr>

<tr>
<th>&nbsp;</th>
<th>compare 2</th>
<th><a href="<?=$pageUrl;?>#about">&nbsp;|-</a></th>
<th><a href="<?=$pageUrl;?>#about">&nbsp;|---</a></th>
<th><a href="<?=$pageUrl;?>#about">&nbsp;25%</a></th>
<th><a href="<?=$pageUrl;?>#about">median</a></th>
<th><a href="<?=$pageUrl;?>#about">&nbsp;75%</a></th>
<th><a href="<?=$pageUrl;?>#about">&nbsp;---|</a></th>
<th><a href="<?=$pageUrl;?>#about">&nbsp;-|</a></th>
</tr>


<?
foreach($score as $k => $v){
   $Name = $Langs[$k][LANG_FULL];
   $HtmlName = $Langs[$k][LANG_HTML];

   $checked = '';
   if (isset($selected[$k])){ $checked = 'checked="checked"'; }

   printf('<tr>');
   printf('<td class="score"><p><input type="checkbox" name="%s" %s /></p></td>', $k, $checked); echo "\n";

   if (isset($Langs[$k][LANG_SPECIALURL]) && !empty($Langs[$k][LANG_SPECIALURL])){
      printf('<td><a href="%s.php" title="Compare %s against one other language implementation">%s</a></td>', $Langs[$k][LANG_SPECIALURL],$Name,$HtmlName); 
   } else {
      printf('<td><a href="benchmark.php?test=all&amp;lang=%s" title="Compare %s against one other programming language">%s</a></td>', $k,$Name,$HtmlName);
   }
   echo "\n";

   printf('<td>%0.2f</td><td>%0.2f</td><td>%0.2f</td><td class="sort">%0.2f</td><td>%0.2f</td><td>%0.2f</td><td>%0.2f</td>',
      $v[STAT_MIN], $v[STAT_XLOWER], $v[STAT_LOWER], $v[STAT_MEDIAN],
      $v[STAT_UPPER], $v[STAT_XUPPER], $v[STAT_MAX]); echo "\n";
   echo "</tr>\n";
}
?>

<tr class="score">
<td colspan="9" class="num">
<input type="submit" name="calc" value="chart" />
<input type="submit" name="calc" value="reset" />
</td>
</tr>
</table>
<?   // <p><input type="hidden" name="box" value="1" /></p>   ?>
</form>


<h3><a href="<?=$pageUrl;?>#about" name="about">&nbsp;<strong>Which programming languages are fastest?</strong></a> <i>Robust Statistics</i></h3>
<?=$About;?>


