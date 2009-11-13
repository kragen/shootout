<?   // Copyright (c) Isaac Gouy 2004-2009 ?>

<?
$p = array($P1,$P2,$P3,$P4);
list($NData,$Selected,$TestValues) = ComparisonData($Langs,$Data,$p,$Excl);

$cols = sizeof($TestValues);
$TestName = $Tests[$SelectedTest][TEST_NAME];
$TestTag = $Tests[$SelectedTest][TEST_TAG];

$SelectedLangs = array();
for($k=0;$k<sizeof($p);$k++){
   if (isset($Selected[$k])){
      $SelectedLangs[] = $Selected[$k][N_LANG];
   }
}

$rows[] = $TestValues;
$n = sizeof($TestValues);
for($k=0;$k<sizeof($p);$k++){
   if (isset($Selected[$k])){
      $row = $Selected[$k];
      $vs = array();
      for ($i=0;$i<$n;$i++){
         $vs[] = isset($Selected[$k]) ? $row[N_ID] : NO_VALUE;
      }
      $rows[] = $vs;
   }
}
for($k=0;$k<sizeof($p);$k++){
   if (isset($Selected[$k])){
      $row = $Selected[$k];
      $vs = array();
      for ($i=0;$i<$n;$i++){
         $vs[] = isset($row[N_FULLCPU][$i]) ? $row[N_FULLCPU][$i] : NO_VALUE;
      }
      $rows[] = $vs;
   }
}
for($k=0;$k<sizeof($p);$k++){
   if (isset($Selected[$k])){
      $row = $Selected[$k];
      $vs = array();
      for ($i=0;$i<$n;$i++){
         $vs[] = isset($row[N_MEMORY][$i]) ? $row[N_MEMORY][$i] : NO_VALUE;
      }
      $rows[] = $vs;
   }
}
?>


<? MkComparisonMenuForm($Langs,$Tests,$SelectedTest,$NData,$P1,$P2,$P3,$P4,"fullcpu"); ?>

<h2><a href="#chart" name="chart">&nbsp;<?=$TestName;?> - Time and Memory Use as workload N increases</a></h2>

<p><br/><img src="chartfull.php?<?='v='.Encode($rows);?>&amp;<?='m='.Encode($Mark);?>&amp;<?='w='.Encode($SelectedLangs);?>&amp;<?='ww='.Encode($SelectedTest);?>"
   alt=""
   title=""
   width="480" height="300"
 /></p>


<table class="data">
<colgroup span="1" class="txt"></colgroup>
<colgroup span="<?=$cols;?>" class="num"></colgroup>
<tr>
<th></th>
<th colspan="<?=$cols;?>"><a href="faq.php#measurecpu">&nbsp;Time secs&nbsp;</a></th>
<th colspan="<?=$cols;?>"><a href="faq.php#memory">&nbsp;Memory&nbsp;Use&nbsp;KB&nbsp;</a></th>
</tr>
<tr>
<th>Program &amp; Logs</th>
<?
foreach($TestValues as $v){
   if ($v>0){ $fv = number_format((double)$v); } else { $fv = '?'; }
      printf('<th>%s</th>',$fv); echo "\n";
}
foreach($TestValues as $v){
   if ($v>0){ $fv = number_format((double)$v); } else { $fv = '?'; }
      printf('<th>%s</th>',$fv); echo "\n";
}
?>
</tr>
<?
foreach($NData as $row){
   printf('<tr>'); echo "\n";
   printf('<td>&nbsp;<a href="benchmark.php?test=%s&amp;lang=%s&amp;id=%d">%s</a></td>',
      $SelectedTest,$row[N_LANG],$row[N_ID],$row[N_HTML]); echo "\n";

   for($k=0;$k<$cols;$k++){
      if (isset($row[N_FULLCPU][$k])){
         printf('<td class="r">%0.2f</td>', $row[N_FULLCPU][$k]);
      } else {
         printf('<td>&nbsp;</td>');
      }
   }
   for($k=0;$k<$cols;$k++){
      if (isset($row[N_MEMORY][$k])){
         $v = $row[N_MEMORY][$k];
         if ($TestName=='startup'){ $kb = '&nbsp;'; }
         else {
            if ($v==0){ $kb = '?'; }
            else { $kb = number_format((double)$v); }
         }
         printf('<td class="r">%s</td>', $kb);
      } else {
         printf('<td>&nbsp;</td>');
      }
   }
   printf('</tr>'); echo "\n";
}
?>
</table>

<h3><a href="#about" name="about">&nbsp;about full data comparison</a></h3>
<?=$About;?>
