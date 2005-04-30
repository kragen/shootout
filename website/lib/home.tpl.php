<?   // Copyright (c) Isaac Gouy 2004, 2005 ?>

<?
if (LANGS_PHRASE){ $LangsPhrase = LANGS_PHRASE; } else { $LangsPhrase = ''; }
if (TESTS_PHRASE){ $TestsPhrase = TESTS_PHRASE; } else { $TestsPhrase = ''; }
?>

<!-- // TAG /////////////////////////////////////////////////// -->

<table class="div" >
<tr><td colspan="2"><?=$Intro;?></td></tr>
<tr><td colspan="2"><?=$NavBar;?></td></tr>

<!--  <? if (!$slim){ printf('<tr><td colspan="2">%s</td></tr>', $NavBar); } ?>  -->

<tr><td><h4 class="rev"><a class="arev" href="#bench" name="bench">&nbsp;Benchmarking programming languages</a></h4></td></tr>
<tr><td>
<p class="rs"><strong>Most recent measurement: </strong><? printf('%s GMT', gmdate("l, M d, Y g:i a", $Measured)) ?></p>
<p>Do due diligence - <em>check the program source-code</em>.</p>
</td></tr>
</table>

<!-- // TABLE ////////////////////////////////////////////// -->

<table class="div" >
<tr>
<th class="a">
<a class="ab" href="#compare" name="compare"><strong>1&nbsp;Compare</strong></a>
<p class="thp">source-code, CPU time</p>
</th>

<th class="c" colspan="2">
<a class="ab" href="#check" name="check"><strong>2&nbsp;Check the rankings</strong></a>
<p class="thp">rankings and language information</p>
</th>
</tr>

<tr><td>
<?
   foreach($Tests as $Row){
      $TestLink = $Row[TEST_LINK];
      $TestName = $Row[TEST_NAME];
      $TestTag = $Row[TEST_TAG];

      printf('<p class="a"><a title="%s performance measurements"', $TestName);
      printf('href="benchmark.php?test=%s&amp;lang=all&amp;sort=%s">%s</a><br/><span class="s">%s</span></p>', $TestLink,$Sort,$TestName,$TestTag); 
      echo "\n";
   }
?>
</td>

<td>
<?
   $count = 0; $showFeature = true;
   foreach($Langs as $Row){
      $LangLink = $Row[LANG_LINK];
      $LangName = $Row[LANG_FULL];
      $LangTag = $Row[LANG_TAG];
      
      if (SITE_NAME == 'core' && $showFeature && $count == 0){
         echo $Feature;
         $showFeature = false;
      }            
      
      if ($count < HOMEPAGE_ROWS){ $count++; } else { $count = 0; echo "</td><td>\n"; }      
                  
      printf('<p class="c"><a title="%s benchmark rankings and information"', $LangName);
      printf('href="benchmark.php?test=all&amp;lang=%s&amp;sort=%s">%s</a><br/><span class="s">%s</span></p>', $LangLink,$Sort,$LangName,$LangTag); 
      echo "\n";
   }
?>
</td></tr>

</table>


<!-- // SCORECARD /////////////////////////////////////////////////// -->

<table class="div" >
<tr><th class="a">
<a class="ab" href="#faster" name="faster"><strong>3&nbsp;Find&nbsp;your </strong>Fast Faster Fastest programming languages</a>
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