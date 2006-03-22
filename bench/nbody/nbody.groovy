// ---------------------------------------------------------------------
// The Great Computer Language Shootout
// http://shootout.alioth.debian.org/
// 
// Based on an amalgam of the Scala and Scheme Chicken [imperative version]
// implementations
//
// Contributed by Anthony Borla
// ---------------------------------------------------------------------

import java.text.DecimalFormat

// --------------------------------

class Body
{
  @Property double x, y, z, vx, vy, vz, mass
}

// --------------

def offsetMomentum(List system)
{
  px = py = pz = 0.0D
    
  for (i in system)
  {
    px = px + i.vx * i.mass; py = py + i.vy * i.mass; pz = pz + i.vz * i.mass;
  }

  system[0].vx = -px / SOLAR_MASS; system[0].vy = -py / SOLAR_MASS; system[0].vz = -pz / SOLAR_MASS
}

// --------------

def energy(List system)
{
  dx = dy = dz = e = distance = 0.0D; int idx = 1, limit = system.size() - 1

  for (i in system)
  {
    e += 0.5D * i.mass * (i.vx * i.vx + i.vy * i.vy + i.vz * i.vz)

    if (idx > limit) break

    for (j in system[idx .. limit])
    {
      dx = i.x - j.x; dy = i.y - j.y; dz = i.z - j.z
      distance = Math.sqrt(dx * dx + dy * dy + dz * dz)
      e -= i.mass * j.mass / distance
    }

    idx += 1
  }

  return e
}

// --------------

def advance(List system, double dt)
{
  dx = dy = dz = mag = distance = 0.0D; int idx = 1, limit = system.size() - 1

  for (i in system)
  {
    if (idx > limit) break

    for (j in system[idx .. limit])
    {
      dx = i.x - j.x; dy = i.y - j.y; dz = i.z - j.z

      distance = Math.sqrt(dx * dx + dy * dy + dz * dz)
      mag = dt / (distance * distance * distance)

      i.vx -= dx * j.mass * mag; i.vy -= dy * j.mass * mag; i.vz -= dz * j.mass * mag
      j.vx += dx * i.mass * mag; j.vy += dy * i.mass * mag; j.vz += dz * i.mass * mag
    }

    idx += 1
  }

  for (i in system)
  {
    i.x += dt * i.vx; i.y += dt * i.vy; i.z += dt * i.vz
  }
}

// --------------------------------

def main()
{
  n = Integer.parseInt(args[0])

  PI = 3.141592653589793D; SOLAR_MASS = 4.0D * PI * PI; DAYS_PER_YEAR = 365.24D

  // sun jupiter saturn uranus neptune

  system = [
    new Body(x:0.0D, y:0.0D, z:0.0D, vx:0.0D, vy:0.0D, vz:0.0D, mass:SOLAR_MASS), 

    new Body(x:4.84143144246472090e+00D, y:-1.16032004402742839e+00D, z:-1.03622044471123109e-01D,
             vx:1.66007664274403694e-03D * DAYS_PER_YEAR, vy:7.69901118419740425e-03D * DAYS_PER_YEAR,
             vz:-6.90460016972063023e-05D * DAYS_PER_YEAR, mass:9.54791938424326609e-04D * SOLAR_MASS), 

    new Body(x:8.34336671824457987e+00D, y:4.12479856412430479e+00D, z:-4.03523417114321381e-01D,
             vx:-2.76742510726862411e-03D * DAYS_PER_YEAR, vy:4.99852801234917238e-03D * DAYS_PER_YEAR,
             vz:2.30417297573763929e-05D * DAYS_PER_YEAR, mass:2.85885980666130812e-04D * SOLAR_MASS),
        
    new Body(x:1.28943695621391310e+01D, y:-1.51111514016986312e+01D, z:-2.23307578892655734e-01D,
             vx:2.96460137564761618e-03D * DAYS_PER_YEAR, vy:2.37847173959480950e-03D * DAYS_PER_YEAR,
             vz:-2.96589568540237556e-05D * DAYS_PER_YEAR, mass:4.36624404335156298e-05D * SOLAR_MASS),

    new Body(x:1.53796971148509165e+01D, y:-2.59193146099879641e+01D, z:1.79258772950371181e-01D,
             vx:2.68067772490389322e-03D * DAYS_PER_YEAR, vy:1.62824170038242295e-03D * DAYS_PER_YEAR,
             vz:-9.51592254519715870e-05D * DAYS_PER_YEAR, mass:5.15138902046611451e-05D * SOLAR_MASS)
  ]

  fmt = new DecimalFormat("##0.000000000")

  offsetMomentum(system)
  println fmt.format(energy(system))

  1.upto(n) { advance(system, 0.01D) }

  println fmt.format(energy(system))
}

// --------------------------------

main()

