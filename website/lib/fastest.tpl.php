<?   // Copyright (c) Isaac Gouy 2009-2010 ?>

<? 
   list($score,$labels,$stats,$selected) = $Data;
   unset($Data);   
?>

<h2><a href="#chart" name="chart">&nbsp;<strong>Which programming language is fastest?</strong></a></h2>

<p>No. Which programming language implementation has the fastest benchmark programs?</p>

<p>This chart shows one <em>comparison</em> - <a href="<?=CORE_SITE;?>help.php#time">Time-used</a> (<?=$TimeUsed;?>) / Fastest.</p>

<p>For this comparison, the <a href="<?=CORE_SITE;?>help.php#compare" title="Measurements for different OS/machine combinations are shown on different color-coded pages">4 sets of up-to-date measurements</a> have been combined. This comparison includes measurements both for Intel&#174;&nbsp;Q6600&#174;&nbsp;<a href="./u64q/which-programming-languages-are-fastest.php" title="Which programming languages have the fastest benchmark programs on quad-core x64 Ubuntu?">quad-core</a> and <a href="./u32/which-programming-languages-are-fastest.php" title="Which programming languages have the fastest benchmark programs on one core x86 Ubuntu?">one-core</a>; both for <a href="./u64/which-programming-languages-are-fastest.php" title="Which programming languages have the fastest benchmark programs on one core x64 Ubuntu?">x64</a>&nbsp;and <a href="./u32q/which-programming-languages-are-fastest.php" title="Which programming languages have the fastest benchmark programs on quad-core x86 Ubuntu?">x86</a>&nbsp;Ubuntu&#8482;. <i>This comparison blurs the differences</i>.</p>

<p>Each chart box shows the middle 50% of (normalized) program Time-used ratios for a programming language implementation, and each horizontal black bar shows <a href="#about">&darr;&nbsp;the median</a> (normalized) program Time-used ratio.</p>


<p><img src="chartbox-simple.php?<?='s='.Encode($stats);?>&amp;<?='m='.Encode($Mark);?>&amp;<?='w='.Encode($labels);?>"
   alt=""
   title=""
   width="480" height="300"
 /></p>

<h2><a href="#table" name="table">&nbsp;<strong>Which language is fastest?</strong></a>&nbsp;<i>Le mieux est l'ennemi du bien.</i></h2>

<p>No. Which programming language implementation has the fastest benchmark programs?</p>

<p>Select the language implementations you want to chart (deselect those you want to remove) then click the <b>chart</b> button.</p>

<form method="get" action="fastest-programming-language.php">

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
   $NoSpaceName = str_replace(' ','&nbsp;',$Name);

   $checked = '';
   if (isset($selected[$k])){ $checked = 'checked="checked"'; }

   printf('<tr>');
   printf('<td class="score"><p><input type="checkbox" name="%s" %s /></p></td>', $k, $checked); echo "\n";

   printf('<td>%s</td><td>%0.2f</td><td>%0.2f</td><td>%0.2f</td><td class="sort">%0.2f</td><td>%0.2f</td><td>%0.2f</td><td>%0.2f</td>',
      $NoSpaceName,
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
</form>


<h3><a href="#about" name="about">&nbsp;<strong>Which programming language is fastest?</strong></a> <i>Robust Statistics</i></h3>
<?=$About;?>


