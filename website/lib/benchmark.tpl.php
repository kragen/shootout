<?   // Copyright (c) Isaac Gouy 2004, 2005 ?>

<!-- // MENU /////////////////////////////////////////////////// -->
<div>
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
foreach($Accepted as $d){
   if ($d[DATA_TESTVALUE]>0){ $NString = 'N='.number_format((double)$d[DATA_TESTVALUE]); break; }
}
?>
</div>

<!-- // TAG /////////////////////////////////////////////////// -->

<table class="div">
<tr><td>
<h4 class="rev"><a class="arev" href="#bench" name="bench"><?=$TestName;?> <?=TESTS_PHRASE;?> <?=DASH.SortName($Sort);?></a></h4>
<p><a href="#about" title="Read about the <?=$TestName;?> <?=TESTS_PHRASE;?>"><?=$TestTag;?></a> <?=$NString;?>&nbsp;(Check that Error or Timeout happened at other values of N with <a href="fulldata.php?test=<?=$SelectedTest;?>&amp;p1=<?=$P1;?>&amp;p2=<?=$P2;?>&amp;p3=<?=$P3;?>&amp;p4=<?=$P4;?>&amp;sort=<?=$Sort;?>" 
title="Check all the data for the <?=$TestName;?> <?=TESTS_PHRASE;?>"><?=$TestName;?> full data</a>).
</p>
</td></tr>
</table>


<!-- // CHART //////////////////////////////////////////////////// -->

<table class="div">
<tr><td colspan="5">

<img src="chart.php?test=<?=$SelectedTest;?>&amp;lang=<?=$SelectedLang;?>&amp;sort=<?=$Sort;?>"
   alt="<?=SortName($Sort);?> chart for the <?=$TestName;?> performance benchmark"
   title="<?=SortName($Sort);?> chart for the <?=$TestName;?> performance benchmark"
   width="450" height="150"
 />
</td></tr>
</table>



<!-- // BENCHMARK TABLE //////////////////////////////////////// -->
<table class="div">
<tr><td><table>
<tr>
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
   <a href="benchmark.php?test=<?=$SelectedTest;?>&amp;lang=<?=$SelectedLang;?>&amp;sort=lines" 
   title="Sort by Code Lines">sort</a>
</th>
<th>&nbsp;</th>
</tr>

<tr>
<th>Program &amp; Logs</th>
<th>Full&nbsp;CPU Time&nbsp;s</th>
<th>Memory Use&nbsp;KB</th>
<th>Code Lines</th>
<th>&nbsp;Ratio&nbsp;</th>
</tr>

<? 
foreach($Langs as $k => $v){ $No_Program_Langs[$k] = TRUE; }

$RowClass = 'c';
$better = array();
if (sizeof($Accepted) > 0){ $first = $Accepted[0]; }

foreach($Accepted as $d){
   $k = $d[DATA_LANG]; 
   
   $C1 = 'class="r"'; 
   $C2 = 'class="r"'; 
   $C3 = 'class="r"';
   $C4 = 'class="r"';   
   
   if (!isset($better[$k])){  
      $better[$k] = TRUE;
      // Sort according to current sort criteria, bold the sort-column
      if ($Sort=='fullcpu'){ 
         $C2 = 'class="rb"';    
         $ratio = $d[DATA_FULLCPU]/$first[DATA_FULLCPU];
      } elseif ($Sort=='kb'){ 
         $C3 = 'class="rb"';
         $ratio = $d[DATA_MEMORY]/$first[DATA_MEMORY];
      } elseif ($Sort=='lines'){ 
         $C4 = 'class="rb"';
         $ratio = $d[DATA_LINES]/$first[DATA_LINES];
      }    
   }      
        
   unset($No_Program_Langs[$k]);    
   $Name = $Langs[$k][LANG_FULL];
   $HtmlName = $Langs[$k][LANG_HTML].IdName($d[DATA_ID]);  

   $id = $d[DATA_ID];   
   $fullcpu = $d[DATA_FULLCPU];
   if ($d[DATA_MEMORY]==0){ $kb = '?'; } else { $kb = number_format((double)$d[DATA_MEMORY]); }
   $lines = $d[DATA_LINES];

   printf('<tr class="%s">',$RowClass); echo "\n";
   printf('<td><a href="benchmark.php?test=%s&amp;lang=%s&amp;id=%d&amp;sort=%s">%s</a></td>', 
      $SelectedTest,$k,$id,$Sort,$HtmlName); echo "\n";

   printf('<td %s>%0.2f</td><td %s>%s</td><td %s>%d</td><td %s>%s</td>',
         $C2, $fullcpu, $C3, $kb, $C4, $lines, $C1, PFx($ratio) ); echo "\n";

   echo "</tr>\n";
   if ($RowClass=='a'){ $RowClass='c'; } else { $RowClass='a'; } 
}
unset($better);
?>


