<? 
/* The Computer Language Benchmarks Game
http://shootout.alioth.debian.org/

contributed by anon
*/

function advance(&$bodies, &$pairs, $dt) {

   foreach($pairs as &$pair) {

      $a = &$pair[0];
      $b = &$pair[1];

      $dx = $a[0] - $b[0];
      $dy = $a[1] - $b[1];
      $dz = $a[2] - $b[2];

      $distance = sqrt($dx*$dx + $dy*$dy + $dz*$dz);
      $mag = $dt / ($distance * $distance * $distance);
      $mag_a = $a[6] * $mag;
      $mag_b = $b[6] * $mag;

      $a[3] -= $dx * $mag_b;
      $a[4] -= $dy * $mag_b;
      $a[5] -= $dz * $mag_b;

      $b[3] += $dx * $mag_a;
      $b[4] += $dy * $mag_a;
      $b[5] += $dz * $mag_a;
   }
   foreach($bodies as &$body) {
      $body[0] += $dt * $body[3];
      $body[1] += $dt * $body[4];
      $body[2] += $dt * $body[5];
   }
}


function energy(&$bodies) {
   $m = sizeof($bodies);
   $e = 0.0;
   for ($i=0; $i<$m; $i++) {
      $e += 0.5 * $bodies[$i][6] *
         ( $bodies[$i][3] * $bodies[$i][3]
         + $bodies[$i][4] * $bodies[$i][4]
         + $bodies[$i][5] * $bodies[$i][5] );

      for ($j=$i+1; $j<$m; $j++) {
         $dx = $bodies[$i][0] - $bodies[$j][0];
         $dy = $bodies[$i][1] - $bodies[$j][1];
         $dz = $bodies[$i][2] - $bodies[$j][2];

         $distance = sqrt($dx*$dx + $dy*$dy + $dz*$dz);
         $e -= ($bodies[$i][6] * $bodies[$j][6]) / $distance;
      }
   }
   return $e;
}

function offset_momentum(&$bodies){
   $px = 0.0;
   $py = 0.0;
   $pz = 0.0;
   foreach ($bodies as $each) {
      $px += $each[3] * $each[6];
      $py += $each[4] * $each[6];
      $pz += $each[5] * $each[6];
   }
   $bodies[0][3] = -$px / SOLAR_MASS;
   $bodies[0][4] = -$py / SOLAR_MASS;
   $bodies[0][5] = -$pz / SOLAR_MASS;
}


define("PI", 3.141592653589793);
define("SOLAR_MASS", 4 * PI * PI);
define("DAYS_PER_YEAR", 365.24);

$Sun = array(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, SOLAR_MASS);

$Jupiter = array(
   4.84143144246472090E+00
   , -1.16032004402742839E+00
   , -1.03622044471123109E-01
   , 1.66007664274403694E-03 * DAYS_PER_YEAR
   , 7.69901118419740425E-03 * DAYS_PER_YEAR
   , -6.90460016972063023E-05 * DAYS_PER_YEAR
   , 9.54791938424326609E-04 * SOLAR_MASS
);

$Saturn = array(
   8.34336671824457987E+00
   , 4.12479856412430479E+00
   , -4.03523417114321381E-01
   , -2.76742510726862411E-03 * DAYS_PER_YEAR
   , 4.99852801234917238E-03 * DAYS_PER_YEAR
   , 2.30417297573763929E-05 * DAYS_PER_YEAR
   , 2.85885980666130812E-04 * SOLAR_MASS
);

$Uranus = array(
   1.28943695621391310E+01
   , -1.51111514016986312E+01
   , -2.23307578892655734E-01
   , 2.96460137564761618E-03 * DAYS_PER_YEAR
   , 2.37847173959480950E-03 * DAYS_PER_YEAR
   , -2.96589568540237556E-05 * DAYS_PER_YEAR
   , 4.36624404335156298E-05 * SOLAR_MASS
);

$Neptune = array(
   1.53796971148509165E+01
   , -2.59193146099879641E+01
   , 1.79258772950371181E-01
   , 2.68067772490389322E-03 * DAYS_PER_YEAR
   , 1.62824170038242295E-03 * DAYS_PER_YEAR
   , -9.51592254519715870E-05 * DAYS_PER_YEAR
   , 5.15138902046611451E-05 * SOLAR_MASS
);

$bodies = array($Sun, $Jupiter, $Saturn, $Uranus, $Neptune);

offset_momentum($bodies);

$pairs = array();
$m = count($bodies);
for ($i=0; $i<$m; $i++) {
   for ($j=$i+1; $j<$m; $j++) {
      $pairs[] = array(&$bodies[$i], &$bodies[$j]);
   }
}

$n = (int) $argv[1];
printf("%0.9f\n", energy($bodies));
for ($i=0; $i<$n; ++$i){ advance($bodies,$pairs,0.01); }
printf("%0.9f\n", energy($bodies));

?>
