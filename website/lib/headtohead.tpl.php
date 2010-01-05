<?   // Copyright (c) Isaac Gouy 2004-2010 ?>

<?
   list($data,$sTests,$ratios,$measurements) = $Data;
   unset($Data);
?>

<?
$Row = $Langs[$SelectedLang];
$LangName = $Row[LANG_FULL];
$NoSpaceLangName = str_replace(' ','&nbsp;',$LangName);
$LangTag = $Row[LANG_TAG];
$LangName2 = $Langs[$SelectedLang2][LANG_FULL];
$LangLink = $Row[LANG_LINK];
$LangLink2 = $Langs[$SelectedLang2][LANG_LINK];
$Family = $Row[LANG_FAMILY];

$ExplanatoryHeader = '&nbsp;<strong>'.$LangName.'</strong>&nbsp;<b>used</b> what fraction? <b>used</b> how many times more?&nbsp;';
?>

<? MkHeadToHeadMenuForm($Tests,$SelectedTest,$Langs,$SelectedLang,$SelectedLang2); ?>


<h2><a href="#faster-programs-chart" name="faster-programs-chart">&nbsp;Step&nbsp;1&nbsp;:&nbsp;Are the <strong><?=$LangName;?> programs faster</strong>?</a> <i>At a glance.</i></h2>

<p>This chart shows 3 <em>comparisons</em> - Time-used, Memory-used and Code-used ~ speed and size.</p>
<p>Each chart bar shows, for one unidentified benchmark, how much the fastest <strong><?=$LangName;?></strong> program <i>used</i> compared to the fastest <?=$LangName2;?> program.</p>

<p><br/><img src="chartvs.php?<?='r='.Encode($ratios);?>&amp;<?='m='.Encode($Mark.' n');?>&amp;<?='w='.Encode($SelectedLang.'O'.$SelectedLang2);?>"
   alt=""
   title=""
   width="480" height="300"
 /></p>


<h2><a href="#faster-programs-approximately" name="faster-programs-approximately">&nbsp;Step&nbsp;2&nbsp;:&nbsp;Are the <strong><?=$LangName;?> programs faster</strong>?</a> <i>Approximately.</i></h2>

<p>This table shows 3 <em>comparisons</em> - Time-used, Memory-used and Code-used ~ speed and size.</p>

<p>Each table row shows, for one named benchmark, how much the fastest <strong><?=$LangName;?></strong> program <i>used</i> compared to the fastest <?=$LangName2;?> program.</p>

<table>
<colgroup span="1" class="txt"></colgroup>
<colgroup span="4" class="num"></colgroup>

<tr><th colspan="5"><?=$ExplanatoryHeader;?></th></tr>

<tr>
<th>Benchmark</th>
<th><a href="<?=CORE_SITE;?>help.php#time" title="? Help">Time</a></th>
<th><a href="<?=CORE_SITE;?>help.php#memory" title="? Help">Memory</a></th>
<th><a href="<?=CORE_SITE;?>help.php#gzbytes" title="? Help">Code</a></th>
<th><a href="<?=CORE_SITE;?>help.php#inputvalue" title="? Help">Reduced&nbsp;N</a></th>
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

<h2><a href="#faster-programs-measurements" name="faster-programs-measurements">&nbsp;Step&nbsp;3&nbsp;:&nbsp;Are the <strong><?=$LangName;?> programs faster</strong>?</a> <em>Measurements.</em></h2>

<p>This table shows 5 <em>measurements</em> - <a href="<?=CORE_SITE;?>help.php#time" title="? Help">CPU&nbsp;Time</a>, <a href="<?=CORE_SITE;?>help.php#time" title="? Help">Elapsed&nbsp;Time</a>, <a href="<?=CORE_SITE;?>help.php#memory" title="? Help">Memory</a>, <a href="<?=CORE_SITE;?>help.php#gzbytes" title="? Help">Code</a> and <a href="<?=CORE_SITE;?>help.php#cpuloadpercent" title="? Help">&asymp;&nbsp;CPU&nbsp;Load</a> ~ speed and size.</p>

<p>For each named benchmark, measurements of <strong><i>the</i> <em>fastest</em> <?=$LangName;?></strong> program are shown for comparison against measurements of <i>the</i> <em>fastest</em> <?=$LangName2;?> program.</p>

