<?   // Copyright (c) Isaac Gouy 2004 ?>

<!-- // MENU /////////////////////////////////////////////////// -->

<div>
<? 
MkMenuForm($Tests,$SelectedTest,$Langs,$SelectedLang,$Sort); 
$Row = $Tests[$SelectedTest];
$TestName = $Row[TEST_NAME];
$TestTag = $Row[TEST_TAG];

list($Accepted,$Rejected,$Special) = FilterAndSortData($Langs,$Data,$Sort);

if (sizeof($Accepted)>0){ $P = $Accepted[0][DATA_LANG].'-'.$Accepted[0][DATA_ID]; } 
else { $P = ''; }

?>
</div>


<!-- // TAG /////////////////////////////////////////////////// -->

<table class="div">
<tr><td>
<h4 class="rev">&nbsp;<?=$TestName;?> benchmark <?=DASH.SortName($Sort);?></h4>
<p>&nbsp;<?=$TestTag;?>
&nbsp;
<a href="sidebyside.php?test=<?=$SelectedTest;?>&p1=<?=$P;?>&p2=<?=$P;?>&p3=<?=$P;?>&p4=<?=$P;?>&sort=<?=$Sort;?>" 
title="Choose programs for side-by-side comparison">Side-by-side</a>

</p>
</td></tr>
</table>


<?  
// FILTER & SORT DATA ////////////////////////////////////////

// Sort according to current sort criteria, bold the sort-column
$C1 = 'class="r"'; 
$C2 = 'class="r"'; 
$C3 = 'class="r"';
 
if ($Sort=='cpu'){ 
   $C1 = 'class="rb"';    
} elseif ($Sort=='fullcpu'){ 
   $C2 = 'class="rb"';    
} elseif ($Sort=='kb'){ 
   $C3 = 'class="rb"';
} 
?>



<!-- // CHART //////////////////////////////////////////////////// -->

<table class="div">
<tr><td colspan="5">

<?  // MkVmlChart($Accepted,$Sort); // DEPRECATED ?>

<img src="chart.php?test=<?=$SelectedTest;?>&lang=<?=$SelectedLang;?>&sort=<?=$Sort;?>"
   alt="<?=SortName($Sort);?> chart for the <?=$TestName;?> benchmark"
   title="<?=SortName($Sort);?> chart for the <?=$TestName;?> benchmark"
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
<? // STARTUP TEST IS A SPECIAL CASE
   if ($SelectedTest==STARTUP){
      echo "&nbsp;\n"; 
   } else {
      printf('<a href="benchmark.php?test=%s&lang=%s&sort=cpu" ', $SelectedTest,$SelectedLang); echo "\n"; 
      printf('title="Sort by Full CPU Time minus Startup Time">sort</a>'); echo "\n"; 
   }
?>
</th>
<th>
   <a href="benchmark.php?test=<?=$SelectedTest;?>&lang=<?=$SelectedLang;?>&sort=fullcpu" 
   title="Sort by Full CPU Time, including Startup Time">sort</a>
</th>
<th>
   <a href="benchmark.php?test=<?=$SelectedTest;?>&lang=<?=$SelectedLang;?>&sort=kb" 
   title="Sort by Memory Use">sort</a>
</th>
<th class="c">&nbsp;</th>
</tr>

<tr>
<th>Program & Logs</th>
<th>CPU Time&nbsp;s</th>
<th>Full&nbsp;CPU Time&nbsp;s</th>
<th>Memory Use&nbsp;KB</th>
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
   printf('<td><a href="benchmark.php?test=%s&lang=%s&id=%d&sort=%s" title="%s program and logs for the %s benchmark">%s</a></td>', 
      $SelectedTest,$k,$id,$Sort,$Name,$TestName,$HtmlName); echo "\n";

   if ($SelectedTest==STARTUP){
      printf('<td>&nbsp;</td><td %s>%0.2f</td><td %s>%s</td><td class="r">%d</td>',
         $C2, $fullcpu, $C3, $kb, $lines); echo "\n";
   } else {
      printf('<td %s>%0.2f</td><td %s>%0.2f</td><td %s>%s</td><td class="r">%d</td>',
         $C1, $cpu, $C2, $fullcpu, $C3, $kb, $lines); echo "\n";
   }
   echo "</tr>\n";

   if ($RowClass=='a'){ $RowClass='c'; } else { $RowClass='a'; } 
}


