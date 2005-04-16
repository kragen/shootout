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
<h4 class="rev"><h4 class="rev"><a class="arev" href="#bench" name="bench"><?=$TestName;?> benchmark <?=DASH.SortName($Sort);?></a></h4>
<p><?=$TestTag;?> <?=$NString;?>&nbsp;(Other values of N are shown in the <a href="sidebyside.php?test=<?=$SelectedTest;?>&amp;p1=<?=$P1;?>&amp;p2=<?=$P2;?>&amp;p3=<?=$P3;?>&amp;p4=<?=$P4;?>&amp;sort=<?=$Sort;?>" 
title="Choose programs for side-by-side comparison">side-by-side comparison</a>.)
</p>
</td></tr>
</table>

<?  
// FILTER & SORT DATA ////////////////////////////////////////
// Sort according to current sort criteria, bold the sort-column
$C1 = 'class="r"'; 
$C2 = 'class="r"'; 
$C3 = 'class="r"';
$C4 = 'class="r"';

if ($Sort=='cpu'){ 
   $C1 = 'class="rb"';    
} elseif ($Sort=='fullcpu'){ 
   $C2 = 'class="rb"';    
} elseif ($Sort=='kb'){ 
   $C3 = 'class="rb"';
} elseif ($Sort=='lines'){ 
   $C4 = 'class="rb"';
} 
?>


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
<? // STARTUP TEST IS A SPECIAL CASE
   if ($SelectedTest==STARTUP){
      echo "&nbsp;\n"; 
   } else {
      printf('<a href="benchmark.php?test=%s&amp;lang=%s&amp;sort=cpu" ', $SelectedTest,$SelectedLang); echo "\n"; 
      printf('title="Sort by Full CPU Time minus Startup Time">sort</a>'); echo "\n"; 
   }
?>
</th>
<th>
   <a href="benchmark.php?test=<?=$SelectedTest;?>&amp;lang=<?=$SelectedLang;?>&amp;sort=lines" 
   title="Sort by Code Lines">sort</a>
</th>
</tr>

<tr>
<th>Program &amp; Logs</th>
<th>Full&nbsp;CPU Time&nbsp;s</th>
<th>Memory Use&nbsp;KB</th>
<th>CPU Time&nbsp;s</th>
<th>Code Lines</th>
</tr>

<? 
foreach($Langs as $k => $v){ $No_Program_Langs[$k] = TRUE; }

