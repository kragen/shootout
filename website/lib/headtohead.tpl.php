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

$ExplanatoryHeader = '&nbsp;'.$LangName.'&nbsp;<strong>used</strong> what fraction? used how many times more?&nbsp;';
?>

<? MkHeadToHeadMenuForm($Tests,$SelectedTest,$Langs,$SelectedLang,$SelectedLang2,"fullcpu"); ?>

<h2><a href="#title" name="title"><?=$ExplanatoryHeader;?></a></h2>

<p>Do the <?=$LangName;?> programs use a fraction of the time used by others, or do the <?=$LangName;?> programs use several times more? <strong>What fraction? How many times more?</strong> Do they trade-off memory for time? Are they small simple programs or very optimized programs?</p>


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

$noprogram = array();
$nocomparison = array();
$failed = array();

foreach($sTests as $row){
   if ($row[TEST_WEIGHT]<=0){ continue; }
   $Link = $row[TEST_LINK];
   $Name = $row[TEST_NAME];
   if (isset($data[$Link])){
      $v = $data[$Link];
      if ($v[N_LINES] < 0){
         if ($v[N_LINES] == NO_COMPARISON){
            $nocomparison[] = array($Link,$SelectedLang,$v[N_ID],$Name,'No '.$Langs[$v[N_LANG]][LANG_FULL]);

         } else {
            $failed[] = array($Link,$SelectedLang,$v[N_ID],$Name,StatusMessage($v[N_LINES]) );
         }
      }
   } else {
      $noprogram[] = array($Link,$SelectedLang,0,$Name,'No&nbsp;program');
   }
}

foreach($noprogram as $tr){
   printf('<tr><td class="smaller">&nbsp;&nbsp;%s</td><td colspan="3"><span class="message">%s</span></td><td></td></tr>',
      $tr[3],$tr[4]);
}

foreach($nocomparison as $tr){
      printf('<tr><td><a href="#%s">&darr;&nbsp;%s</a></td><td colspan="3"><span class="message">%s</span></td><td></td></tr>',
      $tr[0],$tr[3],$tr[4]);
}

foreach($failed as $tr){
      printf('<tr><td>&nbsp;&nbsp;<a href="benchmark.php?test=%s&amp;lang=%s&amp;id=%d">%s</a></td><td colspan="3"><span class="message">%s</span></td><td></td></tr>',
      $tr[0],$tr[1],$tr[2],$tr[3],$tr[4]);
}

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

<h2><a href="#measurements" name="measurements">&nbsp;measurements</a></h2>

<p></p>
<table>
<tr>
<th>Program &amp; Logs</th>
<th><a href="help.php#measurecpu">CPU&nbsp;secs</a></th>
<th><a href="help.php#memory">Memory&nbsp;KB</a></th>
<th><a href="help.php#gzbytes">Code&nbsp;B</a></th>
<th><a href="help.php#measurecpu">Elapsed&nbsp;secs</a></th>
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
      printf('<tr><th class="txt" colspan="4">&nbsp;<a name="%s" href="benchmark.php?test=%s&amp;lang=all">%s</a>%s&nbsp;</th><th></th><th></th></tr>', $Link, $Link, $Name, $n);


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

         printf('<td>%s</td><td>%s</td><td>%d</td><td>%s</td><td class="smaller">&nbsp;&nbsp;%s</td></tr>', $fc, $kb, $gz, $e, $ld);
      }
      if (sizeof($measurements[$Link])<2){
         printf('<td></td><td colspan="3"><span class="message">No %s</span></td><td></td><td></td></tr>', $LangName2);
      }
   }
   else {

//print_r($Link);
   }
}
?>
</table>

<h3><a href="#about" name="about">&nbsp;<?=$LangName;?></a>&nbsp;:&nbsp;<?=$LangTag;?>&nbsp;</h3>
<p></p>
<?=$About;?>
