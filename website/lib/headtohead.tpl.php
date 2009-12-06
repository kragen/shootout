<?   // Copyright (c) Isaac Gouy 2004-2009 ?>

<?
   list($data,$sTests,$ratios,$measurements) = $Data;
   unset($Data);
?>

<?
$Row = $Langs[$SelectedLang];
$LangName = $Row[LANG_FULL];
$LangTag = $Row[LANG_TAG];
$LangName2 = $Langs[$SelectedLang2][LANG_FULL];
$LangLink = $Row[LANG_LINK];
$LangLink2 = $Langs[$SelectedLang2][LANG_LINK];
$Family = $Row[LANG_FAMILY];

$ExplanatoryHeader = '&nbsp;<strong>'.$LangName.'</strong>&nbsp;used what fraction? <b>used</b> how many times more?&nbsp;';
?>

<? MkHeadToHeadMenuForm($Tests,$SelectedTest,$Langs,$SelectedLang,$SelectedLang2,"fullcpu"); ?>


<h2><a href="#ataglance" name="ataglance">&nbsp;1&nbsp;:&nbsp;<strong>Are the <?=$LangName;?> programs faster?</strong></a> <i>At a glance.</i></h2>

<p>This chart shows 3 <em>comparisons</em> - Time-used, Memory-used and Code-used.</p>
<p>Each chart bar shows, for one unidentified benchmark, how much the fastest <strong><?=$LangName;?></strong> program <i>used</i> compared to the fastest <?=$LangName2;?> program.</p>


<!-- <p>Do the <?=$LangName;?> programs use optimized assembly code libraries? Are they small simple programs or very optimized programs? <b>Do the <strong><?=$LangName;?></strong> programs use a fraction of the time used by other programs</b> or do they use several times more?</p> -->


<p><br/><img src="chartvs.php?<?='r='.Encode($ratios);?>&amp;<?='m='.Encode($Mark.' n');?>&amp;<?='w='.Encode($SelectedLang.'O'.$SelectedLang2);?>"
   alt=""
   title=""
   width="480" height="300"
 /></p>


<h2><a href="#approximately" name="approximately">&nbsp;2&nbsp;:&nbsp;<strong>Are the <?=$LangName;?> programs faster?</strong></a> <i>Approximately.</i></h2>

<p>This table shows 3 <em>comparisons</em> - Time-used, Memory-used and Code-used.</p>

<p>Each table row shows, for one named benchmark, how much the fastest <strong><?=$LangName;?></strong> program <i>used</i> compared to the fastest <?=$LangName2;?> program.</p>

<table>
<colgroup span="1" class="txt"></colgroup>
<colgroup span="4" class="num"></colgroup>

<tr><th colspan="5"><?=$ExplanatoryHeader;?></th></tr>

<tr>
<th>Benchmark</th>
<th><a href="help.php#measurecpu">Time</a></th>
<th><a href="help.php#memory">Memory</a></th>
<th><a href="help.php#gzbytes">Code</a></th>
<th><a href="help.php#nmeans">Reduced&nbsp;N</a></th>
</tr>


<?

foreach($sTests as $Row){
   if ($Row[TEST_WEIGHT]<=0){ continue; }

   $Link = $Row[TEST_LINK];
   $Name = $Row[TEST_NAME];

   if (isset($data[$Link])){
      $v = $data[$Link];

      if ($v[N_LINES] >= 0){
         printf('<tr><td>&nbsp;%s</td>', $Name);

         if ($v[N_N]==0){ $n = '<td></td>';
         } else { $n = '<td class="smaller">&nbsp;'.number_format($v[N_N]).'</td>'; }

         if ($Name=='startup'){ $kb = 1.0; } else { $kb = $v[N_MEMORY]; }

         printf('%s%s%s%s</tr>', PF($v[N_FULLCPU]), PF($kb), PF($v[N_GZ]), $n);
      }
   }
}
?>
</table>
<p><span class="num2">&#177;</span> read the measurements and then read the program source code.<br/></p>

<h2><a href="#measurements" name="measurements">&nbsp;3&nbsp;:&nbsp;<strong>Are the <?=$LangName;?> programs faster?</strong></a> <em>Measurements.</em></h2>

