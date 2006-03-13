// ---------------------------------------------------------------------
// The Great Computer Language Shootout
// http://shootout.alioth.debian.org/
//
// Based on D language implementation by Dave Fladebo
//
// Contributed by Anthony Borla
// ---------------------------------------------------------------------

final class NBodySystem
{
  constant PI = 3.141592653589793;
  constant SOLAR_MASS = 4 * PI * PI;
  constant DAYS_PER_YEAR = 365.24;

  static void create()
  {
    float px, py, pz;

    foreach(bodies, Body i)
    {
      px += i->vx * i->mass; py += i->vy * i->mass; pz += i->vz * i->mass;
    }

    bodies[0]->offsetMomentum(px, py, pz);
  }

  public void advance(float dt)
  {
    float dx, dy, dz, distance, mag;

    int idx, length = sizeof(bodies);

    foreach(bodies, Body i)
    {
      foreach(bodies[idx + 1 .. length], Body j)
      {
        dx = i->x - j->x;
        dy = i->y - j->y;
        dz = i->z - j->z;

        distance = sqrt(dx * dx + dy * dy + dz * dz);
        mag = dt / (distance * distance * distance);

        i->vx -= dx * j->mass * mag;
        i->vy -= dy * j->mass * mag;
        i->vz -= dz * j->mass * mag;

        j->vx += dx * i->mass * mag;
        j->vy += dy * i->mass * mag;
        j->vz += dz * i->mass * mag;
      }

      idx += 1;
    }

    foreach(bodies, Body i)
    {
      i->x += dt * i->vx; i->y += dt * i->vy; i->z += dt * i->vz;
    }
  }

  public float energy()
  {
    float dx, dy, dz, e, distance;

    int idx, length = sizeof(bodies);

    foreach(bodies, Body i)
    {
      e += 0.5 * i->mass * (i->vx * i->vx + i->vy * i->vy + i->vz * i->vz);

      foreach(bodies[idx + 1 .. length], Body j)
      {
        dx = i->x - j->x; dy = i->y - j->y; dz = i->z - j->z;
        distance = sqrt(dx * dx + dy * dy + dz * dz);
        e -= (i->mass * j->mass) / distance;
      }

      idx += 1;
    }

    return e;
  }

  private final class Body
  {
    static void create(float x, float y, float z, float vx, float vy, float vz, float mass)
    {
      this->x = x; this->y = y; this->z = z;
      this->vx = vx; this->vy = vy; this->vz = vz;
      this->mass = mass;
    }

    void offsetMomentum(float px, float py, float pz)
    {
      vx = -px / SOLAR_MASS;
      vy = -py / SOLAR_MASS;
      vz = -pz / SOLAR_MASS;
    }

    float x, y, z, vx, vy, vz, mass;
  }

  // sun jupiter saturn uranus neptune

  private array(Body) bodies =
    ({
      Body(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, SOLAR_MASS),

      Body(4.84143144246472090e+00, -1.16032004402742839e+00, -1.03622044471123109e-01,
           1.66007664274403694e-03 * DAYS_PER_YEAR, 7.69901118419740425e-03 * DAYS_PER_YEAR,
           -6.90460016972063023e-05 * DAYS_PER_YEAR, 9.54791938424326609e-04 * SOLAR_MASS),

      Body(8.34336671824457987e+00, 4.12479856412430479e+00, -4.03523417114321381e-01,
           -2.76742510726862411e-03 * DAYS_PER_YEAR, 4.99852801234917238e-03 * DAYS_PER_YEAR,
           2.30417297573763929e-05 * DAYS_PER_YEAR, 2.85885980666130812e-04 * SOLAR_MASS),
        
      Body(1.28943695621391310e+01, -1.51111514016986312e+01, -2.23307578892655734e-01,
           2.96460137564761618e-03 * DAYS_PER_YEAR, 2.37847173959480950e-03 * DAYS_PER_YEAR,
           -2.96589568540237556e-05 * DAYS_PER_YEAR, 4.36624404335156298e-05 * SOLAR_MASS),

      Body(1.53796971148509165e+01, -2.59193146099879641e+01, 1.79258772950371181e-01,
           2.68067772490389322e-03 * DAYS_PER_YEAR, 1.62824170038242295e-03 * DAYS_PER_YEAR,
           -9.51592254519715870e-05 * DAYS_PER_YEAR, 5.15138902046611451e-05 * SOLAR_MASS)
    });
}

// --------------------------------

int main(int argc, array(string) argv)
{
  int N = (int)argv[1];

  NBodySystem nbs = NBodySystem();

  write("%.9f\n", nbs->energy());
  for(int i = 0; i < N; i++) nbs->advance(0.01);
  write("%.9f\n", nbs->energy());

  return 0;
}

