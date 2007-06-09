<?   // Copyright (c) Isaac Gouy 2004-2006 ?>

<? 
MkMenuForm($Tests,$SelectedTest,$Langs,$SelectedLang,$Sort); 
$Row = $Tests[$SelectedTest];
$TestName = $Row[TEST_NAME];
$TestTag = $Row[TEST_TAG];

list($Accepted,$Rejected,$Special) = FilterAndSortData($Langs,$Data,$Sort,$Excl);

if (sizeof($Accepted)>0){ $P1 = $Accepted[0][DATA_LANG].'-'.$Accepted[0][DATA_ID]; } 
else { $P1 = ''; }

if (sizeof($Accepted)>1){ $P2 = $Accepted[1][DATA_LANG].'-'.$Accepted[1][DATA_ID]; } 
else { $P2 = ''; }

if (sizeof($Accepted)>2){ $P3 = $Accepted[2][DATA_LANG].'-'.$Accepted[2][DATA_ID]; } 
else { $P3 = ''; }

if (sizeof($Accepted)>3){ $P4 = $Accepted[3][DATA_LANG].'-'.$Accepted[3][DATA_ID]; } 
else { $P4 = ''; }

$NString = 'N=?';
$testValue = 1;
foreach($Accepted as $d){
   if ($d[DATA_TESTVALUE]>0){
      $testValue = (double)$d[DATA_TESTVALUE];
      $NString = 'N='.number_format($testValue);
      break; }
}
if ($TestName=='startup'){ $NString = ''; }

?>


<h2><a href="#bench" name="bench"><?=$TestName;?> <?=TESTS_PHRASE;?></a></h2>
<p>Read <a href="#about" title="Read about the <?=$TestName;?> benchmark">&darr;&nbsp;<strong>the benchmark rules</strong></a>.
<?=$TestTag;?> <?=$NString;?>&nbsp;(Check that Error or Timeout happened at other values of N with <a href="fulldata.php?test=<?=$SelectedTest;?>&amp;p1=<?=$P1;?>&amp;p2=<?=$P2;?>&amp;p3=<?=$P3;?>&amp;p4=<?=$P4;?>" 
title="Check all the data for the <?=$TestName;?> <?=TESTS_PHRASE;?>"><?=$TestName;?> full data</a>).
</p>

<p><img src="chart.php?test=<?=$SelectedTest;?>&amp;lang=<?=$SelectedLang;?>&amp;sort=<?=$Sort;?>"
   alt="<?=SortName($Sort);?> chart for the <?=$TestName;?> performance benchmark"
   title="<?=SortName($Sort);?> chart for the <?=$TestName;?> performance benchmark"
   width="450" height="150"
 /></p>

<table>
<colgroup span="2" class="txt"></colgroup>
<colgroup span="3" class="num"></colgroup>
<tr>
<th class="c">&nbsp;</th>
<th class="c">&nbsp;</th>
<th>
   <a href="benchmark.php?test=<?=$SelectedTest;?>&amp;lang=<?=$SelectedLang;?>&amp;sort=fullcpu" 
   title="Sort by Full CPU Time, including Startup Time">sort</a>
</th>
<th>
   <a href="benchmark.php?test=<?=$SelectedTest;?>&amp;lang=<?=$SelectedLang;?>&amp;sort=kb" 
   title="Sort by Memory Use">sort</a>
</th>
<th>
   <a href="benchmark.php?test=<?=$SelectedTest;?>&amp;lang=<?=$SelectedLang;?>&amp;sort=gz" 
   title="Sort by GZ bytes">sort</a>
</th>
</tr>

<tr>
<th>&nbsp;&nbsp;x&nbsp;&nbsp;</th>
<th>Program &amp; Logs</th>
<th>Full&nbsp;CPU Time&nbsp;s</th>
<th>Memory Use&nbsp;KB</th>
<th>GZip Bytes</th>
</tr>

<? 
foreach($Langs as $k => $v){ $No_Program_Langs[$k] = TRUE; }

$better = array();
if (sizeof($Accepted) > 0){ $first = $Accepted[0]; }

foreach($Accepted as $d){
   $k = $d[DATA_LANG];
   
   $CPU = '';
   $MEM = '';
   $LOCS = ''; 
   $GZBYTES = '';      
   if (!isset($better[$k])){  
      $better[$k] = TRUE;
      // Sort according to current sort criteria, bold the sort-column
      if ($Sort=='fullcpu'){ 
         $CPU = ' class="sort"';    
      } elseif ($Sort=='kb'){ 
         $MEM = ' class="sort"';
      } elseif ($Sort=='lines'){ 
         $LOCS = ' class="sort"';
      } elseif ($Sort=='gz'){ 
         $GZBYTES = ' class="sort"';
      }  
   }      

   if ($Sort=='fullcpu'){   
      if ($first[DATA_FULLCPU]==0){ $ratio = 0; }
      else { $ratio = $d[DATA_FULLCPU]/$first[DATA_FULLCPU]; }
   } elseif ($Sort=='kb'){ 
      if (($TestName=='startup')||($first[DATA_MEMORY]==0)){ $ratio = 0; }
      else { $ratio = $d[DATA_MEMORY]/$first[DATA_MEMORY]; }
   } elseif ($Sort=='lines'){ 
      if ($first[DATA_LINES]==0){ $ratio = 0; }
      else { $ratio = $d[DATA_LINES]/$first[DATA_LINES]; }
   } elseif ($Sort=='gz'){ 
      if ($first[DATA_GZ]==0){ $ratio = 0; }
      else { $ratio = $d[DATA_GZ]/$first[DATA_GZ]; }
   } 
        
   unset($No_Program_Langs[$k]);
   $Name = $Langs[$k][LANG_FULL];
   $HtmlName = $Langs[$k][LANG_HTML].IdName($d[DATA_ID]);

   $id = $d[DATA_ID];
   $fullcpu = $d[DATA_FULLCPU];
   if ($TestName=='startup'){
      $fc = number_format($fullcpu/$testValue,4);
      $kb = '&nbsp;';
   } else { 
      $fc = number_format($fullcpu,2);
      if ($d[DATA_MEMORY]==0){ $kb = '?'; } else { $kb = number_format((double)$d[DATA_MEMORY]); }
   }
   $lines = $d[DATA_LINES];
   $gz = $d[DATA_GZ];

   printf('<tr>'); echo "\n";
   printf('<td>%s</td><td><a href="benchmark.php?test=%s&amp;lang=%s&amp;id=%d">%s</a></td>',
      PFx($ratio),$SelectedTest,$k,$id,$HtmlName); echo "\n";

   printf('<td%s>%s</td><td%s>%s</td><td%s>%d</td>',
         $CPU, $fc, $MEM, $kb, $GZBYTES, $gz ); echo "\n";

   echo "</tr>\n";
}
unset($better);
?>

