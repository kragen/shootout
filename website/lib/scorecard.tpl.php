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

$possibleMedian = 100.0 *
   (($W['xfullcpu']>0.0 ? 1.0 : 0.0) + 
   ($W['xmem']>0.0 ? 1.0 : 0.0) + 
   ($W['xloc']>0.0 ? 1.0 : 0.0));

$medians = MedianScores($Data,$W);

// CALCULATE WEIGHTED SCORES /////////////////////////////////////

foreach($Data as $k => $test){
   $s = 0.0;
   foreach($test as $t => $v){
      $s += $v[DATA_FULLCPU] * $W[$t] * $W['xfullcpu'];
      $s += $v[DATA_MEMORY] * $W[$t] * $W['xmem'];      
      $s += $v[DATA_LINES] * $W[$t] * $W['xloc'];
   }
   $score[$k] = array($s/$countWeight,sizeof($Tests)-sizeof($test),$medians[$k]);
}

unset($Data);

function CompareMean($a, $b){
   if ($a[0] == $b[0]) return 0;
   return  ($a[0] > $b[0]) ? -1 : 1;
}

function CompareMissing($a, $b){
   if ($a[1] == $b[1]) return 0;
   return  ($a[1] > $b[1]) ? -1 : 1;
}

function CompareMedian($a, $b){
   if ($a[2] == $b[2]) return 0;
   return  ($a[2] > $b[2]) ? -1 : 1;
}

$C0 = 'class="r"';
$C1 = 'class="r"'; 
$C2 = 'class="r"'; 
if ($Sort=='mean'){ 
   uasort($score, 'CompareMean');
   $C0 = 'class="rb"';    
} elseif ($Sort=='missing'){ 
   uasort($score, 'CompareMissing');
   $C1 = 'class="rb"';
} elseif ($Sort=='median'){ 
   uasort($score, 'CompareMedian');
   $C2 = 'class="rb"';
}  


?>

<tr>

<!-- // SCORECARD LANGUAGE TABLE ///////////////////////////////////// -->

<td>
<table>

<tr>
<th class="c">&nbsp;</th>
<th>
   <a href="benchmark.php?test=all&amp;lang=all&amp;sort=median" 
   title="Sort by Median Score">sort</a>
</th>
<th>
   <a href="benchmark.php?test=all&amp;lang=all&amp;sort=mean" 
   title="Sort by Weighted Mean Score">sort</a>
</th>
<th>
   <a href="benchmark.php?test=all&amp;lang=all&amp;sort=missing" 
   title="Sort by Missing Programs">sort</a>
</th>
</tr>

<tr>
<th>language</th>
<th <?=$C2;?>>&nbsp;median&nbsp;</th>
<th <?=$C0;?>>&nbsp;mean&nbsp;</th>
<th <?=$C1;?>>&nbsp;missing&nbsp;</th>
</tr>

<?  
echo "<tr><th>best possible</th>\n";
printf('<th class="r">%0.1f</th><th class="r">%0.1f</th><th class="r">0</th>', $possibleMedian, $possible); 
echo "\n</tr>\n";

$RowClass = 'c';
foreach($score as $k => $v){   
   $Name = $Langs[$k][LANG_FULL];
   $HtmlName = $Langs[$k][LANG_HTML];
   printf('<tr class="%s">',$RowClass); echo "\n";
   printf('<td><a href="benchmark.php?test=all&amp;lang=%s&amp;lang2=%s">%s</a></td>', 
      $k,$k,$HtmlName); echo "\n";
   printf('<td %s>%0.1f</td><td %s>%0.1f</td><td %s>%d</td>',
      $C2, $v[2], $C0, $v[0], $C1, $v[1]); echo "\n";
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
<input type="hidden" name="sort" value=<?=$Sort;?> />

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
$RowClass = 'c';
foreach($Tests as $t){
   $Link = $t[TEST_LINK];
   $Name = $t[TEST_NAME];
   $weight = $W[ $t[TEST_LINK] ];

   printf('<tr class="%s">',$RowClass); echo "\n";
   printf('<td><a href="benchmark.php?test=%s&amp;lang=all">%s</a></td>', $Link,$Name); echo "\n";
   printf('<td><p><input type="text" size="2" name="%s" value="%d" /></p></td>', $Link, $weight); echo "\n";
   echo "</tr>\n";
   if ($RowClass=='a'){ $RowClass='c'; } else { $RowClass='a'; } 
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