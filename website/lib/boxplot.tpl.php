<?   // Copyright (c) Isaac Gouy 2009 ?>

<? 
MkMenuForm($Tests,$SelectedTest,$Langs,$SelectedLang,"fullcpu"); 
?>

<h2><a href="#box" name="box">&nbsp;<?=$Title;?></a>&nbsp;<em>Le mieux est l'ennemi du bien.</em></h2>

<?
   list($score,$labels,$stats,$selected) = $Data;
   unset($Data);
?>

<p>Do the Time-used boxes overlap or is there clear separation between them? Which programming language implementations have the fastest programs?</p>

<p><img src="chartbox.php?<?='s='.Encode($stats);?>&amp;<?='m='.Encode($Mark);?>&amp;<?='w='.Encode($labels);?>"
   alt=""
   title=""
   width="480" height="300"
 /></p>

<form method="get" action="fastest.php">

<table>
<colgroup span="2" class="txt"></colgroup>
<colgroup span="7" class="num"></colgroup>
<tr class="score">
<td colspan="2"><? MkDataSetMenu($DataSet); ?></td>
<td colspan="7" class="num">
<input type="submit" name="calc" value="calculate" />
<input type="submit" name="calc" value="reset" />
</td>
</tr>

<tr>
<th>&nbsp;</th>
<th>language implementation</th>
<th><a href="#about">&nbsp;|-</a></th>
<th><a href="#about">&nbsp;|---</a></th>
<th><a href="#about">&nbsp;25%</a></th>
<th><a href="#about">median</a></th>
<th><a href="#about">&nbsp;75%</a></th>
<th><a href="#about">&nbsp;---|</a></th>
<th><a href="#about">&nbsp;-|</a></th>
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
      printf('<td><a href="%s.php">%s</a></td>', $Langs[$k][LANG_SPECIALURL],$HtmlName); 
   } else {
      printf('<td><a href="benchmark.php?test=all&amp;lang=%s">%s</a></td>', $k,$HtmlName);
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
<input type="submit" name="calc" value="calculate" />
<input type="submit" name="calc" value="reset" />
</td>
</tr>
</table>
<?   // <p><input type="hidden" name="box" value="1" /></p>   ?>
</form>


<h3><a href="#about" name="about">&nbsp;<?=$Title;?></a></h3>
<?=$About;?>


