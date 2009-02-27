<?php
// Copyright (c) Isaac Gouy 2005-2009

// FUNCTIONS ///////////////////////////////////////////////////


function ComparisonData($langs,$data,$p,&$Excl){
   $sortValue = 'fullcpu';
   list($Accepted) = FilterAndSortData($langs,$data,&$sortValue,&$Excl);

// SELECTION DEPENDS ON THIS SORT ORDER

   uasort($Accepted,'CompareTestValue');

// TRANSFORM SELECTED DATA

   $lang = ""; $id = "";
   $NData = array(); $TestValues = array();

   foreach($Accepted as $d){
      if (($lang != $d[DATA_LANG])||($id != $d[DATA_ID])){
         $lang = $d[DATA_LANG];
         $id = $d[DATA_ID];

         $NData[] = array(
              ''
            , $lang
            , $id
            , ''
            , $langs[$lang][LANG_FULL].IdName($id)
            , $langs[$lang][LANG_HTML].IdName($id)
            , array()
            , array()
            , 0
            , 0
            , 0
            );

         $i = sizeof($NData)-1;         
      }
      $NData[$i][N_FULLCPU][] = $d[DATA_TIME];
      $NData[$i][N_MEMORY][] = $d[DATA_MEMORY];
      $TestValues[ $d[DATA_TESTVALUE] ] = $d[DATA_TESTVALUE];
   }



// SUB-SELECT DATA FOR SPECIFIC PROGRAMS

   $plang = array(); $pid = array();
   foreach($p as $pdash){
      list($a, $b) = explode('-', $pdash);
      $plang[] = $a; 
      $pid[] = $b;
   }

   $Selected = array();
   $i = sizeof($TestValues)-1;
   foreach($NData as $d){
      if (($plang[0]==$d[N_LANG])&&($pid[0]==$d[N_ID])) $Selected[0] = $d;
      elseif (($plang[1]==$d[N_LANG])&&($pid[1]==$d[N_ID])) $Selected[1] = $d;
      elseif (($plang[2]==$d[N_LANG])&&($pid[2]==$d[N_ID])) $Selected[2] = $d;
      elseif (($plang[3]==$d[N_LANG])&&($pid[3]==$d[N_ID])) $Selected[3] = $d;

      // later convert $Selected to ratios against these minima
      if (isset($d[N_FULLCPU][$i])&&(!isset($mintime)||$d[N_FULLCPU][$i]<$mintime[N_FULLCPU][$i])){
         $mintime = $d;
      }
      if (isset($d[N_MEMORY][$i])&&(!isset($minmem)||$d[N_MEMORY][$i]<$minmem[N_MEMORY][$i])){
         $minmem = $d;
      }
   }

// MAX AND NAME FOR SPECIFIC PROGRAMS
   foreach ($Selected as $i => $v){
      $d = $Selected[$i];
      $lang = $d[N_LANG];
      $id = $d[N_ID];

      if (strlen($langs[$lang][LANG_NAME])>0){
         $Selected[$i][N_NAME] = $langs[$lang][LANG_NAME].IdName($id); }
      else {
         $Selected[$i][N_NAME] = $langs[$lang][LANG_FAMILY].IdName($id); }

      // convert measurements into "ratios to best"
      foreach($d[N_FULLCPU] as $k => $v)
         if (isset($mintime[N_FULLCPU][$k]))
            $Selected[$i][N_FULLCPU][$k] = $v / $mintime[N_FULLCPU][$k];

      foreach($d[N_MEMORY] as $k => $v)
         if (isset($minmem[N_MEMORY][$k]))
            // use default value to avoid bad data divide by zero
            $Selected[$i][N_MEMORY][$k] =
               ($minmem[N_MEMORY][$k]<200.0) ? $v / 200.0 : $v / $minmem[N_MEMORY][$k];

   }

   uasort($NData,'CompareNName');
   sort($TestValues);

   return array(&$NData,&$Selected,$TestValues);
}


function CompareNName($a, $b){
   return strcasecmp($a[N_FULL],$b[N_FULL]);
}


function CompareTestValue($a, $b){
   if ($a[DATA_LANG] == $b[DATA_LANG]){
      if ($a[DATA_ID] == $b[DATA_ID]){
         if ($a[DATA_TESTVALUE] == $b[DATA_TESTVALUE]) return 0;
         return ($a[DATA_TESTVALUE] < $b[DATA_TESTVALUE]) ? -1 : 1;
      }
      else {
         return ($a[DATA_ID] < $b[DATA_ID]) ? -1 : 1;      
      }
   }
   else {
      return ($a[DATA_LANG] < $b[DATA_LANG]) ? -1 : 1;      
   }   
}