<table>
<tr>
<th>Program&nbsp;Source&nbsp;Code</th>
<th><a href="<?=CORE_SITE;?>help.php#time" title="? Help">CPU&nbsp;secs</a></th>
<th><a href="<?=CORE_SITE;?>help.php#time" title="? Help">Elapsed&nbsp;secs</a></th>
<th><a href="<?=CORE_SITE;?>help.php#memory" title="? Help">Memory&nbsp;KB</a></th>
<th><a href="<?=CORE_SITE;?>help.php#gzbytes" title="? Help">Code&nbsp;B</a></th>
<th><a href="<?=CORE_SITE;?>help.php#cpuloadpercent" title="? Help">&asymp;&nbsp;CPU&nbsp;Load</a></th>
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
         $n = ' N&nbsp;=&nbsp;'.number_format($data[$Link][N_N]).'&nbsp;reduced&nbsp;workload';
      }
      printf('<tr><th class="txt" colspan="3">&nbsp;<a name="%s" href="benchmark.php?test=%s&amp;lang=all" title="Measurements for all the %s benchmark programs">%s</a><span class="smaller">%s</span>&nbsp;</th><th colspan="3"></th></tr>', $Link, $Link, $TestName, $TestName, $n);

      $ELAPSED = '';
      if (isset($measurements[$Link][1]) && ($measurements[$Link][0][DATA_TIME] < $measurements[$Link][1][DATA_TIME])){
         $ELAPSED = ' class="sort"';
      }

      $firstRow = True;
      foreach($measurements[$Link] as $Row){
         $k = $Row[DATA_LANG];
         $Name = $Langs[$k][LANG_FULL];
         $NoSpaceName = str_replace(' ','&nbsp;',$Name);
         $id = $Row[DATA_ID];
         
         if ($firstRow){ $tag0 = '<strong>'; $tag1 = '</strong>'; $firstRow = False; }
         else { $tag0 = ''; $tag1 = ''; }

         printf('<tr><td><a href="benchmark.php?test=%s&amp;lang=%s&amp;id=%d" title="Read the Program Source Code : %s %s">%s%s%s</a></td>',
               $Link,$k,$id,$Name,$TestName,$tag0,$NoSpaceName,$tag1);

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
      printf('<tr><th class="txt" colspan="3">&nbsp;<a name="%s" href="benchmark.php?test=%s&amp;lang=all" title="Measurements for all the %s benchmark programs">%s</a></th><th colspan="3"></th></tr>', $Link, $Link, $TestName, $TestName);

      if (isset($data[$Link])){
         printf('<tr><td><a href="benchmark.php?test=%s&amp;lang=%s&amp;id=%d" title="Read the Program Source Code : %s %s"><strong>%s</strong></a></td><td colspan="2"><span class="message">%s</span></td><td colspan="3"></td></tr>', $Link,$SelectedLang,$data[$Link][N_ID],$Langs[$SelectedLang][LANG_FULL],$TestName,$NoSpaceLangName,StatusMessage($data[$Link][N_LINES]));
      } else {
         printf('<tr><td>&nbsp;</td><td colspan="2"><span class="message">&nbsp;&nbsp;%s</span></td><td colspan="3"></td></tr>', 'No&nbsp;program');
      }
   }
}

?>

</table>


<h2><a href="#measurements" name="measurements">&nbsp;Step&nbsp;4&nbsp;:&nbsp;Are there other <strong><?=$LangName;?> programs</strong> for these benchmarks?</a></h2>
<p>Remember - those are just the fastest <em><?=$LangName;?></em> and <i><?=$LangName2;?></i> programs measured on this OS/machine. <b>Check</b> if there are other implementations of these benchmark programs for <?=$LangName;?>.</p>
<? MkLangsMenuForm($Langs,$SelectedLang); ?>

<p>Maybe one of those other <?=$LangName;?> programs is fastest on <a href="<?=CORE_SITE;?>help.php#compare" title="? Help">a different OS/machine</a>.</p>


<h2><a href="#measurements" name="measurements">&nbsp;Step&nbsp;5&nbsp;:&nbsp;Are there other faster programs for these benchmarks?</a></h2>
<p>Remember - those are just the fastest <em><?=$LangName;?></em> and <i><?=$LangName2;?></i> programs measured on this OS/machine. <b>Check</b> if there are faster implementations of these benchmark programs for other programming languages.</p>
<? MkTestsMenuForm($Tests,$SelectedTest); ?>
<p>Maybe one of those other programs is fastest on <a href="<?=CORE_SITE;?>help.php#compare" title="? Help">a different OS/machine</a>.</p>


<h3><a href="#about" name="about">&nbsp;<strong><?=$LangName;?></strong></a>&nbsp;:&nbsp;<?=$LangTag;?>&nbsp;</h3>
<p></p>
<?=$About;?>