// FAILED & MISSING PROGRAMS TABLE //////////////////////////

uasort($Langs,'CompareLangName');
foreach($Langs as $k => $v){

   $no_program = isset($No_Program_Langs[$k]);
   if ($no_program){              
      foreach($Rejected as $d){                   
         if ($d[DATA_LANG]==$k){         
            printf('<tr class="%s">',$RowClass); echo "\n";             
            $Name = $v[LANG_FULL];
            $HtmlName = $v[LANG_HTML];    
            if ($d[DATA_ID]>0){ $HtmlName .= ' #'.$d[DATA_ID]; }             
                      
            $id = $d[DATA_ID];                      
            $fullcpu = $d[DATA_FULLCPU];
            $lines = $d[DATA_LINES];     
                        
            printf('<td><a href="benchmark.php?test=%s&lang=%s&id=%d&sort=%s" title="%s program and logs for the %s benchmark">%s</a></td>', 
               $SelectedTest,$k,$id,$Sort,$Name,$TestName,$HtmlName); echo "\n";

            if ($fullcpu==PROGRAM_TIMEOUT){ $message = 'Timout'; }
            if ($fullcpu==PROGRAM_ERROR){ $message = 'Error'; }             
            printf('<td class="r">%s</td><td></td><td></td><td class="r">%d</td>', $message, $lines);   
            
            echo "</tr>\n";
            if ($RowClass=='a'){ $RowClass='c'; } else { $RowClass='a'; }    
            $no_program = FALSE;         
         }  
      }                            

      if ($no_program){  
         printf('<tr class="%s">',$RowClass); echo "\n";             
         $Name = $v[LANG_FULL];
         $HtmlName = $v[LANG_HTML];            
    
         printf('<td><a href="benchmark.php?test=%s&lang=%s&sort=%s" title="No %s program has been written for the %s benchmark">%s</a></td>', 
            $SelectedTest,$k,$Sort,$Name,$TestName,$HtmlName); echo "\n";

         echo '<td class="r">No&nbsp;program</td><td></td><td></td><td></td>';  
         
         echo "</tr>\n";
         if ($RowClass=='a'){ $RowClass='c'; } else { $RowClass='a'; }          
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
      printf('<td><a href="benchmark.php?test=%s&lang=%s&id=%d&sort=%s" title="Alternative %s implementation for the %s benchmark">%s</a></td>', 
         $SelectedTest,$k,$id,$Sort,$Name,$TestName,$HtmlName); echo "\n";

      if ($SelectedTest==STARTUP){
         printf('<td class="r">&nbsp;</td><td class="r">%0.2f</td><td class="r">%s</td><td class="r">%d</td>',
            $fullcpu, $kb, $lines); echo "\n";
      } else {
         printf('<td class="r">%0.2f</td><td class="r">%0.2f</td><td class="r">%s</td><td class="r">%d</td>',
            $cpu, $fullcpu, $kb, $lines); echo "\n";
      }
      echo "</tr>\n";

      if ($RowClass=='a'){ $RowClass='c'; } else { $RowClass='a'; } 
   }
   
   echo '<tr><td colspan="5">&nbsp;</td></tr>', "\n";  // BAD using rows for spacing   
}
?>

</table></td></tr>

<!-- // ABOUT /////////////////////////////////////////////////// -->

<tr><td><h4 class="rev">&nbsp;about the <?=$TestName;?> benchmark</h4></td></tr>
<tr><td>
<?=$About;?>
</td></tr>


</table>