function MkComparisonMenuForm($Langs,$Tests,$SelectedTest,$Data,$p1,$p2,$p3,$p4,$Sort){
   echo '<p><strong>Choose</strong> programs for side-by-side comparison:</p>';
   echo '<form method="get" action="fulldata.php">';
   printf('<p><input type="hidden" name="test" value="%s" />', $SelectedTest);
   /*
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
   echo '</select></p>', "\n";
   */
     
// NASTY HACK
// ADD DUMMY VALUES TO PRESERVE SELECTION IN DROP-DOWN MENUS 
// default is '-0' so check $a

   list($a, $b) = explode('-', $p1); 
   if (strlen($a)){
      $c = $Langs[$a]; $d = IdName($b);
      $Data[] = array($a, $b, '', $c[LANG_FULL].$d, $c[LANG_FULL].$d);
   }

   list($a, $b) = explode('-', $p2); 
   if (strlen($a)){
      $c = $Langs[$a]; $d = IdName($b);
      $Data[] = array($a, $b, '', $c[LANG_FULL].$d, $c[LANG_FULL].$d);
   }

   list($a, $b) = explode('-', $p3); 
   if (strlen($a)){
      $c = $Langs[$a]; $d = IdName($b);
      $Data[] = array($a, $b, '', $c[LANG_FULL].$d, $c[LANG_FULL].$d);
   }

   list($a, $b) = explode('-', $p4); 
   if (strlen($a)){
      $c = $Langs[$a]; $d = IdName($b);
      $Data[] = array($a, $b, '', $c[LANG_FULL].$d, $c[LANG_FULL].$d);
   }

   echo '<select name="p1">', "\n";

   $first = 1;
   foreach($Data as $Row){
      $Link = $Row[N_LANG].'-'.$Row[N_ID];
      $Name = $Row[N_FULL];
      if ($Link==$p1 && $first){ // avoid choosing the dummy value if possible
         $Selected = 'selected="selected"'; $first = 0;
      } else {
         $Selected = '';
      }
      printf('<option %s value="%s">%s</option>', $Selected,$Link,$Name); echo "\n";
   }
   echo '</select>', "\n";
   echo '<select name="p2">', "\n";

   $first = 1;   
   foreach($Data as $Row){
      $Link = $Row[N_LANG].'-'.$Row[N_ID];
      $Name = $Row[N_FULL];
      if (($Link==$p2) && $first){ // avoid choosing the dummy value if possible
         $Selected = 'selected="selected"'; $first = 0;
      } else {
         $Selected = '';
      }
      printf('<option %s value="%s">%s</option>', $Selected,$Link,$Name); echo "\n";
   }

   echo '</select>', "\n";
   echo '<select name="p3">', "\n";

   $first = 1;   
   foreach($Data as $Row){
      $Link = $Row[N_LANG].'-'.$Row[N_ID];
      $Name = $Row[N_FULL];

      if ($Link==$p3 && $first){ // avoid choosing the dummy value if possible
         $Selected = 'selected="selected"'; $first = 0;
      } else {
         $Selected = '';
      }
      printf('<option %s value="%s">%s</option>', $Selected,$Link,$Name); echo "\n";
   }

   echo '</select>', "\n";
   echo '<select name="p4">', "\n";

   $first = 1;   
   foreach($Data as $Row){
      $Link = $Row[N_LANG].'-'.$Row[N_ID];
      $Name = $Row[N_FULL];

      if ($Link==$p4 && $first){ // avoid choosing the dummy value if possible
         $Selected = 'selected="selected"'; $first = 0;
      } else {
         $Selected = '';
      }
      printf('<option %s value="%s">%s</option>', $Selected,$Link,$Name); echo "\n";
   }
   echo '</select><input type="submit" value="Show" /></p></form>';
}



function CompareMaxCpu($a, $b){
   if ($a[N_CPU_MAX] == $b[N_CPU_MAX]) return 0;
   return  ($a[N_CPU_MAX] > $b[N_CPU_MAX]) ? -1 : 1;
}

function CompareMaxMemory($a, $b){
   if ($a[N_MEMORY_MAX] == $b[N_MEMORY_MAX]) return 0;
   return  ($a[N_MEMORY_MAX] > $b[N_MEMORY_MAX]) ? -1 : 1;
}


?>