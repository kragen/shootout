<?   // Copyright (c) Isaac Gouy 2004 ?>


<!-- // MENU /////////////////////////////////////////////////// -->

<div>
<? MkMenuForm($Tests,$SelectedTest,$Langs,$SelectedLang,$Sort); ?>
</div>


<!-- // TAG /////////////////////////////////////////////////// -->

<table class="div">
<tr><td colspan="2">
<h4 class="rev">&nbsp;The Scorecard</h4>
</td></tr>
<tr><td colspan="2">
<p>What fun! Can you manipulate the multipliers and weights to put your favourite language on top?</p>
</td></tr> 



<tr>

<!-- // SCORECARD LANGUAGE TABLE ///////////////////////////////////// -->

<td>
<table>

<tr>
<th>language</th>
<th>score</th>
<th>missing</th>
</tr>

<?  
$RowClass = 'c';
foreach($Langs as $v){
   $Link = $v[LANG_LINK];
   $Name = $v[LANG_FULL];
   $HtmlName = $v[LANG_HTML];

   printf('<tr class="%s">',$RowClass); echo "\n";

   printf('<td><a href="benchmark.php?test=all&lang=%s&sort=%s" title="Check all the rankings for %s">%s</a></td>', 
      $Link,$Sort,$Name,$HtmlName); echo "\n";

   printf('<td class="r">%0.2f</td><td class="r">%d</td>', 0.0, 0); echo "\n";

   echo "</tr>\n";

   if ($RowClass=='a'){ $RowClass='c'; } else { $RowClass='a'; } 
}
?>

</table>
</td>


<!-- // SCORECARD FORM /////////////////////////////////////////// -->


<td>
<form method="GET" action="benchmark.php">
<input type="hidden" name="test" value="all" />
<input type="hidden" name="lang" value="all" />
<input type="hidden" name="sort" value="<?=$Sort;?>" />


<table>

<tr class="c">
<td><input type="submit" value="Calculate" /></td>
<td><input type="reset" value="Reset" /></td>
</tr>

<tr><th class="b" colspan="2">multipliers</th></tr>
<tr class="a">
<td><a href="faq.php?sort=<?=$Sort;?>#cpu">CPU Time</a></td>
<td><input type="text" size="2" name="xcpu" value="1"></td>
</tr>
<tr class="a">
<td><a href="faq.php?sort=<?=$Sort;?>#fullcpu">Full CPU Time</a></td>
<td><input type="text" size="2" name="xfullcpu" value="0"></td>
</tr>
<tr class="a">
<td><a href="faq.php?sort=<?=$Sort;?>#memory">Memory Use</a></td>
<td><input type="text" size="2" name="xmem" value="0"></td>
</tr>
<tr class="a">
<td><a href="faq.php?sort=<?=$Sort;?>#codelines">Code Lines</a></td>
<td><input type="text" size="2" name="xloc" value="0"></td>
</tr>

<!-- THIS IS JUST FOR SPACING! SHOULD USE CSS -->
<tr class="c"><td>&nbsp;</td><td>&nbsp;</td></tr>

<tr><th>benchmark</th><th>weight</th></tr>


<?  
$RowClass = 'c';
foreach($Tests as $v){
   $Link = $v[TEST_LINK];
   $Name = $v[TEST_NAME];

   printf('<tr class="%s">',$RowClass); echo "\n";

   printf('<td><a href="benchmark.php?test=%s&lang=all&sort=%s" title="Compare performance on the %s benchmark">%s</a></td>', $Link,$Sort,$Name,$Name); echo "\n";

   printf('<td><input type="text" size="2" name="%s" value="1"></td>', $Link); echo "\n";

   echo "</tr>\n";

   if ($RowClass=='a'){ $RowClass='c'; } else { $RowClass='a'; } 
}
?>



<tr class="c">
<td><input type="submit" value="Calculate" /></td>
<td><input type="reset" value="Reset" /></td>
</tr>


</table>

</form>
</td>
</tr>


<!-- // ABOUT /////////////////////////////////////////////////// -->

<tr><td colspan="2"><h4 class="rev">&nbsp;about The Scorecard</h4></td></tr>
<tr><td colspan="2"><?=$About;?></td></tr>  


</table>