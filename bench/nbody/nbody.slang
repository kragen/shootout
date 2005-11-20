#!/usr/bin/env slsh
% The Great Computer Language Shootout
% http://shootout.alioth.debian.org/
% 
% contributed by John E Davis

private variable SOLAR_MASS = 4 * PI * PI;
private variable DAYS_PER_YEAR = 365.24;

typedef struct
{
   X, V, mass
}
Planet;

private define advance (bodies, dt)
{
   variable i, j;
   variable nbodies = length (bodies);
   _for (0, nbodies-1, 1)
     {
	i = ();
	variable b = bodies[i];
	variable X = b.X, V = b.V;
	variable x = X[0], y = X[1], z = X[2];
	variable vx = V[0], vy = V[1], vz = V[2];
	variable mass = b.mass;
	_for (i+1, nbodies-1, 1)
	  {
	     j = ();
	     variable b1 = bodies[j];
	     variable X1 = b1.X;
	     variable V1 = b1.V;
	     variable dx = x - X1[0];
	     variable dy = y - X1[1];
	     variable dz = z - X1[2];
	     variable mag = dt/(dx*dx+dy*dy+dz*dz)^1.5;
	     variable mag1 = b1.mass * mag;
	     vx = vx-dx * mag1;
	     vy = vy-dy * mag1;
	     vz = vz-dz * mag1;
	     mag1 = mag*mass;
	     V1[0] = V1[0] + (dx*mag1);
	     V1[1] = V1[1] + (dy*mag1);
	     V1[2] = V1[2] + (dz*mag1);
	  }
	V[0] = vx; V[1] = vy; V[2] = vz;
	X[0] = x + vx*dt;
	X[1] = y + vy*dt;
	X[2] = z + vz*dt;
     }
}

private define energy (bodies)
{
   variable nbodies = length (bodies);
   variable e = 0.0, i, j;
   _for (0, nbodies-1, 1)
     {
	i = ();
	variable b = bodies[i];
	variable X = b.X;
	variable V = b.V;
	variable mass = b.mass;
	e += 0.5 * mass * sum (V*V);
	_for (i+1, nbodies-1, 1)
	  {
	     j = ();
	     variable b_j = bodies[j];
	     variable dX = X-b_j.X;
	     e -= (mass * b_j.mass)/sqrt(sum(dX*dX));
	  }
     }
   return e;
}

private define offset_momentum (bodies)
{
   variable i, p = 0.0;
   _for (0, length(bodies)-1, 1)
     {
	i = ();
	variable b = bodies[i];
	p += b.mass * b.V;
     }
   bodies[0].V = -p/SOLAR_MASS;
}

private define make_planet (X, V, mass)
{
   variable p = @Planet;
   p.X = X;
   p.V = V * DAYS_PER_YEAR;
   p.mass = mass * SOLAR_MASS;
   return p;
}

private variable Jupiter =
  make_planet ([4.84143144246472090e+00,-1.16032004402742839e+00,-1.03622044471123109e-01],
	       [1.66007664274403694e-03, 7.69901118419740425e-03,-6.90460016972063023e-05],
	       9.54791938424326609e-04);
private variable Saturn =
  make_planet ([8.34336671824457987e+00,4.12479856412430479e+00,-4.03523417114321381e-01],
	       [-2.76742510726862411e-03,4.99852801234917238e-03,2.30417297573763929e-05],
	       2.85885980666130812e-04);
private variable Uranus =
  make_planet ([1.28943695621391310e+01,-1.51111514016986312e+01,-2.23307578892655734e-01],
	       [2.96460137564761618e-03, 2.37847173959480950e-03,-2.96589568540237556e-05],
	       4.36624404335156298e-05);

private variable Neptune =
  make_planet ([1.53796971148509165e+01,-2.59193146099879641e+01,1.79258772950371181e-01],
	       [2.68067772490389322e-03, 1.62824170038242295e-03,-9.51592254519715870e-05],
	       5.15138902046611451e-05);
private variable Sun = make_planet ([0.0,0.0,0.0], [0.0,0.0,0.0], 1.0);

define slsh_main ()
{
   variable n = 1000;
   if (__argc == 2)
     n = integer (__argv[1]);

   variable bodies = [Sun, Jupiter, Saturn, Uranus, Neptune];
   offset_momentum (bodies);
   () = fprintf (stdout, "%.9f\n", energy(bodies));
   loop (n)
     advance (bodies, 0.01);
   () = fprintf (stdout, "%.9f\n", energy(bodies));
}
