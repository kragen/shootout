#
# The Great Computer Language Shootout
# http://shootout.alioth.debian.org/
#
# contributed by Christoph Bauer
# converted into Perl by Márton Papp
#

$pi = 3.141592653589793;
$solar_mass =(4 * $pi * $pi);
$days_per_year =365.24;



sub advance
{
 my ($nbodies,$bodies,$dt)=(shift,shift,shift);
  my ($i, $j);

  for ($i = 0; $i < $nbodies; $i++) {
    my $b = $$bodies[$i];
    for ($j = $i + 1; $j < $nbodies; $j++) {
      $b2 = $$bodies[$j];
      $dx = $b->{x} - $b2->{x};
      $dy = $b->{y} - $b2->{y};
      $dz = $b->{z} - $b2->{z};
      $distance = sqrt($dx * $dx + $dy * $dy + $dz * $dz);
      $mag = $dt / ($distance * $distance * $distance);
      $b->{vx} -= $dx * $b2->{mass} * $mag;
      $b->{vy} -= $dy * $b2->{mass} * $mag;
      $b->{vz} -= $dz * $b2->{mass} * $mag;
      $b2->{vx} += $dx * $b->{mass} * $mag;
      $b2->{vy} += $dy * $b->{mass} * $mag;
      $b2->{vz} += $dz * $b->{mass} * $mag;
    }
  }
  for ($i = 0; $i < $nbodies; $i++) {
    my $b = $$bodies[$i];
    $b->{x} += $dt * $b->{vx};
    $b->{y} += $dt * $b->{vy};
    $b->{z} += $dt * $b->{vz};
  }
}

sub energy
{
 my ($nbodies,$bodies)=(shift,shift);
 my $e;
 my ($i, $j);

  $e = 0.0;
  for ($i = 0; $i < $nbodies; $i++) {
     my $b = $$bodies[$i];
    $e += 0.5 * $b->{mass} * ($b->{vx} * $b->{vx} + $b->{vy} * $b->{vy} + $b->{vz} * $b->{vz});
    for ($j = $i + 1; $j < $nbodies; $j++) {
      my $b2 = $$bodies[$j];
      $dx = $b->{x} - $b2->{x};
      $dy = $b->{y} - $b2->{y};
      $dz = $b->{z} - $b2->{z};
      $distance = sqrt($dx * $dx + $dy * $dy + $dz * $dz);
      $e -= ($b->{mass} * $b2->{mass}) / $distance;
    }
  }
  return $e;
}

sub offset_momentum
{
 my ($nbodies,$bodies)=(shift,shift);
  my $px = 0.0;
  my $py = 0.0;
  my $pz = 0.0;
  my $i;
  for ($i = 0; $i < $nbodies; $i++) {
    $px += $$bodies[$i]->{vx} * $$bodies[$i]->{mass};
    $py += $$bodies[$i]->{vy} * $$bodies[$i]->{mass};
    $pz += $$bodies[$i]->{vz} * $$bodies[$i]->{mass};
  }
  $bodies[0]->{vx} = - $px / $solar_mass;
  $bodies[0]->{vy} = - $py / $solar_mass;
  $bodies[0]->{vz} = - $pz / $solar_mass;
}

$NBODIES= 5;
@bodies = (
  {                               # sun 
    x => 0, y => 0,z => 0,vx => 0, vy => 0,vz => 0, mass=> $solar_mass
  },
  {                               # jupiter 
   x => 4.84143144246472090e+00,
   y => -1.16032004402742839e+00,
   z =>  -1.03622044471123109e-01,
   vx =>  1.66007664274403694e-03 * $days_per_year,
   vy => 7.69901118419740425e-03 * $days_per_year,
   vz => -6.90460016972063023e-05 * $days_per_year,
   mass=>  9.54791938424326609e-04 * $solar_mass
  },
  {                              #saturn 
  x =>  8.34336671824457987e+00,
   y =>  4.12479856412430479e+00,
  z =>   -4.03523417114321381e-01,
  vx =>   -2.76742510726862411e-03 * $days_per_year,
  vy =>  4.99852801234917238e-03 * $days_per_year,
  vz =>  2.30417297573763929e-05 * $days_per_year,
  mass=>   2.85885980666130812e-04 * $solar_mass
  },
  {                             #uranus 
   x => 1.28943695621391310e+01,
   y =>  -1.51111514016986312e+01,
   z =>  -2.23307578892655734e-01,
  vx =>   2.96460137564761618e-03 * $days_per_year,
  vy =>  2.37847173959480950e-03 * $days_per_year,
  vz =>  -2.96589568540237556e-05 * $days_per_year,
  mass=>   4.36624404335156298e-05 * $solar_mass
  },
  {                            #neptune 
  x =>  1.53796971148509165e+01,
  y =>   -2.59193146099879641e+01,
  z =>   1.79258772950371181e-01,
 vx =>    2.68067772490389322e-03 * $days_per_year,
 vy =>   1.62824170038242295e-03 * $days_per_year,
 vz =>   -9.51592254519715870e-05 * $days_per_year,
 mass=>    5.15138902046611451e-05 * $solar_mass
  }
);


  $n = $ARGV[0];
 
  offset_momentum($NBODIES, \@bodies);
  printf ("%.9f\n", energy($NBODIES, \@bodies));
  for ($i = 1; $i <= $n; $i++)
  {
    advance($NBODIES, \@bodies, 0.01);
  }
  printf ("%.9f\n", energy($NBODIES, \@bodies));

  exit 0;



