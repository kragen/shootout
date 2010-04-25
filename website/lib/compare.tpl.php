<?   // Copyright (c) Isaac Gouy 2004-2010


// FUNCTIONS ///////////////////////////////////////////

function MkHeadToHeadMenuForm($Tests,$SelectedTest,$Langs,$SelectedLang,$SelectedLang2){
   echo '<form method="get" action="benchmark.php">', "\n";
   echo '<p><select name="test">', "\n";
   echo '<option value="all">- all ', TESTS_PHRASE, 's -</option>', "\n";

   foreach($Tests as $Row){
      $Link = $Row[TEST_LINK];
      $Name = $Row[TEST_NAME];
      if ($Link==$SelectedTest){
         $Selected = 'selected="selected"';
      } else {
         $Selected = '';
      }
      printf('<option %s value="%s">%s</option>', $Selected,$Link,$Name); echo "\n";
   }
   echo '</select>', "\n";


   echo '<select name="lang">', "\n";
   echo '<option value="all">- all ', LANGS_PHRASE, 's -</option>', "\n";
   foreach($Langs as $Row){
      $Link = $Row[LANG_LINK];
      $Name = $Row[LANG_FULL];
      if ($Link==$SelectedLang){
         $Selected = 'selected="selected"';
      } else {
         $Selected = '';
      }
      printf('<option %s value="%s">%s</option>', $Selected,$Link,$Name); echo "\n";
   }
   echo '</select></p>', "\n";
   
   
   echo '<p><strong>&#247;</strong> <select name="lang2">', "\n";
   foreach($Langs as $Row){
      $Link = $Row[LANG_LINK];
      $Name = $Row[LANG_FULL];
      if ($Link==$SelectedLang2){
         $Selected = 'selected="selected"';
      } else {
         $Selected = '';
      }
      printf('<option %s value="%s">%s</option>', $Selected,$Link,$Name); echo "\n";
   }
   echo '</select>', "\n";   

   echo '<input type="submit" value="Show" />', "\n";
   echo '</p></form>', "\n";
}

function MkLangsMenuForm($Langs,$SelectedLang,$Action='measurements.php'){
   echo '<form method="get" action="'.$Action.'">', "\n";
   echo '<p><select name="lang">', "\n";
   foreach($Langs as $Row){
      $Link = $Row[LANG_LINK];
      $Name = $Row[LANG_FULL];
      if ($Link==$SelectedLang){
         $Selected = 'selected="selected"';
      } else {
         $Selected = '';
      }
      printf('<option %s value="%s">%s</option>', $Selected,$Link,$Name); echo "\n";
   }
   echo '</select>', "\n";
   echo '<input type="submit" value="Show" />', "\n";
   echo '</p></form>', "\n";
}

function MkTestsMenuForm($Tests,$SelectedTest){
   echo '<form method="get" action="performance.php">', "\n";
   echo '<p><select name="test">', "\n";
   foreach($Tests as $Row){
      $Link = $Row[TEST_LINK];
      $Name = $Row[TEST_NAME];
      if ($Link==$SelectedTest){
         $Selected = 'selected="selected"';
      } else {
         $Selected = '';
      }
      printf('<option %s value="%s">%s</option>', $Selected,$Link,$Name); echo "\n";
   }
   echo '</select>', "\n";
   echo '<input type="submit" value="Show" />', "\n";
   echo '</p></form>', "\n";
}

function PF($d){
   $rounded = round($d);
   if ($rounded>15){ return '<td class="num1">'.number_format($rounded).'&#215;</td>'; }
   elseif ($rounded>1){ return '<td class="num2">'.number_format($rounded).'&#215;</td>'; }
   elseif ($d>1.01){ return '<td class="num2">&#177;</td>'; }
   else {
      if ($d>0){
         $i = 1.0 / $d;
         $rounded = round($i);
         if ($rounded>15){ return '<td class="num5"><sup>1</sup>/<sub>'.number_format($rounded).'</sub></td>'; }
         elseif ($rounded>1){ return '<td><sup>1</sup>/<sub>'.number_format($rounded).'</sub></td>'; }
         else { return '<td class="num2">&#177;</td>'; }
      } else {
         return '<td>&nbsp;</td>';
      }
   }
}



// PAGE ////////////////////////////////////////////////

list($sorted,$ratios,$stats) = $Data;
unset($Data);

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
<p>Look at speed another way - <a href="which-programming-languages-are-fastest.php?<?=$SelectedLang;?>=on&amp;<?=$SelectedLang2;?>=on&amp;calc=chart" title="">look at a box plot of Time-used data</a>.</p>

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
</tr>


