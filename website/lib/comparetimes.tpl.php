<?   // Copyright (c) Isaac Gouy 2011


// PAGE ////////////////////////////////////////////////

list($sorted,$ratios,$stats) = $Data;
unset($Data);
unset($ratios);
unset($stats);

$Row = $Langs[$SelectedLang];
$LangName = $Row[LANG_FULL];
$NoSpaceLangName = str_replace(' ','&nbsp;',$LangName);
$LangTag = $Row[LANG_TAG];
$LangName2 = $Langs[$SelectedLang2][LANG_FULL];
$LangLink = $Row[LANG_LINK];
$LangLink2 = $Langs[$SelectedLang2][LANG_LINK];
$Family = $Row[LANG_FAMILY];

foreach($sorted as $k => $rows){
   $test = $Tests[$k];
   if ($test[TEST_WEIGHT]<=0){ continue; }
   $testname = $test[TEST_NAME];

   if (!empty($rows)){

      printf('<dt>%s</dt>', $testname);

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
   
            printf('<dl>%s ', $noSpaceName);

            $fc = number_format($row[DATA_FULLCPU],2);

            if ($row[DATA_ELAPSED]>0){ $e = number_format($row[DATA_ELAPSED],2); } else { $e = ''; }

            if($row[DATA_STATUS] > PROGRAM_TIMEOUT){
               printf('%s</dl>', $e);
            } else {
               printf('%s</dl>', StatusMessage($row[DATA_STATUS]));
            }
            $ELAPSED = '';

         } elseif (!isset($row)) {
            printf('%s</dl>', 'No&nbsp;program');
         }
      }
   }

   else { // empty($rows)     
      printf('<dt>%s</dt>', $testname);

      printf('<dl>%s</dl>', 'No&nbsp;programs');
   }
}
?>

