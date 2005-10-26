#!/usr/bin/env slsh
% The Computer Language Shootout Benchmarks
% http://shootout.alioth.debian.org/
%
% contributed by John E. Davis
private variable SOLAR_MASS = 4 * PI * PI;
private variable DAYS_PER_YEAR = 365.24;

typedef struct { X, V, mass } Planet;

private define advance_n (num, bodies, dt)
{
   variable X = bodies.X, V = bodies.V;
   variable n3 = length (V), n = n3/3;
   variable i = [0:n*n-1]/n, j = [0:n*n-1] mod n, k = [3,n,n];
   variable I = [i, i+n, i+2*n]; reshape (I, k);
   variable J = [j, j+n, j+2*n]; reshape (J, k);
   variable mass_dt = dt * bodies.mass[_reshape(i,[n,n])];
   variable expon = Double_Type[n,n] - 1.5; expon[[::n+1]] = 0.0;
   loop (num)
     {
	variable dX = X[I] - X[J];
	variable a = mass_dt*(sum(dX*dX,0))^expon;
	a = [a, a, a]; reshape (a, k);
	V = V + sum (a*dX, 1);
	X = X + V*dt;
     }
   bodies.V = V; bodies.X = X;
}


private define energy (bodies)
{
   variable mass = bodies.mass,  nbodies = length (mass);
   variable V = bodies.V, X = bodies.X;
   variable x = X[0,*], y = X[1,*], z = X[2,*];
   variable e = 0.5 * sum (mass * sum (V*V, 0));
   _for (0, nbodies-1, 1)
     {
	variable i = ();
	variable j = [i+1:];
	e -= sum((mass[i]*mass[j])/sqrt((x[i]-x[j])^2+(y[i]-y[j])^2+(z[i]-z[j])^2));
     }
   return e;
}

private define offset_momentum (bodies)
{
   bodies.V[*,0] = -bodies.V#(bodies.mass/SOLAR_MASS);
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

private define pack_bodies (bodies)
{
   variable s = @Planet;
   variable i, n = length (bodies);
   s.X = Double_Type[3,n]; s.V = Double_Type[3,n]; s.mass = Double_Type[n];
   _for i (0, n-1, 1)
     {
	variable b = bodies[i];
	s.X[*,i] = b.X; s.V[*,i] = b.V;
	s.mass[i] = b.mass;
     }
   return s;
}

define slsh_main ()
{
   variable n = 1000;
   if (__argc == 2)
     n = integer (__argv[1]);

   variable bodies = pack_bodies ([Sun, Jupiter, Saturn, Uranus, Neptune]);
   offset_momentum (bodies);
   () = fprintf (stdout, "%.9f\n", energy(bodies));
   advance_n (n, bodies, 0.01);
   () = fprintf (stdout, "%.9f\n", energy(bodies));
}