<?
foreach($sorted as $k => $v){
   $test = $Tests[$k];
   if ($test[TEST_WEIGHT]<=0 || $v[DATA_TIME] == NO_VALUE){ continue; }
   $name = $test[TEST_NAME];
   if (!empty($v)){
      printf('<tr><td>&nbsp;%s</td>', $name);
      if ($v[DATA_MEMORY]==NO_VALUE){
         $kb = '<td class="num2">?</td>';
      } else {
         if ($name=='startup'){ $kb = PF(1.0); }
         else { $kb = PF($v[DATA_MEMORY]); }
      }
      if ($v[DATA_GZ]==NO_VALUE){
         $gz = '<td class="num2">?</td>';
      } else {
         $gz = PF($v[DATA_GZ]);
      }
      
      printf('%s%s%s</tr>', PF($v[DATA_TIME]), $kb, $gz);
   }
}
?>
</table>

<table>
<tr><th colspan="8"><?=$ExplanatoryHeader;?></th></tr>

<tr>
<th><a href="<?=CORE_SITE;?>help.php#time" title="? Help">Time-used</a></th>
<th>&nbsp;|-</th>
<th>&nbsp;|---</th>
<th>&nbsp;25%</th>
<th class="sort">median</th>
<th>&nbsp;75%</th>
<th>&nbsp;---|</th>
<th>&nbsp;-|</th>
</tr>
<tr>
<?
printf('<th>(%s)</th>%s%s%s%s%s%s%s',
      $TimeUsed,
      PF($stats[STAT_MIN]), PF($stats[STAT_XLOWER]), PF($stats[STAT_LOWER]), PF($stats[STAT_MEDIAN]),
      PF($stats[STAT_UPPER]), PF($stats[STAT_XUPPER]), PF($stats[STAT_MAX]));
?>
</tr>
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

foreach($sorted as $k => $rows){
   $test = $Tests[$k];
   if ($test[TEST_WEIGHT]<=0){ continue; }
   $testname = $test[TEST_NAME];

   if (!empty($rows)){

      printf('<tr><th class="txt" colspan="3">&nbsp;<a name="%s" href="performance.php?test=%s" title="Measurements for all the %s benchmark programs">%s</a><span class="smaller">%s</span>&nbsp;</th><th colspan="3"></th></tr>', $k, $k, $testname, $testname, $n);

      $ELAPSED = '';
      if (isset($rows[0]) && isset($rows[1]) && ($rows[0][DATA_TIME] < $rows[1][DATA_TIME])){
         $ELAPSED = ' class="sort"';
      }

      $firstRow = True;
      foreach($rows as $row){
         if ($firstRow){ $tag0 = '<strong>'; $tag1 = '</strong>'; $firstRow = False; }
         else { $tag0 = ''; $tag1 = ''; }         

         if (is_array($row)){
            $lang = $row[DATA_LANG];
            $name = $Langs[$lang][LANG_FULL];
            $noSpaceName = str_replace(' ','&nbsp;',$name);
            $id = $row[DATA_ID];
   
            printf('<tr><td><a href="program.php?test=%s&amp;lang=%s&amp;id=%d" title="Read the Program Source Code : %s %s">%s%s%s</a></td>',
                  $k,$lang,$id,$name,$testname,$tag0,$noSpaceName,$tag1);

            $fc = number_format($row[DATA_FULLCPU],2);
            if ($row[DATA_MEMORY]==0){ $kb = '?'; } else { $kb = number_format($row[DATA_MEMORY]); }
            $gz = $row[DATA_GZ];
            if ($row[DATA_ELAPSED]>0){ $e = number_format($row[DATA_ELAPSED],2); } else { $e = ''; }
            $ld = CpuLoad($row);

            if($row[DATA_STATUS] > PROGRAM_TIMEOUT){
               printf('<td>%s</td><td %s>%s</td><td>%s</td><td>%d</td><td class="smaller">&nbsp;&nbsp;%s</td></tr>', $fc, $ELAPSED, $e, $kb, $gz, $ld);
            } else {
               printf('<td colspan="2"><span class="message">%s</span></td><td colspan="2"></td><td></td></tr>', StatusMessage($row[DATA_STATUS]));
            }
            $ELAPSED = '';

         } elseif (!isset($row)) {
            printf('<td></td><td colspan="2"><span class="message">%s</span></td><td colspan="2"></td><td></td></tr>', 'No&nbsp;program');
         }
      }
   }

   else { // empty($rows)     
      printf('<tr><th class="txt" colspan="3">&nbsp;<a name="%s" href="performance.php?test=%s" title="Measurements for all the %s benchmark programs">%s</a></th><th colspan="3"></th></tr>', $k, $k, $testname, $testname);

      printf('<tr><td>&nbsp;</td><td colspan="2"><span class="message">&nbsp;&nbsp;%s</span></td><td colspan="3"></td></tr>', 'No&nbsp;programs');
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
