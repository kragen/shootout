#!/usr/bin/perl
#
# The Great Computer Language Shootout
# http://shootout.alioth.debian.org/
#
# contributed by Christoph Bauer
# converted into Perl by Márton Papp
# fixed and cleaned up by Danny Sauer
#

use constant PI            => 3.141592653589793;
use constant SOLAR_MASS    => (4 * PI * PI);
use constant DAYS_PER_YEAR => 365.24;

sub advance($$$)
{
  my ($nbodies, $bodies, $dt) = @_;
  my ($b, $b2, $i, $j, $dx, $dy, $dz, $distance, $mag);

  for ($i = 0; $i < $nbodies; $i++) {
    $b = $bodies->[$i];
    for ($j = $i + 1; $j < $nbodies; $j++) {
      $b2 = $bodies->[$j];
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
  foreach $b (@$bodies) {
    $b->{x} += $dt * $b->{vx};
    $b->{y} += $dt * $b->{vy};
    $b->{z} += $dt * $b->{vz};
  }
}

sub energy($$)
{
  my ($nbodies, $bodies) = @_;
  my ($e, $b, $b2, $i, $j, $dx, $dy, $dz, $distance);

  $e = 0.0;
  for ($i = 0; $i < $nbodies; $i++) {
    $b = $bodies->[$i];
    $e += 0.5 * $b->{mass} * 
          ($b->{vx} * $b->{vx} + $b->{vy} * $b->{vy} + $b->{vz} * $b->{vz});
    for ($j = $i + 1; $j < $nbodies; $j++) {
      $b2 = $bodies->[$j];
      $dx = $b->{x} - $b2->{x};
      $dy = $b->{y} - $b2->{y};
      $dz = $b->{z} - $b2->{z};
      $distance = sqrt($dx * $dx + $dy * $dy + $dz * $dz);
      $e -= ($b->{mass} * $b2->{mass}) / $distance;
    }
  }
  return $e;
}

sub offset_momentum($$)
{
  my ($nbodies, $bodies) = @_;
  my ($b, $px, $py, $pz, $i);

  $px = 0.0;
  $py = 0.0;
  $pz = 0.0;
  foreach $b (@$bodies) {
    $px += $b->{vx} * $b->{mass};
    $py += $b->{vy} * $b->{mass};
    $pz += $b->{vz} * $b->{mass};
  }
  $bodies->[0]->{vx} = - $px / SOLAR_MASS;
  $bodies->[0]->{vy} = - $py / SOLAR_MASS;
  $bodies->[0]->{vz} = - $pz / SOLAR_MASS;
}

my $bodies = [
  {# sun
   x  => 0,  y => 0,  z => 0,
   vx => 0, vy => 0, vz => 0,
   mass => SOLAR_MASS
  },
  {# jupiter
   x    =>  4.84143144246472090e+00,
   y    => -1.16032004402742839e+00,
   z    => -1.03622044471123109e-01,
   vx   =>  1.66007664274403694e-03 * DAYS_PER_YEAR,
   vy   =>  7.69901118419740425e-03 * DAYS_PER_YEAR,
   vz   => -6.90460016972063023e-05 * DAYS_PER_YEAR,
   mass =>  9.54791938424326609e-04 * SOLAR_MASS
  },
  {#saturn
   x    =>  8.34336671824457987e+00,
   y    =>  4.12479856412430479e+00,
   z    => -4.03523417114321381e-01,
   vx   => -2.76742510726862411e-03 * DAYS_PER_YEAR,
   vy   =>  4.99852801234917238e-03 * DAYS_PER_YEAR,
   vz   =>  2.30417297573763929e-05 * DAYS_PER_YEAR,
   mass =>  2.85885980666130812e-04 * SOLAR_MASS
  },
  {#uranus
   x    =>  1.28943695621391310e+01,
   y    => -1.51111514016986312e+01,
   z    => -2.23307578892655734e-01,
   vx   =>  2.96460137564761618e-03 * DAYS_PER_YEAR,
   vy   =>  2.37847173959480950e-03 * DAYS_PER_YEAR,
   vz   => -2.96589568540237556e-05 * DAYS_PER_YEAR,
   mass =>  4.36624404335156298e-05 * SOLAR_MASS
  },
  {#neptune
   x    =>  1.53796971148509165e+01,
   y    => -2.59193146099879641e+01,
   z    =>  1.79258772950371181e-01,
   vx   =>  2.68067772490389322e-03 * DAYS_PER_YEAR,
   vy   =>  1.62824170038242295e-03 * DAYS_PER_YEAR,
   vz   => -9.51592254519715870e-05 * DAYS_PER_YEAR,
   mass =>  5.15138902046611451e-05 * SOLAR_MASS
  }
];
my $NBODIES = scalar( @$bodies );

my $n = $ARGV[0];
offset_momentum($NBODIES, $bodies);
printf ("%.9f\n", energy($NBODIES, $bodies));
for (my $i = 1; $i <= $n; $i++) {
  advance($NBODIES, $bodies, 0.01);
}
printf ("%.9f\n", energy($NBODIES, $bodies));

exit 0;