<? // FAILED PROGRAMS TABLE //////////////////////////
uasort($Langs,'CompareLangName');
foreach($Langs as $k => $v){
   foreach($Rejected as $d){                   
      if ($d[DATA_LANG]==$k){         
         printf('<tr class="%s">',$RowClass); echo "\n";             
         $Name = $v[LANG_FULL];
         $HtmlName = $v[LANG_HTML];    
         if ($d[DATA_ID]>0){ $HtmlName .= ' #'.$d[DATA_ID]; }             
                    
         $id = $d[DATA_ID];                      
         $fullcpu = $d[DATA_FULLCPU];
         $lines = $d[DATA_LINES];     
                    
         printf('<td><a href="benchmark.php?test=%s&amp;lang=%s&amp;id=%d&amp;sort=%s">%s</a></td>', 
            $SelectedTest,$k,$id,$Sort,$HtmlName); echo "\n";

         if ($fullcpu==PROGRAM_TIMEOUT){ $message = 'Timout'; }
         if ($fullcpu==PROGRAM_ERROR){ $message = 'Error'; }             
         printf('<td class="r">%s</td><td></td><td class="r">%d</td><td></td>', $message, $lines);   
       
         echo "</tr>\n";
         if ($RowClass=='a'){ $RowClass='c'; } else { $RowClass='a'; }    
         unset($No_Program_Langs[$k]);         
      }  
   }    
}
?>


<!-- // SPECIAL PROGRAMS TABLE //////////////////////////////////////// -->
<?
if (sizeof($Special)>0){
   echo '<tr><td colspan="5">&nbsp;</td></tr>', "\n";   // BAD using rows for spacing 
   echo '<tr><th colspan="5"><a class="ab" href="#alt" name="alt">interesting alternative programs</a></th></tr>', "\n";

   $RowClass = 'c';
   foreach($Special as $d){
      $k = $d[DATA_LANG];         
      $Name = $Langs[$k][LANG_FULL];
      $HtmlName = $Langs[$k][LANG_HTML];
      if ($d[DATA_ID]>0){ $HtmlName .= ' #'.$d[DATA_ID]; }   

      if ($Sort=='fullcpu'){ 
         $ratio = $d[DATA_FULLCPU]/$first[DATA_FULLCPU];
      } elseif ($Sort=='kb'){ 
         $ratio = $d[DATA_MEMORY]/$first[DATA_MEMORY];
      } elseif ($Sort=='lines'){ 
         $ratio = $d[DATA_LINES]/$first[DATA_LINES];
      } 
     
      $id = $d[DATA_ID];   
      $cpu = $d[DATA_CPU];
      $fullcpu = $d[DATA_FULLCPU];
      if ($d[DATA_MEMORY]==0){ $kb = '?'; } else { $kb = number_format((double)$d[DATA_MEMORY]); }
      $lines = $d[DATA_LINES];

      printf('<tr class="%s">',$RowClass); echo "\n";
      printf('<td><a href="benchmark.php?test=%s&amp;lang=%s&amp;id=%d&amp;sort=%s"">%s</a></td>', 
         $SelectedTest,$k,$id,$Sort,$HtmlName); echo "\n";

      if ($fullcpu > PROGRAM_TIMEOUT){
            printf('<td class="r">%0.2f</td><td class="r">%s</td><td class="r">%d</td><td class="r">%s</td>',
               $fullcpu, $kb, $lines, PFx($ratio) ); echo "\n";
      }
      else {
         if ($fullcpu==PROGRAM_TIMEOUT){ $message = 'Timout'; }
         if ($fullcpu==PROGRAM_ERROR){ $message = 'Error'; }             
         printf('<td class="r">%s</td><td></td><td class="r">%d</td><td></td>', $message, $lines);         
      }
      echo "</tr>\n";
      if ($RowClass=='a'){ $RowClass='c'; } else { $RowClass='a'; } 
   }
}
?>


<? // MISSING PROGRAMS TABLE //////////////////////////

if (sizeof($No_Program_Langs)>0){
   echo '<tr><td colspan="5">&nbsp;</td></tr>', "\n";  // BAD using rows for spacing
   echo '<tr><th colspan="5"><a class="ab" href="#missing" name="missing">missing programs</a></th></tr>', "\n";
      
   foreach($Langs as $k => $v){
      $no_program = isset($No_Program_Langs[$k]);        
      if ($no_program){  
         printf('<tr class="%s">',$RowClass); echo "\n";             
         $Name = $v[LANG_FULL];
         $HtmlName = $v[LANG_HTML];            

         printf('<td><a href="benchmark.php?test=%s&amp;lang=%s&amp;sort=%s">%s</a></td>', 
            $SelectedTest,$k,$Sort,$HtmlName); echo "\n";

         echo '<td class="r">No&nbsp;program</td><td></td><td></td><td></td>';       
         echo "</tr>\n";

         if ($RowClass=='a'){ $RowClass='c'; } else { $RowClass='a'; }          
      }                                                      
   }     
}

echo '<tr><td colspan="5">&nbsp;</td></tr>', "\n";  // BAD using rows for spacing
?>


</table></td></tr>

<!-- // ABOUT /////////////////////////////////////////////////// -->

<tr><td><h4 class="rev"><a class="arev" href="#about" name="about">&nbsp;about the <?=$TestName;?> <?=TESTS_PHRASE;?></a></h4></td></tr>
<tr><td>
<?=$About;?>
</td></tr>
</table>