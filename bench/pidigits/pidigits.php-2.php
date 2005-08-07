<?php

/* The Great Computer Language Shootout
   http://shootout.alioth.debian.org/

   contributed by Robert Bradshaw
*/

# requires --enable-bcmath


$k = 0;
$z = array(1, 0, 0, 1);

function next_digit() {
  while(($y = extract_digit(3)) != extract_digit(4)) {
    consume(next_lft());
  }
  produce($y);
  return $y;
}

function next_lft() {
  global $k;
  $k++;
  return array($k, 4*$k+2, 0, 2*$k+1);
}

function extract_digit($x) {
  global $z;
  print_r($z);
  return bcdiv( bcadd(bcmul($z[0], $x), $z[1]) , bcadd(bcmul($z[2], $x), $z[3]) , 0);
}

function produce($y) {
  global $z;
  $z = compose(array(10, -10*$y, 0, 1), $z);
}

function consume($w) {
  global $z;
  $z = compose($z, $w);
}

function compose($z, $w) {
  return array( bcadd( bcmul($z[0], $w[0]) , bcmul($z[1], $w[2])), 
                bcadd( bcmul($z[0], $w[1]) , bcmul($z[1], $w[3])),
                bcadd( bcmul($z[2], $w[0]) , bcmul($z[3], $w[2])),
                bcadd( bcmul($z[2], $w[1]) , bcmul($z[3], $w[3])) );
}


$n = $argv[1];

for($i=1; $i<=$n; $i++) {
  echo next_digit();
  if ($i % 10 == 0) echo "\t:$i\n";
}
if ($n % 10 != 0) {
  for($j=$n % 10; $j<=10; $j++) echo " ";
  echo "\t:$n\n";
}


?>