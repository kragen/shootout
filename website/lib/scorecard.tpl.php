<?   // Copyright (c) Isaac Gouy 2004-2007 ?>

<? MkMenuForm($Tests,$SelectedTest,$Langs,$SelectedLang,"fullcpu"); ?>
<h2><a href="#faster" name="faster">&nbsp;Create your own Ranking</a></h2>


<? 
$minWeight = 0;    // normalize weights
$maxWeight = 5;

foreach($W as $k => $v){
   if ($v > $maxWeight){ $W[$k] = $maxWeight; }
   elseif ($v < $minWeight){ $W[$k] = $minWeight; }
}

$score = array();
foreach($Data as $k => $test){
   $s = 0.0; $ws = 0.0; $include = 0.0;
   foreach($test as $t => $v){

      $w1 = $W[$t] * $W['xfullcpu'];
      $w2 = $W[$t] * $W['xmem'];
      $w3 = $W[$t] * $W['xloc'];

      if ($w1>0){ 
        $val = $v[DATA_FULLCPU];
        $s += log($val)*$w1;
        $ws += $w1;
        $include += $val;
      }

      if ($w2>0){ 
        $val = $v[DATA_MEMORY]; 
        $s += log($val)*$w2;
        $ws += $w2;
        $include += $val;
      }
      if ($w3>0){
        $val = $v[DATA_GZ];
        $s += log($val)*$w3;
        $ws += $w3;
        $include += $val;
      }
   }
   if ($ws == 0.0){ $ws = 1.0; }
   if ($include > 0){ $score[$k] = array(exp($s/$ws),sizeof($Tests)-sizeof($test)); }
}
unset($Data);

function CompareMean($a, $b){
   if ($a[0] == $b[0]) return 0;
   return  ($a[0] < $b[0]) ? -1 : 1;
}

$C0 = 'class="r"';
uasort($score, 'CompareMean');

$r = array();
foreach($score as $k => $v){ 
   if (!isset($first)){ $first = $v[0]; }
   if ($first==0){ $r[] = 0.0; }
   else { $r[] = $v[0]/$first; }
}
?>

<p>What fun! Can you manipulate the multipliers and weights to make your favourite language the best programming language in the Benchmarks Game?</p>


<p><br/><img src="chartscore.php?<?='d='.HttpVarsEncodeArray($r);?>"
   width="450" height="150"
 /></p>



<table class="layout"><tr><td>

<table>
<colgroup span="2" class="txt"></colgroup>
<colgroup span="2" class="num"></colgroup>
<tr>
<th>ratio</th>
<th>language</th>
<th>mean</th>
<th>-</th>
</tr>

<?


foreach($score as $k => $v){
   if (!isset($first)){ $first = $v; }
   if ($first==0){ $ratio = 0; }
   else { $ratio = $v[0]/$first; }

   $Name = $Langs[$k][LANG_FULL];
   $HtmlName = $Langs[$k][LANG_HTML];
   printf('<tr>');
   printf('<td>%s</td>', PFx($ratio));

   printf('<td><a href="benchmark.php?test=all&amp;lang=%s&amp;lang2=%s">%s</a></td>',
      $k,$k,$HtmlName); echo "\n";
   printf('<td>%0.2f</td><td>%s</td>',
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
<td><a href="faq.php#gzbytes">GZip Bytes</a></td>
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

<h3><a href="#about" name="about">&nbsp;about the Ranking</a></h3>
<?=$About;?>
