<?   // Copyright (c) Isaac Gouy 2011


// PAGE ////////////////////////////////////////////////

list($sorted,$ratios,$stats) = $Data;
unset($Data);
unset($ratios);
unset($stats);
?>

<ul>
<li><?=$VersionLang;?></li>
<li><?=$VersionLang2;?></li>
</ul>

<p>Compare x86 Ubuntu one-core elapsed time measurements for 10 tiny tasks:</p>

<ul>
<?
foreach($sorted as $k => $rows){
   $test = $Tests[$k];
   if ($test[TEST_WEIGHT]<=0){ continue; }

   echo '<li>';
   printf('%s<br/>%s<br/>', $test[TEST_NAME], $test[TEST_TAG]);

   if (!empty($rows)){

      foreach($rows as $row){  

         if (is_array($row)){
            $fc = number_format($row[DATA_FULLCPU],2);

            if ($row[DATA_ELAPSED]>0){ $e = number_format($row[DATA_ELAPSED],2); } else { $e = ''; }

            if($row[DATA_STATUS] > PROGRAM_TIMEOUT){
               printf('%ss', $e);
            } else {
               printf('%s', StatusMessage($row[DATA_STATUS]));
            }

            $lang = $row[DATA_LANG];
            $name = $Langs[$lang][LANG_FULL];
            $noSpaceName = str_replace(' ','&nbsp;',$name);   
            printf(' %s<br/>', $noSpaceName);

         } elseif (!isset($row)) {
            printf('%s<br/>', 'No&nbsp;program');
         }
      }
   }

   else { // empty($rows)     
      printf('%s', 'No&nbsp;programs');
   }
   echo "</li>\n";
}
?>
</ul>

