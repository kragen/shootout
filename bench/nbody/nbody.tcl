#!/usr/bin/tclsh

# The Great Computer Language Shootout
# http://shootout.alioth.debian.org/
#
# contributed by Daniel South

set PI 3.141592653589793
set SOLAR_MASS [expr {4 * $PI * $PI}]
set DAYS_PER_YEAR 365.24

array set body "
   Sun,x 0 Sun,y 0 Sun,z 0 Sun,vx 0 Sun,vy 0 Sun,vz 0 Sun,mass
   $SOLAR_MASS

   Jupiter,x 4.84143144246472090e+00
   Jupiter,y -1.16032004402742839e+00
   Jupiter,z -1.03622044471123109e-01
   Jupiter,vx [expr {1.66007664274403694e-03 * $DAYS_PER_YEAR}]
   Jupiter,vy [expr {7.69901118419740425e-03 * $DAYS_PER_YEAR}]
   Jupiter,vz [expr {-6.90460016972063023e-05 * $DAYS_PER_YEAR}]
   Jupiter,mass [expr {9.54791938424326609e-04 * $SOLAR_MASS}]

   Saturn,x 8.34336671824457987e+00
   Saturn,y 4.12479856412430479e+00
   Saturn,z -4.03523417114321381e-01
   Saturn,vx [expr {-2.76742510726862411e-03 * $DAYS_PER_YEAR}]
   Saturn,vy [expr {4.99852801234917238e-03 * $DAYS_PER_YEAR}]
   Saturn,vz [expr {2.30417297573763929e-05 * $DAYS_PER_YEAR}]
   Saturn,mass [expr {2.85885980666130812e-04 * $SOLAR_MASS}]

   Uranus,x 1.28943695621391310e+01
   Uranus,y -1.51111514016986312e+01
   Uranus,z -2.23307578892655734e-01
   Uranus,vx [expr {2.96460137564761618e-03 * $DAYS_PER_YEAR}]
   Uranus,vy [expr {2.37847173959480950e-03 * $DAYS_PER_YEAR}]
   Uranus,vz [expr {-2.96589568540237556e-05 * $DAYS_PER_YEAR}]
   Uranus,mass [expr {4.36624404335156298e-05 * $SOLAR_MASS}]

   Neptune,x 1.53796971148509165e+01
   Neptune,y -2.59193146099879641e+01
   Neptune,z 1.79258772950371181e-01
   Neptune,vx [expr {2.68067772490389322e-03 * $DAYS_PER_YEAR}]
   Neptune,vy [expr {1.62824170038242295e-03 * $DAYS_PER_YEAR}]
   Neptune,vz [expr {-9.51592254519715870e-05 * $DAYS_PER_YEAR}]
   Neptune,mass [expr {5.15138902046611451e-05 * $SOLAR_MASS}]"


proc advance {b dt} {
   global body

   set n [llength $b]
   while {[incr n -1] > -1} {
      set b1 [lindex $b $n]
      set j $n
      while {[incr j -1] > -1} {
         set b2 [lindex $b $j]
         set dx [expr {$body($b1,x) - $body($b2,x)}]
         set dy [expr {$body($b1,y) - $body($b2,y)}]
         set dz [expr {$body($b1,z) - $body($b2,z)}]

         set d [expr {sqrt($dx * $dx + $dy * $dy + $dz * $dz)}]
         set mag [expr {$dt / ($d * $d * $d)}]
         set magmult1 [expr {$body($b2,mass) * $mag}]
         set magmult2 [expr {$body($b1,mass) * $mag}]

         set body($b1,vx) [expr {$body($b1,vx) - ($dx * $magmult1)}]
         set body($b1,vy) [expr {$body($b1,vy) - ($dy * $magmult1)}]
         set body($b1,vz) [expr {$body($b1,vz) - ($dz * $magmult1)}]

         set body($b2,vx) [expr {$body($b2,vx) + ($dx * $magmult2)}]
         set body($b2,vy) [expr {$body($b2,vy) + ($dy * $magmult2)}]
         set body($b2,vz) [expr {$body($b2,vz) + ($dz * $magmult2)}]
      }
      set body($b1,x) [expr {$body($b1,x) + ($dt * $body($b1,vx))}]
      set body($b1,y) [expr {$body($b1,y) + ($dt * $body($b1,vy))}]
      set body($b1,z) [expr {$body($b1,z) + ($dt * $body($b1,vz))}]
   }
}


proc energy {b} {
   global body
   set e 0

   set n [llength $b]
   while {[incr n -1] > -1} {
      set b1 [lindex $b $n]
      set e [expr {$e + (0.5 * $body($b1,mass) * ( $body($b1,vx) \
         * $body($b1,vx) + $body($b1,vy) * $body($b1,vy) + $body($b1,vz) \
         * $body($b1,vz) ))}]

      set j $n
      while {[incr j -1] > -1} {
         set b2 [lindex $b $j]
         set dx [expr {$body($b1,x) - $body($b2,x)}]
         set dy [expr {$body($b1,y) - $body($b2,y)}]
         set dz [expr {$body($b1,z) - $body($b2,z)}]

         set d [expr {sqrt($dx * $dx + $dy * $dy + $dz * $dz)}]
         set e [expr {$e - (($body($b1,mass) * $body($b2,mass)) / $d)}]
      }
   }
   return $e
}


proc offsetMomentum {b} {
   global body SOLAR_MASS
   foreach {px py pz} {0 0 0} break

   foreach b1 $b {
      set px [expr {$px + $body($b1,vx) * $body($b1,mass)}]
      set py [expr {$py + $body($b1,vy) * $body($b1,mass)}]
      set pz [expr {$pz + $body($b1,vz) * $body($b1,mass)}]
   }
   set body(Sun,vx) [expr {-$px / $SOLAR_MASS}]
   set body(Sun,vy) [expr {-$py / $SOLAR_MASS}]
   set body(Sun,vz) [expr {-$pz / $SOLAR_MASS}]
}


proc main {n} {
   set bodyNames "Sun Jupiter Saturn Uranus Neptune"

   offsetMomentum $bodyNames
   puts [format "%0.9f" [energy $bodyNames]]

   incr n
   while {[incr n -1]} {advance $bodyNames 0.01}
   puts [format "%0.9f" [energy $bodyNames]]
}


set N [lindex $argv 0]
if {$N < 1} {set N 1000}
main $N