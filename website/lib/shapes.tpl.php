<?   // Copyright (c) Isaac Gouy 2009 ?>


<?

list($Shapes,$Centers) = $Data;
unset($Data);

$columns = array( array(), array(), array(), array());
foreach($Centers as $k => $c){
   if ($c[0] < 1.4){ $i = 0; }
   elseif ($c[0] < 1.8){ $i = 1; }
   elseif ($c[0] < 2.2){ $i = 2; }
   elseif ($c[0] < 2.6){ $i = 3; }
   else { $i = 4; }
   $columns[$i][] = array($k,$c[1]);
}

function CompareTime($b, $a){
   if ($a[1] == $b[1]) return 0;
   return  ($a[1] < $b[1]) ? -1 : 1;
}


$r = array();
$maxcols = sizeof($columns);
for ($i=0; $i<$maxcols; $i++){
   $r[] = sizeof($columns[$i]);
   usort($columns[$i],'CompareTime');
}
$nrows = max($r);
unset($r);


$row = 0;
for ($row=0; $row<$nrows; $row++){
   echo '<p><br/>';
   for ($i=0; $i<$maxcols; $i++){
      if (isset($columns[$i][$row])){
         $k =$columns[$i][$row][0];
         printf('<img src="chartshape.php?w=%s&amp;s=%s&amp;c=%s" width="150" height="120" />&nbsp;',
            Encode($k), Encode($Shapes[$k]), Encode($Centers[$k]) );
      } else {
         printf('<img src="chartshape.php?w=%s&amp;s=%s&amp;c=%s" width="150" height="120" />&nbsp;',
            Encode(''), Encode(array()), Encode(array()) );
      }
   }
   echo "</p>\n";
}

?>

