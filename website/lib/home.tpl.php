<?   // Copyright (c) Isaac Gouy 2004 ?>

<?
if (LANGS_PHRASE){ $LangsPhrase = LANGS_PHRASE; } else { $LangsPhrase = ''; }
if (TESTS_PHRASE){ $TestsPhrase = TESTS_PHRASE; } else { $TestsPhrase = ''; }
?>

<!-- // TAG /////////////////////////////////////////////////// -->

<table class="div" >
<tr><td colspan="2">
<p><b>Compare</b> the performance of <?=$LangsPhrase;?> on each of <?=$TestsPhrase;?>. 
Check the <b>rankings</b> for your favourite programming language.</p>
</td></tr>

<tr><td><h4 class="rev">&nbsp;A comparison of programming languages</h4></td></tr>
</table>

<!-- // TABLE ////////////////////////////////////////////// -->

<table class="div" >
<tr>
<th class="a">
<b><?=$TestsPhrase;?></b>
<p class="thp">time, memory, lines</p>
</th>

<th class="c" colspan="2">
<b><?=$LangsPhrase;?></b>
<p class="thp">rankings for each benchmark</p>
</th>
</tr>

<tr><td>
<?
   foreach($Tests as $Row){
      $TestLink = $Row[TEST_LINK];
      $TestName = $Row[TEST_NAME];
      $TestTag = $Row[TEST_TAG];

      printf('<p class="a"><a title="Compare performance on the %s benchmark"', $TestName);
      printf('href="benchmark.php?test=%s&lang=all&sort=%s">%s</a><br/><span class="s">%s</span></p>', $TestLink,$Sort,$TestName,$TestTag); 
      echo "\n";
   }
?>
</td>

<td>
<?
   $count = 0;
   foreach($Langs as $Row){
      $LangLink = $Row[LANG_LINK];
      $LangName = $Row[LANG_FULL];
      $LangTag = $Row[LANG_TAG];
      
      if ($count < HOMEPAGE_ROWS){ $count++; } else { $count = 0; echo "</td><td>\n"; }
      printf('<p class="c"><a title="Check all the rankings for %s"', $LangName);
      printf('href="benchmark.php?test=all&lang=%s&sort=%s">%s</a><br/><span class="s">%s</span></p>', $LangLink,$Sort,$LangName,$LangTag); 
      echo "\n";
   }
?>
</td></tr>
</table>


<!-- // ABOUT /////////////////////////////////////////////////// -->

<table class="div">
<tr><td><h4 class="rev">&nbsp;about <?=$AboutName;?></h4></td></tr>
<tr><td><?=$About;?></td></tr>  

</table>