<p>This table shows <em>measurements</em> - <a href="help.php#measurecpu">CPU&nbsp;Time</a>, <a href="help.php#measurecpu">Elapsed&nbsp;Time</a>, <a href="help.php#memory">Memory</a>, <a href="help.php#gzbytes">Code</a> and <a href="help.php#loadstring">~&nbsp;CPU&nbsp;Load</a>.</p>

<p>For each named benchmark, measurements of the fastest <strong><?=$LangName;?></strong> program are shown for comparison against measurements of the fastest <?=$LangName2;?> program.</p>

<table>
<tr>
<th>Program Source Code</th>
<th><a href="help.php#measurecpu">CPU&nbsp;secs</a></th>
<th><a href="help.php#measurecpu">Elapsed&nbsp;secs</a></th>
<th><a href="help.php#memory">Memory&nbsp;KB</a></th>
<th><a href="help.php#gzbytes">Code&nbsp;B</a></th>
<th><a href="help.php#loadstring">~&nbsp;CPU&nbsp;Load</a></th>
</tr>

<?

foreach($sTests as $Row){
   if ($Row[TEST_WEIGHT]<=0){ continue; }

   $Link = $Row[TEST_LINK];
   $TestName = $Row[TEST_NAME];

   if (isset($measurements[$Link])){
      if ($data[$Link][N_N]==0){
         $n = '';
      } else {
         $n = '&nbsp;N&nbsp;=&nbsp;'.number_format($data[$Link][N_N]).'&nbsp;reduced&nbsp;workload';
      }
      printf('<tr><th class="txt" colspan="3">&nbsp;<a name="%s" href="benchmark.php?test=%s&amp;lang=all" title="Measurements for all the %s programs">%s</a>%s&nbsp;</th><th colspan="3"></th></tr>', $Link, $Link, $TestName, $TestName, $n);

      $ELAPSED = '';
      if (isset($measurements[$Link][1]) && ($measurements[$Link][0][DATA_TIME] < $measurements[$Link][1][DATA_TIME])){
         $ELAPSED = ' class="sort"';
      }

      foreach($measurements[$Link] as $Row){
         $k = $Row[DATA_LANG];
         $Name = $Langs[$k][LANG_FULL];
         $id = $Row[DATA_ID];

         printf('<tr><td><a href="benchmark.php?test=%s&amp;lang=%s&amp;id=%d" title="Program Source Code : %s %s">%s</a></td>',
               $Link,$k,$id,$Name,$TestName,$Langs[$k][LANG_HTML]);

         $fc = number_format($Row[DATA_FULLCPU],2);
         if ($Row[DATA_MEMORY]==0){ $kb = '?'; } else { $kb = number_format((double)$Row[DATA_MEMORY]); }
         $gz = $Row[DATA_GZ];
         if ($Row[DATA_ELAPSED]>0){ $e = number_format($Row[DATA_ELAPSED],2); } else { $e = ''; }
         $ld = CpuLoad($Row);

         printf('<td>%s</td><td %s>%s</td><td>%s</td><td>%d</td><td class="smaller">&nbsp;&nbsp;%s</td></tr>', $fc, $ELAPSED, $e, $kb, $gz, $ld);

         $ELAPSED = '';
      }
      if(!isset($measurements[$Link][1])){
         printf('<td></td><td colspan="2"><span class="message">No %s</span></td><td colspan="2"></td><td></td></tr>', $LangName2);
      }
   }
   else {
      printf('<tr><th class="txt" colspan="3">&nbsp;<a name="%s" href="benchmark.php?test=%s&amp;lang=all">%s</a></th><th colspan="3"></th></tr>', $Link, $Link, $Name);

      if (isset($data[$Link])){
         printf('<tr><td><a href="benchmark.php?test=%s&amp;lang=%s&amp;id=%d">%s</a><td colspan="2"><span class="message">%s</span></td><td colspan="3"></td></tr>', $Link,$SelectedLang,$data[$Link][N_ID],$Langs[$SelectedLang][LANG_HTML],StatusMessage($data[$Link][N_LINES]));
      } else {
         printf('<tr><td>&nbsp;</td><td colspan="2"><span class="message">&nbsp;&nbsp;%s</span></td><td colspan="3"></td></tr>', 'No&nbsp;program');
      }
   }
}

?>

</table>

<h3><a href="#about" name="about">&nbsp;<strong><?=$LangName;?></strong></a>&nbsp;:&nbsp;<?=$LangTag;?>&nbsp;</h3>
<p></p>
<?=$About;?>
