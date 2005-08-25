<?   // Copyright (c) Isaac Gouy 2004, 2005 ?>

<?
if (LANGS_PHRASE){ $LangsPhrase = LANGS_PHRASE; } else { $LangsPhrase = ''; }
if (TESTS_PHRASE){ $TestsPhrase = TESTS_PHRASE; } else { $TestsPhrase = ''; }
?>

<!-- // TAG /////////////////////////////////////////////////// -->

<table class="div" >
<tr><td colspan="2"><?=$Intro;?></td></tr>
<tr><td colspan="2"><?=$NavBar;?></td></tr>

<tr><td><h4 class="rev"><a class="arev" href="#bench" name="bench">&nbsp;<?=$Headline;?></a></h4></td></tr>
<tr><td>
<p class="rs">Most recent measurement: 
<strong><? printf('%s', gmdate("d M Y, l,", $Measured)) ?></strong>
<? printf(' %s GMT', gmdate("g:i a", $Measured)) ?>
</p>
<?=$Furthermore;?>
</td></tr>
</table>

<!-- // TABLE ////////////////////////////////////////////// -->

<table class="div" >
<tr>
<th class="a">
<a class="ab" href="#check" name="check"><strong>1&nbsp;Check</strong></a>
<p class="thp">Source-code, CPU times</p>
</th>

<th class="c" colspan="2">
<a class="ab" href="#compare" name="compare"><strong>2&nbsp;Compare</strong></a>
<p class="thp">Relative performance on all benchmarks</p>
</th>
</tr>

<tr><td>
<?
   foreach($Tests as $Row){
      $TestLink = $Row[TEST_LINK];
      $TestName = $Row[TEST_NAME];
      $TestTag = $Row[TEST_TAG];

      //printf('<p class="a"><a title="Check CPU times and source-code for the %s benchmark"', $TestName);
      printf('<p class="a"><a ');      
      printf('href="benchmark.php?test=%s&amp;lang=all&amp;sort=%s">%s</a><br/><span class="s">%s</span></p>', $TestLink,$Sort,$TestName,$TestTag); 
      echo "\n";
   }
?>
</td>

<td>
<?
   $count = 0; $showFeature = true; 
   
   if (HOMEPAGE_ROWS>0){ $maxRows = HOMEPAGE_ROWS; }
   else { $maxRows = sizeof($Tests)-2; }   
   
   foreach($Langs as $Row){
      $LangLink = $Row[LANG_LINK];
      $LangName = $Row[LANG_FULL];
      $LangTag = $Row[LANG_TAG];           
            
      if ($count < $maxRows){ $count++; } else { $count = 0; echo "</td><td>\n"; }      
                  
      //printf('<p><a title="Compare %s with another language on all benchmarks"', $LangName);
      printf('<p><a ', $LangName);      
      printf('href="benchmark.php?test=all&amp;lang=%s&amp;sort=%s">%s</a><br/><span class="s">%s</span></p>', $LangLink,$Sort,$LangName,$LangTag); 
      echo "\n";
   }
?>
</td></tr>

</table>


<!-- // SCORECARD /////////////////////////////////////////////////// -->

<table class="div" >
<tr><th class="a">
<a class="ab" href="#play" name="play"><strong>3&nbsp;Have fun!</strong></a> <span class="s">Create your own overall scores</span>
</th></tr>

<tr class="a"><td class="center">
<? MkScorecardMenuForm($Sort); ?>
</td></tr>
<tr><td>&nbsp;</td></tr>
</table>

<!-- // ABOUT /////////////////////////////////////////////////// -->

<table class="div">
<tr><td><h4 class="rev"><a class="arev" href="#about" name="about">&nbsp;about <?=$AboutName;?></a></h4></td></tr>
<tr><td><?=$About;?></td></tr>  

</table>