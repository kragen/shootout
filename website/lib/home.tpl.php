<?   // Copyright (c) Isaac Gouy 2004-2009 ?>
<?
if (LANGS_PHRASE){ $LangsPhrase = LANGS_PHRASE; } else { $LangsPhrase = ''; }
if (TESTS_PHRASE){ $TestsPhrase = TESTS_PHRASE; } else { $TestsPhrase = ''; }

   list($labels,$stats) = $Data;
   unset($Data);
?>

<? MkMenuForm($Tests,'all',$Langs,'all','fullcpu'); ?>

<h3><a href="#benchmarks" name="benchmarks">&nbsp;Benchmarks & Language Implementations</a></h3>

<p>It can be fun to watch the Benchmarks Game and fun to <a href="benchmark.php?test=all&amp;lang=all">create your own ranking</a> but like other games <a href="faq.php#play">it's more fun to <strong>play!</strong></a></p><?=$Intro;?>


<p class="img"><img src="charttests.php?
      <?='d='.HttpVarsEncodeStats($stats);?>&amp;
      <?='mark='.rawurlencode($Mark);?>&amp;
      <?='a='.HttpVarsEncodeLabels($labels);?>"
   alt=""
   title=""
   width="480" height="300"
 /></p>


<p class="timestamp">Most recent measurement: <strong><?=$Mark;?></strong><?=$MTime;?></p>


<table class="layout">
<tr>
<th class="test"><dl>
<dt><a href="#check" name="check"><strong>&nbsp;Benchmarks</strong></a></dt>
<dd>Source-code, CPU times</dd>
</dl></th>

<th colspan="2"><dl>
<dt><a href="#compare" name="compare"><strong>&nbsp;Language Implementations</strong></a></dt>
<dd>Compare two language implementations</dd>
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
         printf('<td class="test"><dl><dt><a href="benchmark.php?test=%s&amp;lang=all">%s</a></dt><dd>%s</dd></dl></td>', $TestLink,$TestName,$TestTag); 
         $i++;  
      }
      else {
         if ($j<$langsSize){

            $l = $Langs[$j];
            $LangLink = $l[LANG_LINK];
            $LangName = $l[LANG_FULL];
            $LangTag = $l[LANG_TAG];  

            if (isset($l[LANG_SPECIALURL]) && !empty($l[LANG_SPECIALURL])){
               printf('<td><dl><dt><a href="%s.php">%s</a></dt><dd>%s</dd></dl></td>', $l[LANG_SPECIALURL],$LangName,$LangTag); 
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
            printf('<td><dl><dt><a href="%s.php">%s</a></dt><dd>%s</dd></dl></td>', $l[LANG_SPECIALURL],$LangName,$LangTag); 
         } else {
            printf('<td><dl><dt><a href="benchmark.php?test=all&amp;lang=%s">%s</a></dt><dd>%s</dd></dl></td>', $LangLink,$LangName,$LangTag); 
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
            printf('<td><dl><dt><a href="%s.php">%s</a></dt><dd>%s</dd></dl></td>', $l[LANG_SPECIALURL],$LangName,$LangTag); 
         } else { 
            printf('<td><dl><dt><a href="benchmark.php?test=all&amp;lang=%s">%s</a></dt><dd>%s</dd></dl></td>', $LangLink,$LangName,$LangTag); 
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
               printf('<td class="test"><dl><dt><a href="benchmark.php?test=%s&amp;lang=all">%s</a></dt><dd>%s</dd></dl></td>', $TestLink,$TestName,$TestTag);
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






