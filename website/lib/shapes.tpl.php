<?   // Copyright (c) Isaac Gouy 2009 ?>


<?
   function CompareTime($b, $a){
      if ($a[1] == $b[1]) return 0;
      return  ($a[1] < $b[1]) ? -1 : 1;
   }
   
   list($Shapes,$Centers) = $Data;
   uasort($Centers,'CompareTime');

   $bounds = array(0.0,1.3,1.8,2.3,1000.0);
   define('NCOLS',sizeof($bounds)-1);

   /* Match the median time to a median time already assigned
      in cols - use the same row if possible.
   */

   function rowmatch($start,$stop,$k,&$cols,&$Centers){
      $rowmatch = $start;
      $y = $Centers[$k][1];
      for ($col=0; $col<NCOLS; $col++){
         for ($r=$start; $r<$stop; $r++){
            if (isset($cols[$col][$r])){
               $k0 = $cols[$col][$r];
               if ($k0 != $k){
                  $diff = abs($Centers[$k0][1] - $y);
                  if (!isset($match)||($diff < $match)){
                     $match = $diff; $rowmatch = $r;
                  }
               }
            }
         }
      }
      return $rowmatch;
   }

   /* Assign each language implementation to a source code size column
      based on arbitrary source code size.
   */

   function leftToRight(&$bounds,&$Centers){
      $cols = array();
      for ($col=0;$col<NCOLS;$col++){
         $b0 = $bounds[$col]; $b1 = $bounds[$col+1];
         $i = 0;
         if ($col==0){
            foreach($Centers as $k => $c){
               if ($c[0] < $b1){ $cols[$col][$i] = $k; $i++; }
            }
            $n = $i;
         } else {
            foreach($Centers as $k => $c){
               if ($c[0] >= $b0 && $c[0] < $b1){
                  $r = rowmatch($i,$n,$k,$cols,$Centers);
                  $cols[$col][$r] = $k;
                  $i = $r + 1;
               }
            }
            $n = ($n > $i) ? $n : $i;
         }
      }
      return array($n,$cols);
   }

   function finetune($n,&$cols0,&$Centers){
      $colrow = array();
      foreach($cols0 as $c => $a){
         foreach($a as $r => $k){
            $colrow[$k] = array($c,$r);
         }
      }

      $cols = array();
      $edge = sizeof($cols0)-1;
      $keys = array_keys(array_reverse($Centers));

      foreach($keys as $k){
         $cr = $colrow[$k];
         $col = $cr[0];
         if ($col==$edge){
            $cols[$col][ $cr[1] ] = $k;
         } else {
            $r = rowmatch($cr[1],$n,$k,$cols0,$Centers);
            while ($r > $cr[1] && isset($cols[$col][$r])){ $r--; }
            $cols[$col][$r] = $k;
         }
      }
      return $cols;
   }


   list($n,$cols) = leftToRight($bounds,$Centers);
   $cols = finetune($n,$cols,$Centers);

?>


<h2><a href="#shapes" name="shapes">&nbsp;<?=$Title;?>&nbsp;[<?=$Mark;?>]</a></h2>
<p>Scatter plots of normalized source code size and normalized run time measurements give shape to each language implementation and position the programs in a broader context. From concise at the left to less-concise at the right, from slower at the top to faster at the bottom - smaller is better.</p>

<?
   printf('<table>');
   
   for ($row=0; $row<$n; $row++){
      printf('<tr>');
      for ($col=0; $col<NCOLS; $col++){
         printf('<td>&nbsp;');
         if (isset($cols[$col][$row])){
            $k = $cols[$col][$row];
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

