<?   // Copyright (c) Isaac Gouy 2004-2006 ?>

<? MkMenuForm($Tests,$SelectedTest,$Langs,$SelectedLang,"fullcpu"); ?>
<h2><a href="#faster" name="faster">&nbsp;Create your own Overall Scores</a></h2>
<p>What fun! <a href="http://en.wikipedia.org/wiki/April_Fool's_Day" title="April Fool's Day defined on Wikipedia"><strong>April Fool's Day</strong></a> all year long! Can you manipulate the multipliers and weights to make your favourite language the fastest programming language in the Shootout?</p>
<p>And remember, languages with more &#215; non-scoring benchmarks (No Program, Error, Timeout) will stay at the bottom of the table!</p>
<p>And remember, "<strong>For every complex problem, there is a solution that is simple, neat, and wrong</strong>."</p>

<? 
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

<table class="layout"><tr><td>

<table>
<colgroup span="2" class="txt"></colgroup>
<colgroup span="2" class="num"></colgroup>
<tr>
<th>ratio</th>
<th>language</th>
<th>score</th>
<th>&#215;</th>
</tr>

<?  
printf('<tr><th></th><th>best possible</th>');
printf('<th>%0.1f</th><th>&nbsp;</th>', $possible); 
echo "\n</tr>\n";

foreach($score as $k => $v){   
   if (!isset($first)){ $first = $v; }
   if ($v[0]==0){ $ratio = 0; }
   else { $ratio = $first[0]/$v[0]; }

   $Name = $Langs[$k][LANG_FULL];
   $HtmlName = $Langs[$k][LANG_HTML];
   printf('<tr>'); 
   printf('<td>%s</td>', PFx($ratio)); 

   printf('<td><a href="benchmark.php?test=all&amp;lang=%s&amp;lang2=%s">%s</a></td>', 
      $k,$k,$HtmlName); echo "\n";
   printf('<td>%0.1f</td><td>%s</td>',
      $v[0], PBlank($v[1])); echo "\n";
   echo "</tr>\n"; 
}
?>
</table>

</td><td>

<form class="score" method="get" action="benchmark.php">
<input type="hidden" name="test" value="all" />
<input type="hidden" name="lang" value="all" />

<table>
<colgroup span="2" class="txt"></colgroup>
<tr>
<td><input type="submit" name="calc" value="Calculate" /></td>
<td><input type="submit" name="calc" value="Reset" /></td>
</tr>

<tr><th colspan="2">multipliers</th></tr>
<tr>
<td><a href="faq.php#fullcpu">Full CPU Time</a></td>
<td><input type="text" size="2" name="xfullcpu" value="<?=$W['xfullcpu'];?>" /></td>
</tr>
<tr>
<td><a href="faq.php#memory">Memory Use</a></td>
<td><input type="text" size="2" name="xmem" value="<?=$W['xmem'];?>" /></td>
</tr>
<tr>
<td><a href="faq.php#codelines">Code Lines</a></td>
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

<tr>
<td><p><input type="submit" name="calc" value="Calculate" /></p></td>
<td><p><input type="submit" name="calc" value="Reset" /></p></td>
</tr>
</table>
</form>

</td></tr></table>

<h3><a href="#about" name="about">&nbsp;about the Overall Scores</a></h3>
<?=$About;?>
