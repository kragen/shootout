#!/usr/bin/tclsh
# $Id: nbody.tcl-2.tcl,v 1.1 2005-04-18 05:34:15 igouy-guest Exp $
#
# The Great Computer Language Shootout
# http://shootout.alioth.debian.org/
#
# Contributed by Daniel South
# Modified by Hemang Lavana

set PI 3.141592653589793
set SOLAR_MASS [expr {4 * $PI * $PI}]
set DAYS_PER_YEAR 365.24

proc init {body var_values} {
    global x y z vx vy vz mass
    foreach {var value} $var_values {lappend $var $value}
}

init Sun "x 0 y 0 z 0 vx 0 vy 0 vz 0 mass $SOLAR_MASS"

init Jupiter "x    4.84143144246472090e+00"
init Jupiter "y    -1.16032004402742839e+00"
init Jupiter "z    -1.03622044471123109e-01"
init Jupiter "vx   [expr {1.66007664274403694e-03  * $DAYS_PER_YEAR}]"
init Jupiter "vy   [expr {7.69901118419740425e-03  * $DAYS_PER_YEAR}]"
init Jupiter "vz   [expr {-6.90460016972063023e-05 * $DAYS_PER_YEAR}]"
init Jupiter "mass [expr {9.54791938424326609e-04  * $SOLAR_MASS}]"

init Saturn "x    8.34336671824457987e+00"
init Saturn "y    4.12479856412430479e+00"
init Saturn "z    -4.03523417114321381e-01"
init Saturn "vx   [expr {-2.76742510726862411e-03 * $DAYS_PER_YEAR}]"
init Saturn "vy   [expr {4.99852801234917238e-03  * $DAYS_PER_YEAR}]"
init Saturn "vz   [expr {2.30417297573763929e-05  * $DAYS_PER_YEAR}]"
init Saturn "mass [expr {2.85885980666130812e-04  * $SOLAR_MASS}]"

init Uranus "x    1.28943695621391310e+01"
init Uranus "y    -1.51111514016986312e+01"
init Uranus "z    -2.23307578892655734e-01"
init Uranus "vx   [expr {2.96460137564761618e-03  * $DAYS_PER_YEAR}]"
init Uranus "vy   [expr {2.37847173959480950e-03  * $DAYS_PER_YEAR}]"
init Uranus "vz   [expr {-2.96589568540237556e-05 * $DAYS_PER_YEAR}]"
init Uranus "mass [expr {4.36624404335156298e-05  * $SOLAR_MASS}]"

init Neptune "x    1.53796971148509165e+01"
init Neptune "y    -2.59193146099879641e+01"
init Neptune "z    1.79258772950371181e-01"
init Neptune "vx   [expr {2.68067772490389322e-03  * $DAYS_PER_YEAR}]"
init Neptune "vy   [expr {1.62824170038242295e-03  * $DAYS_PER_YEAR}]"
init Neptune "vz   [expr {-9.51592254519715870e-05 * $DAYS_PER_YEAR}]"
init Neptune "mass [expr {5.15138902046611451e-05  * $SOLAR_MASS}]"


proc advance {b dt} {
    global x y z vx vy vz mass

    for {set i 0; set n [llength $b]} {$i < $n} {incr i} {
        for {set j [expr {$i+1}]} {$j < $n} {incr j} {
            set dx [expr {[lindex $x $i] - [lindex $x $j]}]
            set dy [expr {[lindex $y $i] - [lindex $y $j]}]
            set dz [expr {[lindex $z $i] - [lindex $z $j]}]

            set d [expr {sqrt($dx * $dx + $dy * $dy + $dz * $dz)}]
            set mag [expr {$dt / ($d * $d * $d)}]
            set magmult1 [expr {[lindex $mass $j] * $mag}]
            set magmult2 [expr {[lindex $mass $i] * $mag}]

            lset vx $i [expr {[lindex $vx $i] - ($dx * $magmult1)}]
            lset vy $i [expr {[lindex $vy $i] - ($dy * $magmult1)}]
            lset vz $i [expr {[lindex $vz $i] - ($dz * $magmult1)}]

            lset vx $j [expr {[lindex $vx $j] + ($dx * $magmult2)}]
            lset vy $j [expr {[lindex $vy $j] + ($dy * $magmult2)}]
            lset vz $j [expr {[lindex $vz $j] + ($dz * $magmult2)}]
        }
    }

    for {set i 0; set n [llength $b]} {$i < $n} {incr i} {
        lset x $i [expr {[lindex $x $i] + ($dt * [lindex $vx $i])}]
        lset y $i [expr {[lindex $y $i] + ($dt * [lindex $vy $i])}]
        lset z $i [expr {[lindex $z $i] + ($dt * [lindex $vz $i])}]
    }
}


proc energy {b} {
    global x y z vx vy vz mass
    set e 0

    for {set i 0; set n [llength $b]} {$i < $n} {incr i} {
        set e [expr {$e + (0.5 * [lindex $mass $i] * (     \
                     ([lindex $vx $i] * [lindex $vx $i]) + \
                     ([lindex $vy $i] * [lindex $vy $i]) + \
                     ([lindex $vz $i] * [lindex $vz $i]) ))}]

        for {set j [expr {$i+1}]} {$j < $n} {incr j} {
            set dx [expr {[lindex $x $i] - [lindex $x $j]}]
            set dy [expr {[lindex $y $i] - [lindex $y $j]}]
            set dz [expr {[lindex $z $i] - [lindex $z $j]}]

            set d [expr {sqrt($dx * $dx + $dy * $dy + $dz * $dz)}]
            set e [expr {$e - (([lindex $mass $i] * [lindex $mass $j]) / $d)}]
      }
   }
   return $e
}


proc offsetMomentum {b} {
    global x y z vx vy vz mass SOLAR_MASS
    foreach {px py pz} {0 0 0} break

    for {set i 0; set n [llength $b]} {$i < $n} {incr i} {
        set px [expr {$px + [lindex $vx $i] * [lindex $mass $i]}]
        set py [expr {$py + [lindex $vy $i] * [lindex $mass $i]}]
        set pz [expr {$pz + [lindex $vz $i] * [lindex $mass $i]}]
    }
    set i [lsearch -exact $b Sun]
    lset vx $i [expr {-$px / $SOLAR_MASS}]
    lset vy $i [expr {-$py / $SOLAR_MASS}]
    lset vz $i [expr {-$pz / $SOLAR_MASS}]
}


proc main {n} {
    if {$n eq "" || $n < 1} {set n 1000}
    set bodyNames "Sun Jupiter Saturn Uranus Neptune"

    offsetMomentum $bodyNames
    puts [format "%0.9f" [energy $bodyNames]]

    for {set i 0} {$i < $n} {incr i} {advance $bodyNames 0.01}
    puts [format "%0.9f" [energy $bodyNames]]
}

main [lindex $argv 0]