<? 
uasort($Langs,'CompareLangName');
foreach($Langs as $k => $v){
   foreach($Rejected as $d){                   
      if ($d[DATA_LANG]==$k){         
         printf('<tr>'); echo "\n";             
         $Name = $v[LANG_FULL];
         $HtmlName = $v[LANG_HTML];    
         if ($d[DATA_ID]>0){ $HtmlName .= ' #'.$d[DATA_ID]; }             
                    
         $id = $d[DATA_ID];
         $fullcpu = $d[DATA_FULLCPU];
         $lines = $d[DATA_LINES]; 
         $gz = $d[DATA_GZ];   
                    
         printf('<td></td><td><a href="benchmark.php?test=%s&amp;lang=%s&amp;id=%d">%s</a></td>', 
            $SelectedTest,$k,$id,$HtmlName); echo "\n";

         if ($fullcpu==PROGRAM_TIMEOUT){ $message = 'Timout'; }
         if ($fullcpu==PROGRAM_ERROR){ $message = 'Error'; }             
         printf('<td>%s</td><td></td><td>%d</td>', $message, $gz);   
       
         echo "</tr>\n";   
         unset($No_Program_Langs[$k]);         
      }  
   }    
}
?>

<?
if (sizeof($Special)>0){
   echo '<tr><th colspan="5"><a href="#alt" name="alt">rejected (<em>aka</em> interesting alternative programs)</a></th></tr>', "\n";

   foreach($Special as $d){
      $k = $d[DATA_LANG];         
      $Name = $Langs[$k][LANG_FULL];
      $HtmlName = $Langs[$k][LANG_HTML];
      if ($d[DATA_ID]>0){ $HtmlName .= ' #'.$d[DATA_ID]; }   

      if ($Sort=='fullcpu'){   
         if ($first[DATA_FULLCPU]==0){ $ratio = 0; }
         else { $ratio = $d[DATA_FULLCPU]/$first[DATA_FULLCPU]; }
      } elseif ($Sort=='kb'){ 
         if (($TestName=='startup')||($first[DATA_MEMORY]==0)){ $ratio = 0; }
         else { $ratio = $d[DATA_MEMORY]/$first[DATA_MEMORY]; }
      } elseif ($Sort=='lines'){ 
         if ($first[DATA_LINES]==0){ $ratio = 0; }
         else { $ratio = $d[DATA_LINES]/$first[DATA_LINES]; }
      } 

     
      $id = $d[DATA_ID];   
      $gz = $d[DATA_GZ];
      $fullcpu = $d[DATA_FULLCPU];
      if ($d[DATA_MEMORY]==0){ $kb = '?'; } else { $kb = number_format((double)$d[DATA_MEMORY]); }
      $lines = $d[DATA_LINES];

      printf('<tr>'); echo "\n";
      printf('<td>%s</td><td><a href="benchmark.php?test=%s&amp;lang=%s&amp;id=%d">%s</a></td>', 
         PFx($ratio),$SelectedTest,$k,$id,$HtmlName); echo "\n";

      if ($fullcpu > PROGRAM_TIMEOUT){
            printf('<td>%0.2f</td><td>%s</td><td>%d</td>',
               $fullcpu, $kb, $gz ); echo "\n";
      }
      else {
         if ($fullcpu==PROGRAM_TIMEOUT){ $message = 'Timout'; }
         if ($fullcpu==PROGRAM_ERROR){ $message = 'Error'; }             
         printf('<td>%s</td><td>&nbsp;</td><td>%d</td>', $message, $gz);         
      }
      echo "</tr>\n";
   }
}
?>


<? // MISSING PROGRAMS TABLE //////////////////////////

if (sizeof($No_Program_Langs)>0){
   echo '<tr><th colspan="5"><a href="#missing" name="missing">missing programs</a></th></tr>', "\n";
      
   foreach($Langs as $k => $v){
      $no_program = isset($No_Program_Langs[$k]);        
      if ($no_program){  
         printf('<tr>'); echo "\n";             
         $Name = $v[LANG_FULL];
         $HtmlName = $v[LANG_HTML];            

         printf('<td></td><td><a href="benchmark.php?test=%s&amp;lang=%s">%s</a></td>', 
            $SelectedTest,$k,$HtmlName); echo "\n";

         echo '<td>No&nbsp;program</td><td></td><td></td>';       
         echo "</tr>\n";     
      }                                                      
   }
}
?>
</table>

<h3><a href="#about" name="about">&nbsp;the <?=$TestName;?> <?=TESTS_PHRASE;?> rules</a></h3>
<?=$About;?>
