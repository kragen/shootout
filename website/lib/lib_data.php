<?
// Copyright (c) Isaac Gouy 2010

// DATA LAYOUT ///////////////////////////////////////////////////

define('DATA_TEST',0);
define('DATA_LANG',1);
define('DATA_ID',2);
define('DATA_TESTVALUE',3);
define('DATA_GZ',4);
define('DATA_FULLCPU',5);
define('DATA_MEMORY',6);
define('DATA_STATUS',7);
define('DATA_LOAD',8);
define('DATA_ELAPSED',9);

// With quad-core we changed from CPU Time to Elapsed Time
// but we still want to show the old stuff
if (SITE_NAME == 'debian' || SITE_NAME == 'gp4'){
   define('DATA_TIME',DATA_FULLCPU);
} else {
   define('DATA_TIME',DATA_ELAPSED);
}


// MENU ///////////////////////////////////////////////////

function MkMenuForm($Tests,$SelectedTest,$Langs,$SelectedLang){
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
   echo '</select>', "\n";
   echo '<input type="submit" value="Show" />', "\n";
   echo '</p></form>', "\n";
}



// FORMAT ///////////////////////////////////////////////////

function ElapsedTime($d){
   if ($d[DATA_ELAPSED] > 0.0){
      return number_format($d[DATA_ELAPSED],2);
   } else {
      return '';
   }
}

function CpuLoad($d){
   if (strlen($d[DATA_LOAD])>1){
      return str_replace(' ','&nbsp;',$d[DATA_LOAD]);
   } else {
      return '';
   }
}

function IdName($id){
   if ($id>1){ return '&nbsp;#'.$id; } else { return ''; }
}


function MarkTime($PathRoot=''){
   if (SITE_NAME == 'debian'){
      $Mark = 'late 2007';
   } elseif (SITE_NAME == 'gp4'){
      $Mark = 'mid 2008';
   } else {
      $mtime = filemtime($PathRoot.DATA_PATH.'data.csv');
      $Mark = gmdate("d M Y", $mtime);
   }
   return $Mark;
}

function StatusMessage($i){
   if ($i==0){ $m = ''; }
   elseif ($i==-1){ $m = 'Timed&nbsp;Out'; }
   elseif ($i==-2){ $m = 'Failed'; }
   elseif ($i==-6){ $m = 'No&nbsp;Comparison'; }
   elseif ($i==-10){ $m = 'Bad&nbsp;Output'; }
   elseif ($i==-11){ $m = 'Make&nbsp;Error'; }
   elseif ($i==-12){ $m = 'Empty'; }
   else { $m = ''; }
   return $m;
}

?>
