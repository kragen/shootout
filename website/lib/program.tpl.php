<?   // Copyright (c) Isaac Gouy 2004 ?>


<!-- // MENU /////////////////////////////////////////////////// -->

<div>
<? 
MkMenuForm($Tests,$SelectedTest,$Langs,$SelectedLang,$Sort); 
$TestName = $Tests[$SelectedTest][TEST_NAME];
$LangName = $Langs[$SelectedLang][LANG_FULL];

$P = $SelectedLang.'-'.$Id;
?>
</div>



<!-- // TAG /////////////////////////////////////////////////// -->

<table class="div">

<tr><td>
<h4 class="rev">&nbsp;<?=$Title;?></h4>
<p>
<a href="benchmark.php?test=<?=$SelectedTest;?>&lang=all&sort=<?=$Sort;?>"
title="Compare performance on the <?=$TestName;?> benchmark" ><?=$TestName;?> benchmark</a> 
<?=BAR;?>
<a href="benchmark.php?test=all&lang=<?=$SelectedLang;?>&sort=<?=$Sort;?>"  
title="Check all the rankings for <?=$LangName;?>" >
<?=$LangName;?> rankings</a>
<?=BAR;?>
<a href="sidebyside.php?test=<?=$SelectedTest;?>&p1=<?=$P;?>&p2=<?=$P;?>&p3=<?=$P;?>&p4=<?=$P;?>&sort=<?=$Sort;?>"  
title="Choose programs for side-by-side comparison" >Side-by-side</a>
</p>
</td></tr>


<!-- // SUMMARY TABLE //////////////////////////////////////// -->

<tr><td><table>

<tr>
<th>CPU Time&nbsp;s</th>
<th>Full&nbsp;CPU Time&nbsp;s</th>
<th>Memory Use&nbsp;KB</th>
<th>Code Lines</th>
</tr>


<?
if (isset($Data[$SelectedLang])){   
   foreach($Data[$SelectedLang] as $d){                 
      if ($Id==$d[DATA_ID]){             
         if ($d[DATA_FULLCPU]>0){
            if ($d[DATA_MEMORY]==0){ 
               $kb = '?'; 
            } else { 
               $kb = number_format((double)$d[DATA_MEMORY]); 
            }

            if ($SelectedTest==STARTUP){ 
               $cpu = '&nbsp;'; 
            } else { 
               $cpu = sprintf('%0.2f',$d[DATA_CPU]); 
            }         
            $fullcpu = sprintf('%0.2f',$d[DATA_FULLCPU]);
         } else {
            $kb = '&nbsp;'; $fullcpu = '&nbsp;';
            if ($d[DATA_FULLCPU]==PROGRAM_TIMEOUT){ $cpu = 'Timout'; }
            if ($d[DATA_FULLCPU]==PROGRAM_ERROR){ $cpu = 'Error'; }         
         }
         
         printf('<tr class="a"><td class="r">%s</td><td class="r">%s</td><td class="r">%s</td><td class="r">%d</td></tr>', 
            $cpu,$fullcpu,$kb,$d[DATA_LINES]); echo "\n";
      }
   }
} else {
   echo '<tr class="a"><td></td> <td></td> <td></td> <td></td></tr>'; echo "\n";
}        
?>

</table></td></tr>
</table>

<!-- // SOURCE CODE //////////////////////////////////////// -->

<table class="div">

<tr><td><pre><?=$Code;?></pre></td></tr> 


<!-- // BUILD ///////////////////////////////////////////////// -->

<table class="div">
<tr><td>
<h4 class="rev">&nbsp;build & benchmark results</h4>
</td></tr>
</table>

<table class="div">
<tr><td><pre><?=$Log;?></pre></td></tr>
</table> 


<!-- // ABOUT /////////////////////////////////////////////////// -->

<table class="div">
<tr><td><h4 class="rev">&nbsp;about the program</h4></td></tr>
<tr><td><?=$About;?></td></tr>  
</table>