<?   // Copyright (c) Isaac Gouy 2004-2009 ?>
<?
if (LANGS_PHRASE){ $LangsPhrase = LANGS_PHRASE; } else { $LangsPhrase = ''; }
if (TESTS_PHRASE){ $TestsPhrase = TESTS_PHRASE; } else { $TestsPhrase = ''; }

   list($labels,$stats) = $Data;
   unset($Data);
?>

<? 
   $sTests = $Tests;
   uasort($sTests, 'CompareTestName');
   MkMenuForm($sTests,'all',$Langs,'all','fullcpu');
?>

<h2><a href="#box" name="box">&nbsp;<strong>How long do these <strong>benchmark programs</strong> take?</strong></a></h2>

<p>This chart shows one <em>comparison</em> - <a href="help.php#measurecpu">Time-used</a>&nbsp;(Elapsed&nbsp;secs).</p>

<p>Each chart box shows the middle 50% of program times measured for a benchmark, and each horizontal black bar shows the median program time measured.</p>

<p>In some programming languages these benchmark programs take quite a long time!</p>


<p class="img"><img src="charttests.php?<?='s='.Encode($stats);?>&amp;<?='m='.Encode($Mark.' '.SITE_NAME);?>&amp;<?='ww='.Encode($labels);?>"
   alt=""
   title=""
   width="480" height="300"
 /></p>

 
<h2><a href="#measured" name="measured">&nbsp;<strong>The benchmark programs and language implementations</strong></a></h2>

<p>Follow the links to compare measurements for all programs for that <strong>benchmark</strong>.</p>

<p>Also, follow the links to <b>compare 2</b> language implementations directly - one-against-another for all the benchmarks - on Time-used, Memory-used and Code-used.</p>


<p class="timestamp">Most recent measurement: <strong><?=$Mark;?></strong><?=$MTime;?></p>
<table class="layout">
<tr>
<th class="test"><dl>
<dt><a href="#check" name="check"><strong>&nbsp;Benchmarks</strong></a></dt>
<dd>Source-code, CPU times</dd>
</dl></th>

<th colspan="2"><dl>
<dt><a href="#compare" name="compare"><strong>&nbsp;Language Implementations</strong></a></dt>
<dd>Compare 2 language implementations</dd>
</dl></th>
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
         printf('<td class="test"><dl><dt><a href="benchmark.php?test=%s&amp;lang=all" title="Measurements for all the %s benchmark programs">%s</a></dt><dd>%s</dd></dl></td>', $TestLink,$TestName,$TestName,$TestTag);
         $i++;  
      }
      else {
         if ($j<$langsSize){

            $l = $Langs[$j];
            $LangLink = $l[LANG_LINK];
            $LangName = $l[LANG_FULL];
            $LangTag = $l[LANG_TAG];  

            if (isset($l[LANG_SPECIALURL]) && !empty($l[LANG_SPECIALURL])){
               printf('<td><dl><dt><a href="%s.php" title="Compare %s against one other language implementation">%s</a></dt><dd>%s</dd></dl></td>', $l[LANG_SPECIALURL],$LangName,$LangName,$LangTag);
            } else {
               printf('<td><dl><dt><a href="benchmark.php?test=all&amp;lang=%s">%s</a></dt><dd>%s</dd></dl></td>', $LangLink,$LangName,$LangTag);
            }
            $j++;
         }
         else {
            printf('<td class="test">&nbsp;</td>');
         }
      }


      if ($j<$langsSize){

         $l = $Langs[$j];
         $LangLink = $l[LANG_LINK];
         $LangName = $l[LANG_FULL];
         $LangTag = $l[LANG_TAG];  

         if (isset($l[LANG_SPECIALURL]) && !empty($l[LANG_SPECIALURL])){
            printf('<td><dl><dt><a href="%s.php" title="Compare %s against one other language implementation">%s</a></dt><dd>%s</dd></dl></td>', $l[LANG_SPECIALURL],$LangName,$LangName,$LangTag);
         } else {
            printf('<td><dl><dt><a href="benchmark.php?test=all&amp;lang=%s" title="Compare %s against one other language implementation">%s</a></dt><dd>%s</dd></dl></td>', $LangLink,$LangName,$LangName,$LangTag);
         }
         $j++;
      }
      else {
         if ($i<$testsSize){
            
            $t = $Tests[$i];
            $TestLink = $t[TEST_LINK];
            $TestName = $t[TEST_NAME];
            $TestTag = $t[TEST_TAG];
            printf('<td class="test"><dl><dt><a href="benchmark.php?test=%s&amp;lang=all">%s</a></dt><dd>%s</dd></dl></td>', $TestLink,$TestName,$TestTag); 
            $i++; 
         }
         else {
            if (2*$testsSize>$langsSize){
               printf('<td class="test">&nbsp;</td>');
            }
            else {
               printf('<td>&nbsp;</td>');
            }
         }
      }


      if ($j<$langsSize){
         $l = $Langs[$j];
         $LangLink = $l[LANG_LINK];
         $LangName = $l[LANG_FULL];
         $LangTag = $l[LANG_TAG]; 

         if (isset($l[LANG_SPECIALURL]) && !empty($l[LANG_SPECIALURL])){
            printf('<td><dl><dt><a href="%s.php" title="Compare %s against one other language implementation">%s</a></dt><dd>%s</dd></dl></td>', $l[LANG_SPECIALURL],$LangName,$LangName,$LangTag); 
         } else { 
            printf('<td><dl><dt><a href="benchmark.php?test=all&amp;lang=%s" title="Compare %s against one other language implementation">%s</a></dt><dd>%s</dd></dl></td>', $LangLink,$LangName,$LangName,$LangTag);
         }
         $j++;
      }
      else {
         if ($i<$testsSize){
            if ($j==$langsSize){
               printf('<td>&nbsp;</td>');
               $j++;
            }
            else {
               $t = $Tests[$i];
               $TestLink = $t[TEST_LINK];
               $TestName = $t[TEST_NAME];
               $TestTag = $t[TEST_TAG];
               printf('<td class="test"><dl><dt><a href="benchmark.php?test=%s&amp;lang=all" title="Measurements for all the %s benchmark programs">%s</a></dt><dd>%s</dd></dl></td>', $TestLink,$TestName,$TestName,$TestTag);
               $i++;  
            }
         }
         else {
            if (2*$testsSize>$langsSize){
               printf('<td class="test">&nbsp;</td>');
            }
            else {
               printf('<td>&nbsp;</td>');
            }
         }
      }
      printf('</tr>');
   }

?>
</table>






