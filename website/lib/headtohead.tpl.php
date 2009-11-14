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
$ShortName = $Row[LANG_NAME];
$ShortName2 = $Langs[$SelectedLang2][LANG_NAME];
?>

<p>Compare the performance of <strong><?=$LangName;?></strong> programs against some other language implementation.</p>

<p>For more information about the <?=$Family;?> implementation we measured see
<a href="#about" title="Read about the <?=$LangName;?>language implementation">&darr;&nbsp;about <?=$LangName;?></a>.</p>

<? MkHeadToHeadMenuForm($Tests,$SelectedTest,$Langs,$SelectedLang,$SelectedLang2,"fullcpu"); ?>

<h2><a href="#title" name="title">&nbsp;<?=$LangName;?> comparison summary</a></h2>

<p><br/><img src="chartvs.php?<?='r='.Encode($ratios);?>&amp;<?='m='.Encode($Mark.' n');?>&amp;<?='w='.Encode($SelectedLang.'O'.$SelectedLang2);?>"
   alt=""
   title=""
   width="480" height="300"
 /></p>


<table>
<colgroup span="1" class="txt"></colgroup>
<colgroup span="4" class="num"></colgroup>

<tr><th colspan="5"><sup>1</sup>/<sub>2</sub>&nbsp;<sup>1</sup>/<sub>3</sub>&nbsp;<sup>1</sup>/<sub>4</sub>&nbsp;&#133;&nbsp;<?=$LangName;?> is better</th></tr>

<tr>
<th>Programs</th>
<th><a href="help.php#measurecpu">Time</a></th>
<th><a href="help.php#memory">Memory&nbsp;Use</a></th>
<th><a href="help.php#gzbytes">Source&nbsp;Size</a></th>
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
            $nocomparison[] = array($Link,$SelectedLang,$v[N_ID],$Name,'No '.$Langs[$v[N_LANG]][LANG_NAME]);

         } else {
            $failed[] = array($Link,$SelectedLang,$v[N_ID],$Name,StatusMessage($v[N_LINES]) );
         }
      }
   } else {
      $noprogram[] = array($Link,$SelectedLang,0,$Name,'No&nbsp;program');
   }
}

foreach($noprogram as $tr){
   printf('<tr><td class="smaller">&nbsp;&nbsp;%s</td><td><span class="message">%s</span></td><td></td><td></td><td></td></tr>',
      $tr[3],$tr[4]);
}

foreach($nocomparison as $tr){
      printf('<tr><td class="smaller">&nbsp;&nbsp;%s</td><td>&nbsp;</td><td>&nbsp;</td><td colspan="2"><span class="message">%s</span></td></tr>',
      $tr[3],$tr[4]);
}

foreach($failed as $tr){
      printf('<tr><td class="smaller">&nbsp;&nbsp;%s</td><td><span class="message">%s</span></td><td></td><td></td><td></td></tr>',
      $tr[3],$tr[4]);
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
<p><span class="num2">&#177;</span> look at the measurements<br/></p>

<h2><a href="#measurements" name="measurements">&nbsp;<?=$LangName;?> comparison measurements</a></h2>

<p></p>
<table>
<tr>
<th>Program &amp; Logs</th>
<th><a href="help.php#measurecpu">CPU&nbsp;secs</a></th>
<th><a href="help.php#memory">Memory&nbsp;KB</a></th>
<th><a href="help.php#gzbytes">Size&nbsp;B</a></th>
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

      printf('<tr><th class="txt" colspan="4">&nbsp;<a href="#%s" name="%s">%s</a>%s&nbsp;</th><th></th><th></th></tr>', $Link, $Link, $Name, $n);

      foreach($measurements[$Link] as $Row){
         $k = $Row[DATA_LANG];
         $Name = $Langs[$k][LANG_FULL];
         $HtmlName = $Langs[$k][LANG_FULL].IdName($Row[DATA_ID]);
         $id = $Row[DATA_ID];

         printf('<tr><td><a href="benchmark.php?test=%s&amp;lang=%s&amp;id=%d">%s</a></td>',
               $Link,$k,$id,$HtmlName); 

         $fc = number_format($Row[DATA_FULLCPU],2);
         if ($Row[DATA_MEMORY]==0){ $kb = '?'; } else { $kb = number_format((double)$Row[DATA_MEMORY]); }
         $gz = $Row[DATA_GZ];
         if ($Row[DATA_ELAPSED]>0){ $e = number_format($Row[DATA_ELAPSED],2); } else { $e = ''; }
         $ld = CpuLoad($Row);

         printf('<td>%s</td><td>%s</td><td>%d</td><td>%s</td><td class="smaller">&nbsp;&nbsp;%s</td></tr>', $fc, $kb, $gz, $e, $ld);
      }

   }
}
?>
</table>

<h3><a href="#about" name="about">&nbsp;about <?=$LangName;?></a></h3>
<p></p>
<?=$About;?>
