(* The Great Computer Language Shootout
   http://shootout.alioth.debian.org

   contributed by Isaac Gouy (Oberon-2 novice)

   To run:   nbody 1000000
*)


MODULE nbody;
IMPORT Shootout, LRealMath, Out;

CONST
   PI = 3.141592653589793D+00;
   SOLAR_MASS = 4.0D+00 * PI * PI;
   DAYS_PER_YEAR = 365.24D+00;

TYPE
   Body = RECORD x, y, z, vx, vy, vz, mass: LONGREAL; END;

VAR
   i, n: LONGINT;
   sun, jupiter, saturn, uranus, neptune: Body;
   bodies: ARRAY 5 OF Body;

PROCEDURE Advance(VAR bodies: ARRAY OF Body; dt: LONGREAL);
VAR
   dx, dy, dz, distance, mag: LONGREAL;
   i, j, n: LONGINT;
BEGIN
   n := LEN(bodies) - 1;
   FOR i := 0 TO n DO
      FOR j := i+1 TO n DO
         dx := bodies[i].x - bodies[j].x;
         dy := bodies[i].y - bodies[j].y;
         dz := bodies[i].z - bodies[j].z;

         distance := LRealMath.sqrt(dx*dx + dy*dy + dz*dz);
         mag := dt / (distance * distance * distance);

         bodies[i].vx := bodies[i].vx - (dx * bodies[j].mass * mag);
         bodies[i].vy := bodies[i].vy - (dy * bodies[j].mass * mag);
         bodies[i].vz := bodies[i].vz - (dz * bodies[j].mass * mag);

         bodies[j].vx := bodies[j].vx + (dx * bodies[i].mass * mag);
         bodies[j].vy := bodies[j].vy + (dy * bodies[i].mass * mag);
         bodies[j].vz := bodies[j].vz + (dz * bodies[i].mass * mag);
      END;
   END;

   FOR i := 0 TO n DO
      bodies[i].x := bodies[i].x + (dt * bodies[i].vx);
      bodies[i].y := bodies[i].y + (dt * bodies[i].vy);
      bodies[i].z := bodies[i].z + (dt * bodies[i].vz);
   END;
END Advance;


PROCEDURE Energy(VAR bodies: ARRAY OF Body): LONGREAL;
VAR
   e, dx, dy, dz, distance: LONGREAL;
   i, j, n: LONGINT;
BEGIN
   e := 0.0D+00;
   n := LEN(bodies) - 1;
   FOR i := 0 TO n DO
      e := e + (0.5D+00 * bodies[i].mass *
         ( bodies[i].vx * bodies[i].vx
         + bodies[i].vy * bodies[i].vy
         + bodies[i].vz * bodies[i].vz ));
	 	 	
      FOR j := i+1 TO n DO
         dx := bodies[i].x - bodies[j].x;
         dy := bodies[i].y - bodies[j].y;
         dz := bodies[i].z - bodies[j].z;

         distance := LRealMath.sqrt(dx*dx + dy*dy + dz*dz);	
         e := e - (bodies[i].mass * bodies[j].mass / distance);	
      END;
   END;
   RETURN e;
END Energy;


PROCEDURE OffsetMomentum(VAR bodies: ARRAY OF Body);
VAR
   px, py, pz: LONGREAL;
   i: LONGINT;
BEGIN
   px := 0.0D+00; py := 0.0D+00; pz := 0.0D+00;
   FOR i := 0 TO LEN(bodies)-1 DO
      px := px + (bodies[i].vx * bodies[i].mass);
      py := py + (bodies[i].vy * bodies[i].mass);
      pz := pz + (bodies[i].vz * bodies[i].mass);
   END;
   bodies[0].vx := -px / SOLAR_MASS;
   bodies[0].vy := -py / SOLAR_MASS;
   bodies[0].vz := -pz / SOLAR_MASS;
END OffsetMomentum;


BEGIN
   n := Shootout.Argi();

   (* define planetary masses, initial positions, velocities *)

   jupiter.x := 4.84143144246472090D+00;
   jupiter.y := -1.16032004402742839D+00;
   jupiter.z := -1.03622044471123109D-01;
   jupiter.vx := 1.66007664274403694D-03 * DAYS_PER_YEAR;
   jupiter.vy := 7.69901118419740425D-03 * DAYS_PER_YEAR;
   jupiter.vz := -6.90460016972063023D-05 * DAYS_PER_YEAR;
   jupiter.mass := 9.54791938424326609D-04 * SOLAR_MASS;

   saturn.x := 8.34336671824457987D+00;
   saturn.y := 4.12479856412430479D+00;
   saturn.z := -4.03523417114321381D-01;
   saturn.vx := -2.76742510726862411D-03 * DAYS_PER_YEAR;
   saturn.vy := 4.99852801234917238D-03 * DAYS_PER_YEAR;
   saturn.vz := 2.30417297573763929D-05 * DAYS_PER_YEAR;
   saturn.mass := 2.85885980666130812D-04 * SOLAR_MASS;

   uranus.x := 1.28943695621391310D+01;
   uranus.y := -1.51111514016986312D+01;
   uranus.z := -2.23307578892655734D-01;
   uranus.vx := 2.96460137564761618D-03 * DAYS_PER_YEAR;
   uranus.vy := 2.37847173959480950D-03 * DAYS_PER_YEAR;
   uranus.vz := -2.96589568540237556D-05 * DAYS_PER_YEAR;
   uranus.mass := 4.36624404335156298D-05 * SOLAR_MASS;

   neptune.x := 1.53796971148509165D+01;
   neptune.y := -2.59193146099879641D+01;
   neptune.z := 1.79258772950371181D-01;
   neptune.vx := 2.68067772490389322D-03 * DAYS_PER_YEAR;
   neptune.vy := 1.62824170038242295D-03 * DAYS_PER_YEAR;
   neptune.vz := -9.51592254519715870D-05 * DAYS_PER_YEAR;
   neptune.mass := 5.15138902046611451D-05 * SOLAR_MASS;

   sun.x := 0.0; sun.y := 0.0; sun.z := 0.0;
   sun.vx := 0.0; sun.vy := 0.0; sun.vz := 0.0; sun.mass := SOLAR_MASS;

   bodies[0] := sun;
   bodies[1] := jupiter; bodies[2] := saturn;
   bodies[3] := uranus; bodies[4] := neptune;

   OffsetMomentum(bodies);

   Out.LongRealFix( Energy(bodies), 0,9); Out.Ln;
   FOR i := 1 TO n DO Advance(bodies,0.01D+00); END;
   Out.LongRealFix( Energy(bodies), 0,9); Out.Ln;
END nbody.
