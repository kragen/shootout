<?   // Copyright (c) Isaac Gouy 2009 ?>


<?
   function CompareTime($b, $a){
      if ($a[1] == $b[1]) return 0;
      return  ($a[1] < $b[1]) ? -1 : 1;
   }
   
   list($Shapes,$Centers) = $Data;
   uasort($Centers,'CompareTime');

   define('NCOLS',4);
   $rows = array();
   
   /*
      Match the median time to a median time already assigned
      in rows - use the same row if possible.
   */

   function rowmatch($start,$stop,$y,&$rows,&$Centers){
      $matchrow = $start;
      for ($col=0; $col<NCOLS; $col++){
         for ($j=$start; $j<$stop; $j++){
            if (isset($rows[$col][$j])){
               $k0 = $rows[$col][$j];
               $diff = abs($Centers[$k0][1] - $y);
               if (!isset($match)||($diff < $match)){
                  $match = $diff; $matchrow = $j;
               }
            }
         }
      }
      return $matchrow;
   }
   
   /*
      Assign each language implementation to a source code size column
      based on arbitrary source code size.
   */
   
   // first column
   $i = 0;
   foreach($Centers as $k => $c){
      if ($c[0] < 1.3){ $rows[0][$i] = $k; $i++; }
   }
   $j = $i;
   
   // second column
   $i = 0;
   foreach($Centers as $k => $c){
      if ($c[0] >= 1.3 && $c[0] < 1.8){
         $r = rowmatch($i,$j,$c[1],$rows,$Centers);
         $rows[1][$r] = $k;
         $i = $r + 1;
      }
   }
   $j = ($j > $i) ? $j : $i;
   
   // third column
   $i = 0;
   foreach($Centers as $k => $c){
      if ($c[0] >= 1.8 && $c[0] < 2.3){
         $r = rowmatch($i,$j,$c[1],$rows,$Centers);
         $rows[2][$r] = $k;
         $i = $r + 1;
      }
}
$j = ($j > $i) ? $j : $i;
   
// fourth column
$i = 0;
foreach($Centers as $k => $c){
   if ($c[0] >= 2.3){
      $r = rowmatch($i,$j,$c[1],$rows,$Centers);
      $rows[3][$r] = $k;
      $i = $r + 1;
   }
}
$j = ($j > $i) ? $j : $i;


if (SITE_NAME == 'gp4' || SITE_NAME == 'debian'){
   printf('<p><strong>&nbsp;Please choose the <a href="faq.php#means">up-to-date measurements</a>!</strong><br/></p>');
}
?>


<h2><a href="#shapes" name="shapes">&nbsp;<?=$Title;?>&nbsp;[<?=$Mark;?>]</a></h2>
<p>Normalized measurements of source code size and run time give shape to each language implementation and position the programs in a broader context. Smaller is better.</p>

<?
   printf('<table>');
   
   for ($row=0; $row<$j; $row++){
      printf('<tr>');
      for ($col=0; $col<NCOLS; $col++){
         printf('<td>&nbsp;');
         if (isset($rows[$col][$row])){
            $k = $rows[$col][$row];
            printf('<img src="chartshape.php?w=%s&amp;s=%s&amp;c=%s" width="150" height="120" />',
               Encode($k), Encode($Shapes[$k]), Encode($Centers[$k]) );
         } else {
            printf('&nbsp;');
         }
         printf('</td>');
      }
      printf('</tr>');
   }
   printf('</table>');
?>

<h3><a href="#about" name="about">&nbsp;about <?=$Title;?></a></h3>
<?=$About;?>

