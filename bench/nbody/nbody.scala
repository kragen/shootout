/* ------------------------------------------------------------------ */
/* The Great Computer Language Shootout                               */
/* http://shootout.alioth.debian.org/                                 */
/*                                                                    */
/* Based on D language implementation by Dave Fladebo                 */
/*                                                                    */
/* Modified to compile under Scala 1.x though comments mention        */
/* where Scala 2.0 features are more appropriate                      */
/*                                                                    */
/* Contributed by Anthony Borla                                       */
/* ------------------------------------------------------------------ */

object nbody
{
  def main(args: Array[String]): unit =
  {
    val N = Integer.parseInt(args(0));
    val nbs = new NBodySystem;

    Console.printf("{0,number,0.000000000}\n")(nbs.energy);
    var i = 0; while (i < N) { nbs.advance(0.01); i = i + 1; }
    Console.printf("{0,number,0.000000000}\n")(nbs.energy);
  }
}

final class NBodySystem
{
  // Interface

  def advance(_dt: double): unit =
  {
    var dx: double = 0.0;  var dy: double = 0.0;
    var dz: double = 0.0;  var mag: double = 0.0;
    var distance: double = 0.0;

    var idx: int = 0; val length: int = bodies.length;

    for (val i <- bodies)
    {

      // Scala 2.0 would use:
      //
      // for (val j <- bodies.subArray(idx + 1, length))
      //
      for (val j <- subArray(idx + 1, length, bodies))
      {
        dx = i.x - j.x;
        dy = i.y - j.y;
        dz = i.z - j.z;

        distance = Math.sqrt(dx * dx + dy * dy + dz * dz);
        mag = _dt / (distance * distance * distance);

        i.vx = i.vx - dx * j.mass * mag;
        i.vy = i.vy - dy * j.mass * mag;
        i.vz = i.vz - dz * j.mass * mag;

        j.vx = j.vx + dx * i.mass * mag;
        j.vy = j.vy + dy * i.mass * mag;
        j.vz = j.vz + dz * i.mass * mag;
      }

      idx = idx + 1;
    }

    for (val i <- bodies)
    {
      i.x = i.x + _dt * i.vx; i.y = i.y + _dt * i.vy; i.z = i.z + _dt * i.vz;
    }
  }

  def energy(): double =
  {
    var dx: double = 0.0;  var dy: double = 0.0;
    var dz: double = 0.0;  var e: double = 0.0;
    var distance: double = 0.0;

    var idx: int = 0; val length: int = bodies.length;

    for (val i <- bodies)
    {
      e = e + 0.5 * i.mass * (i.vx * i.vx + i.vy * i.vy + i.vz * i.vz);

      // Scala 2.0 would use:
      //
      // for (val j <- bodies.subArray(idx + 1, length))
      //
      for (val j <- subArray(idx + 1, length, bodies))
      {
        dx = i.x - j.x; dy = i.y - j.y; dz = i.z - j.z;
        distance = Math.sqrt(dx * dx + dy * dy + dz * dz);
        e = e - (i.mass * j.mass) / distance;
      }

      idx = idx + 1;
    }

    return e;
  }

  //
  // Required for Scala 1.x only
  // Method for slicing an array based on Scala 2.x implementation 
  // of 'Array.subArray'
  //
  def subArray(_from: int, _end: int, arr: Array[Body]): Array[Body] =
  {
    val last: int = arr.length - 1;

    var end: int = _end; if (_end > last) end = last;
    var i: int = _from; if (_from < 0) i = 0;
    var offset: int = 0 - i;

    val newarr: Array[Body] = new Array[Body](arr.length + offset);

    while (i <= end) { newarr(i + offset) = arr(i); i = i + 1; }

    return newarr;
  }

  // Data

  protected class Body(_x: double, _y: double, _z: double, _vx: double, _vy: double, _vz: double, _mass: double)
  {
    def offsetMomentum(_px: double, _py: double, _pz: double): unit =
    {
      vx = -(_px) / SOLAR_MASS;
      vy = -(_py) / SOLAR_MASS;
      vz = -(_pz) / SOLAR_MASS;
    }

    override def toString(): String =
    {
      return "[(" + x + "," + y + "," + z + "), ("+ vx + "," + vy + "," + vz + "), (" + mass + ")]";
    }

    var x: double = _x;
    var y: double = _y;
    var z: double = _z;

    var vx: double = _vx;
    var vy: double = _vy;
    var vz: double = _vz;

    var mass: double = _mass;
  }

  private val PI = 3.141592653589793;
  private val SOLAR_MASS = 4 * PI * PI;
  private val DAYS_PER_YEAR = 365.24;

  // sun jupiter saturn uranus neptune

  private val bodies: Array[Body] = Array(
    new Body(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, SOLAR_MASS), 

    new Body(4.84143144246472090e+00, -1.16032004402742839e+00, -1.03622044471123109e-01,
             1.66007664274403694e-03 * DAYS_PER_YEAR, 7.69901118419740425e-03 * DAYS_PER_YEAR,
             -6.90460016972063023e-05 * DAYS_PER_YEAR, 9.54791938424326609e-04 * SOLAR_MASS), 

    new Body(8.34336671824457987e+00, 4.12479856412430479e+00, -4.03523417114321381e-01,
             -2.76742510726862411e-03 * DAYS_PER_YEAR, 4.99852801234917238e-03 * DAYS_PER_YEAR,
             2.30417297573763929e-05 * DAYS_PER_YEAR, 2.85885980666130812e-04 * SOLAR_MASS),
        
    new Body(1.28943695621391310e+01, -1.51111514016986312e+01, -2.23307578892655734e-01,
             2.96460137564761618e-03 * DAYS_PER_YEAR, 2.37847173959480950e-03 * DAYS_PER_YEAR,
             -2.96589568540237556e-05 * DAYS_PER_YEAR, 4.36624404335156298e-05 * SOLAR_MASS),

    new Body(1.53796971148509165e+01, -2.59193146099879641e+01, 1.79258772950371181e-01,
             2.68067772490389322e-03 * DAYS_PER_YEAR, 1.62824170038242295e-03 * DAYS_PER_YEAR,
            -9.51592254519715870e-05 * DAYS_PER_YEAR, 5.15138902046611451e-05 * SOLAR_MASS)
  );

  // Constructor Block

  {
    var px: double = 0.0;
    var py: double = 0.0;
    var pz: double = 0.0;
    
    for (val i <- bodies)
    {
      px = px + i.vx * i.mass; py = py + i.vy * i.mass; pz = pz + i.vz * i.mass;
    }

    bodies(0).offsetMomentum(px, py, pz);
  }
}

