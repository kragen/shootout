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

$ExplanatoryHeader = '&nbsp;<strong>'.$LangName.'</strong>&nbsp;used what fraction? <strong>used</strong> how many times more?&nbsp;';
?>

<? MkHeadToHeadMenuForm($Tests,$SelectedTest,$Langs,$SelectedLang,$SelectedLang2,"fullcpu"); ?>

<h2><a href="#title" name="title">&nbsp;Are the <?=$LangName;?> programs faster?</a></h2>

<p>Do the <?=$LangName;?> programs use optimized assembly code libraries? Are they small simple programs or very optimized programs? <strong>Do the <?=$LangName;?> programs use a fraction of the time used by others</strong>, or do they use several times more? </p>


<p><br/><img src="chartvs.php?<?='r='.Encode($ratios);?>&amp;<?='m='.Encode($Mark.' n');?>&amp;<?='w='.Encode($SelectedLang.'O'.$SelectedLang2);?>"
   alt=""
   title=""
   width="480" height="300"
 /></p>


<table>
<colgroup span="1" class="txt"></colgroup>
<colgroup span="4" class="num"></colgroup>

<tr><th colspan="5"><?=$ExplanatoryHeader;?></th></tr>

<tr>
<th>Programs</th>
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
         printf('<tr><td><a href="#%s">&darr;&nbsp;%s</a></td>',
            $Link, $Name);

         if ($v[N_N]==0){ $n = '<td></td>';
         } else { $n = '<td class="smaller">&nbsp;'.number_format($v[N_N]).'</td>'; }

         if ($Name=='startup'){ $kb = 1.0; } else { $kb = $v[N_MEMORY]; }

         printf('%s%s%s%s</tr>', PF($v[N_FULLCPU]), PF($kb), PF($v[N_GZ]), $n);
      }
   }
}
?>
</table>
<p><span class="num2">&#177;</span> look at the measurements and then <strong>look at the programs</strong>.<br/></p>

<h2><a href="#measurements" name="measurements">&nbsp;Are the <?=$LangName;?> programs faster?</a></h2>

<p></p>
<table>
<tr>
<th>Program &amp; Logs</th>
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
   $Name = $Row[TEST_NAME];

   if (isset($measurements[$Link])){
      if ($data[$Link][N_N]==0){
         $n = '';
      } else {
         $n = '&nbsp;N&nbsp;=&nbsp;'.number_format($data[$Link][N_N]).'&nbsp;reduced&nbsp;workload';
      }
      printf('<tr><th class="txt" colspan="3">&nbsp;<a name="%s" href="benchmark.php?test=%s&amp;lang=all">%s</a>%s&nbsp;</th><th colspan="3"></th></tr>', $Link, $Link, $Name, $n);

      $ELAPSED = '';
      if (isset($measurements[$Link][1]) && ($measurements[$Link][0][DATA_TIME] < $measurements[$Link][1][DATA_TIME])){
         $ELAPSED = ' class="sort"';
      }

      foreach($measurements[$Link] as $Row){
         $k = $Row[DATA_LANG];
         $Name = $Langs[$k][LANG_FULL];
         $id = $Row[DATA_ID];

         printf('<tr><td><a href="benchmark.php?test=%s&amp;lang=%s&amp;id=%d">%s</a></td>',
               $Link,$k,$id,$Langs[$k][LANG_HTML]);

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

<h3><a href="#about" name="about">&nbsp;<?=$LangName;?></a>&nbsp;:&nbsp;<?=$LangTag;?>&nbsp;</h3>
<p></p>
<?=$About;?>
