-- The Great Computer Language Shootout
-- http://shootout.alioth.debian.org/
--
-- contributed by Isaac Gouy


-- define planetary masses, initial positions & velocity

local PI = 3.141592653589793
local SOLAR_MASS = 4 * PI * PI
local DAYS_PER_YEAR = 365.24

local Jupiter = {
    x = 4.84143144246472090e+00
   ,y = -1.16032004402742839e+00
   ,z = -1.03622044471123109e-01
   ,vx = 1.66007664274403694e-03 * DAYS_PER_YEAR
   ,vy = 7.69901118419740425e-03 * DAYS_PER_YEAR
   ,vz = -6.90460016972063023e-05 * DAYS_PER_YEAR
   ,mass = 9.54791938424326609e-04 * SOLAR_MASS
}

local Saturn = {
    x = 8.34336671824457987e+00
   ,y = 4.12479856412430479e+00
   ,z = -4.03523417114321381e-01
   ,vx = -2.76742510726862411e-03 * DAYS_PER_YEAR
   ,vy = 4.99852801234917238e-03 * DAYS_PER_YEAR
   ,vz = 2.30417297573763929e-05 * DAYS_PER_YEAR
   ,mass = 2.85885980666130812e-04 * SOLAR_MASS
}

local Uranus = {
    x = 1.28943695621391310e+01
   ,y = -1.51111514016986312e+01
   ,z = -2.23307578892655734e-01
   ,vx = 2.96460137564761618e-03 * DAYS_PER_YEAR
   ,vy = 2.37847173959480950e-03 * DAYS_PER_YEAR
   ,vz = -2.96589568540237556e-05 * DAYS_PER_YEAR
   ,mass = 4.36624404335156298e-05 * SOLAR_MASS
}

local Neptune = {
    x = 1.53796971148509165e+01
   ,y = -2.59193146099879641e+01
   ,z = 1.79258772950371181e-01
   ,vx = 2.68067772490389322e-03 * DAYS_PER_YEAR
   ,vy = 1.62824170038242295e-03 * DAYS_PER_YEAR
   ,vz = -9.51592254519715870e-05 * DAYS_PER_YEAR
   ,mass = 5.15138902046611451e-05 * SOLAR_MASS
}

local Sun = { x = 0, y = 0, z = 0, 
              vx = 0, vy = 0, vz = 0, mass = SOLAR_MASS }


-- integrator

local function advance(bodies,dt)
   local dx, dy, dz, distance, mag
   local n = table.getn(bodies)

   for i = 1,n do
      for j = i+1,n do    
         dx = bodies[i].x - bodies[j].x
         dy = bodies[i].y - bodies[j].y
         dz = bodies[i].z - bodies[j].z

         distance = math.sqrt(dx*dx + dy*dy + dz*dz)
         mag = dt / (distance * distance * distance)

         bodies[i].vx = bodies[i].vx - (dx * bodies[j].mass * mag)
         bodies[i].vy = bodies[i].vy - (dy * bodies[j].mass * mag)
         bodies[i].vz = bodies[i].vz - (dz * bodies[j].mass * mag)

         bodies[j].vx = bodies[j].vx + (dx * bodies[i].mass * mag)
         bodies[j].vy = bodies[j].vy + (dy * bodies[i].mass * mag)
         bodies[j].vz = bodies[j].vz + (dz * bodies[i].mass * mag)
      end
   end   

   for i = 1,n do
      bodies[i].x = bodies[i].x + (dt * bodies[i].vx)
      bodies[i].y = bodies[i].y + (dt * bodies[i].vy)
      bodies[i].z = bodies[i].z + (dt * bodies[i].vz)
   end
end


local function energy(bodies)
   local e, dx, dy, dz, distance = 0
   local n = table.getn(bodies)

   for i = 1,n do
      e = e + (0.5 * bodies[i].mass *
         ( bodies[i].vx * bodies[i].vx
         + bodies[i].vy * bodies[i].vy
         + bodies[i].vz * bodies[i].vz ))
        
      for j = i+1,n do
         dx = bodies[i].x - bodies[j].x
         dy = bodies[i].y - bodies[j].y
         dz = bodies[i].z - bodies[j].z 

         distance = math.sqrt(dx*dx + dy*dy + dz*dz)
         e = e - ((bodies[i].mass * bodies[j].mass) / distance)
      end
   end
   return e
end


local function offsetMomentum(b)
   local px, py, pz = 0, 0, 0
   for i = 1,table.getn(b) do
      px = px + (b[i].vx * b[i].mass)
      py = py + (b[i].vy * b[i].mass)
      pz = pz + (b[i].vz * b[i].mass)
   end
   b[1].vx = -px / SOLAR_MASS
   b[1].vy = -py / SOLAR_MASS
   b[1].vz = -pz / SOLAR_MASS
end


-- orbital simulation for Jovian planets

local n = tonumber(arg and arg[1]) or 1000
local bodies = { Sun, Jupiter, Saturn, Uranus, Neptune }
offsetMomentum(bodies)

io.write( string.format("%0.9f",energy(bodies)), "\n")
for i = 1,n do advance(bodies,0.01) end
io.write( string.format("%0.9f",energy(bodies)), "\n")