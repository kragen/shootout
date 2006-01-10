<?   // Copyright (c) Isaac Gouy 2004, 2005 ?>

<?
if (LANGS_PHRASE){ $LangsPhrase = LANGS_PHRASE; } else { $LangsPhrase = ''; }
if (TESTS_PHRASE){ $TestsPhrase = TESTS_PHRASE; } else { $TestsPhrase = ''; }
?>

<!-- // TAG /////////////////////////////////////////////////// -->

<table class="div" >

<tr><td colspan="2"><?=$Intro;?></td></tr>
<tr><td>
<p class="rs">Most recent measurement: 
<strong><? printf('%s', gmdate("d M Y, l,", $Measured)) ?></strong>
<? printf(' %s GMT', gmdate("g:i a", $Measured)) ?></p>
</td></tr>

</table>

<!-- // TABLE ////////////////////////////////////////////// -->

<table class="div" >
<tr>
<th class="a">
<a class="ab" href="#check" name="check"><strong>&nbsp;Benchmarks</strong></a>
<p class="thp">Source-code, CPU times</p>
</th>

<th class="c" colspan="2">
<a class="ab" href="#compare" name="compare"><strong>&nbsp;Language Implementations</strong></a>
<p class="thp">Compare two language implementations</p>
</th>
</tr>

<?
   $Tests = array_values($Tests);
   $i = 0;
   $testsSize = sizeof($Tests); 

   $Langs = array_values($Langs);
   $j = 0;
   $langsSize = sizeof($Langs);

   while ($i<$testsSize||$j<$langsSize){
      printf('<tr>'); 

      if ($i<$testsSize){
         if ($j==$langsSize){ $j++; }         
         $t = $Tests[$i];
         $TestLink = $t[TEST_LINK];
         $TestName = $t[TEST_NAME];
         $TestTag = $t[TEST_TAG];
         printf('<td class="a"><a href="benchmark.php?test=%s&amp;lang=all">%s</a><br/><span class="s">%s</span></td>', $TestLink,$TestName,$TestTag); 
         $i++;  
      }
      else {
         if ($j<$langsSize){

            $l = $Langs[$j];
            $LangLink = $l[LANG_LINK];
            $LangName = $l[LANG_FULL];
            $LangTag = $l[LANG_TAG];  

            if (isset($l[LANG_SPECIALURL]) && !empty($l[LANG_SPECIALURL])){
               printf('<td class="ab"><a href="%s.php">%s</a><br/><span class="s">%s</span></td>', $l[LANG_SPECIALURL],$LangName,$LangTag); 
            } else {
               printf('<td class="ab"><a href="benchmark.php?test=all&amp;lang=%s">%s</a><br/><span class="s">%s</span></td>', $LangLink,$LangName,$LangTag); 
            }
            $j++;
         }
         else {
            printf('<td class="a">&nbsp;</td>');
         }
      }


      if ($j<$langsSize){

         $l = $Langs[$j];
         $LangLink = $l[LANG_LINK];
         $LangName = $l[LANG_FULL];
         $LangTag = $l[LANG_TAG];  

         if (isset($l[LANG_SPECIALURL]) && !empty($l[LANG_SPECIALURL])){
            printf('<td class="ab"><a href="%s.php">%s</a><br/><span class="s">%s</span></td>', $l[LANG_SPECIALURL],$LangName,$LangTag); 
         } else {
            printf('<td class="ab"><a href="benchmark.php?test=all&amp;lang=%s">%s</a><br/><span class="s">%s</span></td>', $LangLink,$LangName,$LangTag); 
         }
         $j++;
      }
      else {
         if ($i<$testsSize){
            
            $t = $Tests[$i];
            $TestLink = $t[TEST_LINK];
            $TestName = $t[TEST_NAME];
            $TestTag = $t[TEST_TAG];
            printf('<td class="a"><a href="benchmark.php?test=%s&amp;lang=all">%s</a><br/><span class="s">%s</span></td>', $TestLink,$TestName,$TestTag); 
            $i++; 
         }
         else {
            if (2*$testsSize>$langsSize){
               printf('<td class="a">&nbsp;</td>');
            }
            else {
               printf('<td class="ab">&nbsp;</td>');
            }
         }
      }


      if ($j<$langsSize){
         $l = $Langs[$j];
         $LangLink = $l[LANG_LINK];
         $LangName = $l[LANG_FULL];
         $LangTag = $l[LANG_TAG]; 

         if (isset($l[LANG_SPECIALURL]) && !empty($l[LANG_SPECIALURL])){
            printf('<td class="ab"><a href="%s.php">%s</a><br/><span class="s">%s</span></td>', $l[LANG_SPECIALURL],$LangName,$LangTag); 
         } else { 
            printf('<td class="ab"><a href="benchmark.php?test=all&amp;lang=%s">%s</a><br/><span class="s">%s</span></td>', $LangLink,$LangName,$LangTag); 
         }
         $j++;
      }
      else {
         if ($i<$testsSize){
            if ($j==$langsSize){
               printf('<td class="ab">&nbsp;</td>');
               $j++;
            }
            else {
               $t = $Tests[$i];
               $TestLink = $t[TEST_LINK];
               $TestName = $t[TEST_NAME];
               $TestTag = $t[TEST_TAG];
               printf('<td class="a"><a href="benchmark.php?test=%s&amp;lang=all">%s</a><br/><span class="s">%s</span></td>', $TestLink,$TestName,$TestTag);  
               $i++;  
            } 
         }
         else {
            if (2*$testsSize>$langsSize){
               printf('<td class="a">&nbsp;</td>');
            }
            else {
               printf('<td class="ab">&nbsp;</td>');
            }
         }
      }


      printf('</tr>');
   }

?>
</table>


<!-- // SCORECARD /////////////////////////////////////////////////// -->

<table class="div" >
<tr><th class="a">
<a class="ab" href="#play" name="play"><strong>&nbsp;Fun and Nonsense!</strong></a> <span class="s">Create your own overall scores</span>
</th></tr>

<tr class="a"><td class="center">
<? MkScorecardMenuForm("fullcpu"); ?>
</td></tr>
<tr><td>&nbsp;</td></tr>
</table>

</table>