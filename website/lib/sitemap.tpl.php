<?   // Copyright (c) Isaac Gouy 2010 ?>

<p class="imgfooter">&nbsp; <a href="<?=CORE_SITE;?>">Home</a> &nbsp; <a href="<?=CORE_SITE;?>flawed-benchmarks.php">Flawed</a> &nbsp; <a href="<?=CORE_SITE;?>fastest-programming-language.php">Fastest</a> &nbsp; <a href="<?=CORE_SITE;?>license.php">License</a> &nbsp; <a href="<?=CORE_SITE;?>help.php">Help</a> &nbsp; <a href="<?=CORE_SITE;?>sitemap.php">Site&nbsp;Map</a> &nbsp;</p>

<table>

<?
function PrintHeaders(){
   echo '<tr><th>&nbsp;</th><th></th><th></th><th></th></tr>';
   echo '<tr>';
   echo '<th class="u32">&nbsp;x86&nbsp;Ubuntu&#8482; Intel&#174;&nbsp;Q6600&#174; one&nbsp;core&nbsp;</th>';
   echo '<th class="u32q">&nbsp;x86&nbsp;Ubuntu&#8482; Intel&#174;&nbsp;Q6600&#174; quad-core&nbsp;</th>';
   echo '<th class="u64">&nbsp;x64&nbsp;Ubuntu&#8482; Intel&#174;&nbsp;Q6600&#174; one&nbsp;core&nbsp;</th>';
   echo '<th class="u64q">&nbsp;x64&nbsp;Ubuntu&#8482; Intel&#174;&nbsp;Q6600&#174; quad-core&nbsp;</th>';
   echo '</tr>';
   echo '<tr><th>&nbsp;</th><th></th><th></th><th></></tr>';
}


PrintHeaders();

$page = array(
   array('code-used-time-used-shapes.php','Code-used Time-used Shapes')
   ,array('which-programming-languages-are-fastest.php','Which programming languages are fastest?')
   ,array('which-language-is-best.php','Which programming language is best?')
   ,array('summarydata.php','Summary Data')
   );

foreach($page as $p){
   printf('<tr></tr><tr>');
   foreach($Sites as $s){
      printf('<td><a href="./%s/%s">%s</a></td>', $s, $p[0], $p[1] );
   }
   echo "</tr>";
}

PrintHeaders();

foreach(array_keys($SiteLangs['u32']) as $k){
   printf('<tr>');
   foreach($Sites as $s){
      if (isset($SiteLangs[$s][$k])){
         $Lang = $SiteLangs[$s][$k];
         if (isset($Lang[LANG_SPECIALURL]) && !empty($Lang[LANG_SPECIALURL])){
            printf('<td><a href="./%s/%s.php">%s</a></td>', $s, $Lang[LANG_SPECIALURL], $Lang[LANG_FULL] );
         } else {
            printf('<td><a href="./%s/compare.php?lang=%s">%s</a></td>', $s, $Lang[LANG_LINK], $Lang[LANG_FULL] );
         }
      }
      else {
         printf('<td>&nbsp;</td>');
      }
   }
   printf('</tr>');
}

PrintHeaders();

foreach(array_keys($SiteTests['u32']) as $k){
   printf('<tr>');
   foreach($Sites as $s){
      if (isset($SiteTests[$s][$k])){
         $Test = $SiteTests[$s][$k];
         printf('<td><a href="./%s/performance.php?test=%s">%s</a></td>', $s, $Test[TEST_LINK], $Test[TEST_NAME] );
      }
      else {
         printf('<td>&nbsp;</td>');
      }
   }
   printf('</tr>');
}
?>

</table>
