<? /* The Great Computer Language Shootout 
   http://shootout.alioth.debian.org/
   
   contributed by Isaac Gouy (PHP novice)
   
   php -q mandelbrot.php 100
*/


$width = ($argc == 2) ? $argv[1] : 100;
$height = $width;
$m = 50; $bits = 0; $bitnum = 0; $limit2 = 4.0;
$isOverLimit = FALSE;

printf("P4\n%d %d\n", $width,$height);

for ($y=0; $y<$height; $y++){
   for ($x=0; $x<$width; $x++){
   
      $Zr = 0.0; $Zi = 0.0;
      $Cr = 2.0*$x / $width - 1.5;
      $Ci = 2.0*$y / $height - 1.0;

      $i = 0;
      do {
         $Tr = $Zr*$Zr - $Zi*$Zi + $Cr;
         $Ti = 2.0*$Zr*$Zi + $Ci;
         $Zr = $Tr; $Zi = $Ti;
         $isOverLimit = $Zr*$Zr + $Zi*$Zi > $limit2;            
      } while (!$isOverLimit && (++$i < $m));
                                                      
      $bits = $bits << 1;
      if (!$isOverLimit) $bits++;
      $bitnum++;

      if ($x == $width - 1) {
         $bits = $bits << (8 - $bitnum);
         $bitnum = 8;
      }
      
      if ($bitnum == 8){
         echo chr($bits);
         $bits = 0; $bitnum = 0;
      }                                       
   }
}             
?>