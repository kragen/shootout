<? /* The Computer Language Shootout 
   http://shootout.alioth.debian.org/  
   contributed by Isaac Gouy */

$n = $argv[1];

$sum = 0.0;
for ($k=0; $k<$n; $k++) $sum += pow(2.0/3.0,$k);
printf("%.9f\t(2/3)^k\n", $sum);

$sum = 0.0;
for ($k=1; $k<=$n; $k++) $sum += pow($k,-0.5);
printf("%.9f\tk^-0.5\n", $sum);

$sum = 0.0;
for ($k=1; $k<=$n; $k++) $sum += 1.0/($k*($k+1.0));
printf("%.9f\t1/k(k+1)\n", $sum);

//  Flint Hills
$sum = 0.0;
for ($k=1; $k<=$n; $k++) $sum += 1.0/(pow($k,3) * pow(sin($k),2));
printf("%.9f\tFlint Hills\n", $sum);

//  Cookson Hills
$sum = 0.0;
for ($k=1; $k<=$n; $k++) $sum += 1.0/(pow($k,3) * pow(cos($k),2));
printf("%.9f\tCookson Hills\n", $sum);

//  Harmonic
$sum = 0.0;
for ($k=1; $k<=$n; $k++) $sum += 1.0/$k;
printf("%.9f\tHarmonic\n", $sum);

//  Riemann Zeta 2
$sum = 0.0;
for ($k=1; $k<=$n; $k++) $sum += 1.0/pow($k,2);
printf("%.9f\tRiemann Zeta\n", $sum);

$a = -1.0;

//  Alternating Harmonic
$sum = 0.0;
for ($k=1; $k<=$n; $k++) $sum += ($a= -$a)/$k;
printf("%.9f\tAlternating Harmonic\n", $sum);

//  Gregory
$sum = 0.0;
for ($k=1; $k<=$n; $k++) $sum += ($a= -$a)/(2*$k -1);
printf("%.9f\tGregory\n", $sum);

?>