$RowClass = 'c';
foreach($Accepted as $d){
   $k = $d[DATA_LANG];      
   unset($No_Program_Langs[$k]);    
   $Name = $Langs[$k][LANG_FULL];
   $HtmlName = $Langs[$k][LANG_HTML].IdName($d[DATA_ID]);  

   $id = $d[DATA_ID];   
   $cpu = $d[DATA_CPU];
   $fullcpu = $d[DATA_FULLCPU];
   if ($d[DATA_MEMORY]==0){ $kb = '?'; } else { $kb = number_format((double)$d[DATA_MEMORY]); }
   $lines = $d[DATA_LINES];

   printf('<tr class="%s">',$RowClass); echo "\n";
   printf('<td><a href="benchmark.php?test=%s&amp;lang=%s&amp;id=%d&amp;sort=%s" title="%s program and logs for the %s performance benchmark">%s</a></td>', 
      $SelectedTest,$k,$id,$Sort,$Name,$TestName,$HtmlName); echo "\n";

   if ($SelectedTest==STARTUP){
      printf('<td %s>%0.2f</td><td %s>%s</td><td>&nbsp;</td><td %s>%d</td>',
         $C2, $fullcpu, $C3, $kb, $C4, $lines); echo "\n";
   } else {
      printf('<td %s>%0.2f</td><td %s>%s</td><td %s>%0.2f</td><td %s>%d</td>',
         $C2, $fullcpu, $C3, $kb, $C1, $cpu, $C4, $lines); echo "\n";
   }

   echo "</tr>\n";
   if ($RowClass=='a'){ $RowClass='c'; } else { $RowClass='a'; } 
}
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
                    
         printf('<td><a href="benchmark.php?test=%s&amp;lang=%s&amp;id=%d&amp;sort=%s" title="%s program and logs for the %s performance benchmark">%s</a></td>', 
            $SelectedTest,$k,$id,$Sort,$Name,$TestName,$HtmlName); echo "\n";

         if ($fullcpu==PROGRAM_TIMEOUT){ $message = 'Timout'; }
         if ($fullcpu==PROGRAM_ERROR){ $message = 'Error'; }             
         printf('<td class="r">%s</td><td></td><td></td><td class="r">%d</td>', $message, $lines);   
       
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
   echo '<tr><th colspan="5">interesting alternative programs</th></tr>', "\n";

   $RowClass = 'c';
   foreach($Special as $d){
      $k = $d[DATA_LANG];         
      $Name = $Langs[$k][LANG_FULL];
      $HtmlName = $Langs[$k][LANG_HTML];
      if ($d[DATA_ID]>0){ $HtmlName .= ' #'.$d[DATA_ID]; }   
     
      $id = $d[DATA_ID];   
      $cpu = $d[DATA_CPU];
      $fullcpu = $d[DATA_FULLCPU];
      if ($d[DATA_MEMORY]==0){ $kb = '?'; } else { $kb = number_format((double)$d[DATA_MEMORY]); }
      $lines = $d[DATA_LINES];

      printf('<tr class="%s">',$RowClass); echo "\n";
      printf('<td><a href="benchmark.php?test=%s&amp;lang=%s&amp;id=%d&amp;sort=%s" title="Alternative %s implementation for the %s benchmark">%s</a></td>', 
         $SelectedTest,$k,$id,$Sort,$Name,$TestName,$HtmlName); echo "\n";

      if ($fullcpu > PROGRAM_TIMEOUT){
         if ($SelectedTest==STARTUP){
            printf('<td class="r">%0.2f</td><td class="r">%s</td><td class="r">&nbsp;</td><td class="r">%d</td>',
               $fullcpu, $kb, $lines); echo "\n";

         } else {
            printf('<td class="r">%0.2f</td><td class="r">%s</td><td class="r">%0.2f</td><td class="r">%d</td>',
               $fullcpu, $kb, $cpu, $lines); echo "\n";
         }
      }
      else {
         if ($fullcpu==PROGRAM_TIMEOUT){ $message = 'Timout'; }
         if ($fullcpu==PROGRAM_ERROR){ $message = 'Error'; }             
         printf('<td class="r">%s</td><td></td><td></td><td class="r">%d</td>', $message, $lines);         
      }
      echo "</tr>\n";
      if ($RowClass=='a'){ $RowClass='c'; } else { $RowClass='a'; } 
   }
}
?>


<? // MISSING PROGRAMS TABLE //////////////////////////

if (sizeof($No_Program_Langs)>0){
   echo '<tr><td colspan="5">&nbsp;</td></tr>', "\n";  // BAD using rows for spacing
   echo '<tr><th colspan="5">missing programs</th></tr>', "\n";
      
   foreach($Langs as $k => $v){
      $no_program = isset($No_Program_Langs[$k]);        
      if ($no_program){  
         printf('<tr class="%s">',$RowClass); echo "\n";             
         $Name = $v[LANG_FULL];
         $HtmlName = $v[LANG_HTML];            

         printf('<td><a href="benchmark.php?test=%s&amp;lang=%s&amp;sort=%s" title="No %s program has been written for the %s performance benchmark">%s</a></td>', 
            $SelectedTest,$k,$Sort,$Name,$TestName,$HtmlName); echo "\n";

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

<tr><td><h4 class="rev"><a class="arev" href="#about" name="about">&nbsp;about the <?=$TestName;?> benchmark</a></h4></td></tr>
<tr><td>
<?=$About;?>
</td></tr>
</table>