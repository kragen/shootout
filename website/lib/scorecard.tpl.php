<?   // Copyright (c) Isaac Gouy 2004, 2005 ?>

<!-- // MENU /////////////////////////////////////////////////// -->

<div>
<? MkMenuForm($Tests,$SelectedTest,$Langs,$SelectedLang,"fullcpu"); ?>
</div>


<!-- // TAG /////////////////////////////////////////////////// -->

<table class="div">
<tr><td colspan="2">
<h4 class="rev"><a class="arev" href="#faster" name="faster">&nbsp;Create your own Overall Scores</a></h4>
</td></tr>
<tr><td colspan="2">
<p>What fun! <a href="http://en.wikipedia.org/wiki/April_Fool's_Day" title="April Fool's Day defined on Wikipedia"><strong>April Fool's Day</strong></a> all year long! Can you manipulate the multipliers and weights to make your favourite language the fastest programming language in the Shootout?</p>

<p>And remember, languages that implement more benchmarks will move to the top of the list, and those with many missing benchmarks (No Program, Error, Timeout) will stay at the bottom!</p>

<p>And remember, "<strong>For every complex problem, there is a solution that is simple, neat, and wrong</strong>."</p>
</td></tr> 


<?  // SET WEIGHTS /////////////////////////////////////
 
$minWeight = 0;    // normalize weights
$maxWeight = 5;
$countWeight = 0.0;

foreach($W as $k => $v){
   if ($v > $maxWeight){ $W[$k] = $maxWeight; }
   elseif ($v < $minWeight){ $W[$k] = $minWeight; }
   if ($W[$k]>0.0 && ($k!='xfullcpu')&&($k!='xmem')&& $k!='xloc'){ $countWeight++; }
}
if ($countWeight==0){ $countWeight = 1; }

$possible = 0.0;
foreach($W as $k => $v){
   if ($W[$k]>0.0 && ($k!='xfullcpu')&&($k!='xmem')&& ($k!='xloc')){ 
      $possible += $W[$k] * $W['xfullcpu'] * 100.0 / $countWeight;
      $possible += $W[$k] * $W['xmem'] * 100.0 / $countWeight;
      $possible += $W[$k] * $W['xloc'] * 100.0 / $countWeight;
   }
}

// CALCULATE WEIGHTED SCORES /////////////////////////////////////

foreach($Data as $k => $test){
   $s = 0.0;
   foreach($test as $t => $v){
      $s += $v[DATA_FULLCPU] * $W[$t] * $W['xfullcpu'];
      $s += $v[DATA_MEMORY] * $W[$t] * $W['xmem'];      
      $s += $v[DATA_LINES] * $W[$t] * $W['xloc'];
   }
   $score[$k] = array($s/$countWeight,sizeof($Tests)-sizeof($test));
}

unset($Data);

function CompareMean($a, $b){
   if ($a[0] == $b[0]) return 0;
   return  ($a[0] > $b[0]) ? -1 : 1;
}

$C0 = 'class="r"'; 

uasort($score, 'CompareMean');
?>

<tr>

<!-- // SCORECARD LANGUAGE TABLE ///////////////////////////////////// -->

<td>
<table>
<tr>
<th>ratio</th>
<th>language</th>
<th>score</th>
<th>&nbsp;</th>
</tr>

<?  
printf('<tr><th></th><th>best possible</th>');
printf('<th class="r">%0.1f</th><th class="r">&nbsp;0</th>', $possible); 
echo "\n</tr>\n";

$RowClass = 'c';
foreach($score as $k => $v){   
   if (!isset($first)){ $first = $v; }
   if ($v[0]==0){ $ratio = 0; }
   else { $ratio = $first[0]/$v[0]; }

   $Name = $Langs[$k][LANG_FULL];
   $HtmlName = $Langs[$k][LANG_HTML];
   printf('<tr class="%s">',$RowClass); 
   printf('<td>%s</td>', PFx($ratio)); 

   printf('<td><a href="benchmark.php?test=all&amp;lang=%s&amp;lang2=%s">%s</a></td>', 
      $k,$k,$HtmlName); echo "\n";
   printf('<td class="r">%0.1f</td><td class="r">%d</td>',
      $v[0], $v[1]); echo "\n";
   echo "</tr>\n";
   if ($RowClass=='a'){ $RowClass='c'; } else { $RowClass='a'; } 
}
?>

</table>
</td>


<!-- // SCORECARD FORM /////////////////////////////////////////// -->

<td>
<form method="get" action="benchmark.php">
<div>
<input type="hidden" name="test" value="all" />
<input type="hidden" name="lang" value="all" />

<table>
<tr class="c">
<td><p><input type="submit" name="calc" value="Calculate" /></p></td>
<td><p><input type="submit" name="calc" value="Reset" /></p></td>
</tr>

<tr><th class="b" colspan="2">multipliers</th></tr>

<!--
<tr class="a">
<td><a href="faq.php#cpu">CPU Time</a></td>
<td><p><input type="text" size="2" name="xcpu" value="<?=$W['xcpu'];?>" /></p></td>
</tr>
-->

<tr class="a">
<td><a href="faq.php#fullcpu">Full CPU Time</a></td>
<td><p><input type="text" size="2" name="xfullcpu" value="<?=$W['xfullcpu'];?>" /></p></td>
</tr>
<tr class="a">
<td><a href="faq.php#memory">Memory Use</a></td>
<td><p><input type="text" size="2" name="xmem" value="<?=$W['xmem'];?>" /></p></td>
</tr>
<tr class="a">
<td><a href="faq.php#codelines">Code Lines</a></td>
<td><p><input type="text" size="2" name="xloc" value="<?=$W['xloc'];?>" /></p></td>
</tr>

<!-- THIS IS JUST FOR SPACING! SHOULD USE CSS! -->
<tr class="c"><td>&nbsp;</td><td>&nbsp;</td></tr>
<tr><th>benchmark</th><th>weight</th></tr>

<?  
$RowClass = 'a';
foreach($Tests as $t){
   $Link = $t[TEST_LINK];
   $Name = $t[TEST_NAME];
   $weight = $W[ $t[TEST_LINK] ];

   printf('<tr class="%s">',$RowClass); echo "\n";
   printf('<td><a href="benchmark.php?test=%s&amp;lang=all">%s</a></td>', $Link,$Name); echo "\n";
   printf('<td><p><input type="text" size="2" name="%s" value="%d" /></p></td>', $Link, $weight); echo "\n";
   echo "</tr>\n";
}
?>

<tr class="c">
<td><p><input type="submit" name="calc" value="Calculate" /></p></td>
<td><p><input type="submit" name="calc" value="Reset" /></p></td>
</tr>

</table>
</div>
</form>
</td>
</tr>


<!-- // ABOUT /////////////////////////////////////////////////// -->

<tr><td colspan="2"><h4 class="rev"><a class="arev" href="#about" name="about">&nbsp;about the Overall Scores</a></h4></td></tr>
<tr><td colspan="2"><?=$About;?></td></tr>  
</table>