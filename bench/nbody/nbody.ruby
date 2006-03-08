#!/usr/bin/ruby -w
# The Great Computer Language Shootout
# http://shootout.alioth.debian.org
#
# Modified for succinctness by Greg Buchholz
# Originally by Michael Neumann

require 'matrix'

SOLAR_MASS = 4 * Math::PI**2
DAYS = 365.24

Planet = Struct.new(:mass, :pos, :vel)

class Array 
  def sum; self.inject{|sum, x| sum + x} end
end

class Vector
  def mag; Math.sqrt(self.inner_product(self)) end
end

def offset_momentum(bodies)
  bodies[0].vel = bodies.map{|x| x.vel * x.mass }.sum * (-1.0/SOLAR_MASS)
end

def energy(b)
  kinetic   = 0.5 * b.map{|x| x.mass * x.vel.inner_product(x.vel)}.sum
  potential = 0.0

  for i in 0 ... b.size
    for j in (i+1) ... b.size
      potential += (b[i].mass * b[j].mass) / (b[i].pos - b[j].pos).mag
    end
  end
  return kinetic - potential
end

def advance(b, dt)
  for i in 0 ... b.size
    for j in (i+1) ... b.size
      dx = (b[i].pos - b[j].pos)
      dist = dx.mag
      m = dt / (dist * dist * dist)
      b[i].vel -= dx * b[j].mass * m
      b[j].vel += dx * b[i].mass * m
    end
    b[i].pos += b[i].vel * dt
  end
end

sun = Planet.new(SOLAR_MASS, Vector[0, 0, 0], Vector[0, 0, 0])
jupiter = Planet.new(9.54791938424326609e-04 * SOLAR_MASS,
 Vector[ 4.84143144246472090e+00,-1.16032004402742839e+00,-1.03622044471123109e-01],
 Vector[ 1.66007664274403694e-03, 7.69901118419740425e-03,-6.90460016972063023e-05])
saturn  = Planet.new(2.85885980666130812e-04 * SOLAR_MASS,
 Vector[ 8.34336671824457987e+00, 4.12479856412430479e+00,-4.03523417114321381e-01],
 Vector[-2.76742510726862411e-03, 4.99852801234917238e-03, 2.30417297573763929e-05])
uranus  = Planet.new(4.36624404335156298e-05 * SOLAR_MASS,
 Vector[ 1.28943695621391310e+01,-1.51111514016986312e+01,-2.23307578892655734e-01],
 Vector[ 2.96460137564761618e-03, 2.37847173959480950e-03,-2.96589568540237556e-05])
neptune = Planet.new(5.15138902046611451e-05 * SOLAR_MASS,
 Vector[ 1.53796971148509165e+01,-2.59193146099879641e+01, 1.79258772950371181e-01],
 Vector[ 2.68067772490389322e-03, 1.62824170038242295e-03,-9.51592254519715870e-05])

BODIES = [sun, jupiter, saturn, uranus, neptune].collect{|x| x.vel *= DAYS; x}

offset_momentum(BODIES)
puts "%.9f" % energy(BODIES)
Integer(ARGV[0]).times { advance(BODIES, 0.01) }
puts "%.9f" % energy(BODIES)


