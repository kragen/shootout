# The Computer Language Shootout
# http://shootout.alioth.debian.org/
# Contributed by Andrew McParland, based on the C# entry

proc compute {n} {
    foreach var [list a1 a2 a3 a4 a5 a6 a7 a8 a9] {
        set $var 0.0
    }
    set alt -1.0
    set twothirds [expr {2.0/3.0}]
    
    for {set k 1} {$k <= $n} {incr k} {
        set k2 [expr { pow($k,2) }]
        set k3 [expr { $k2*$k }]
        set sk [expr { sin($k) }]
        set ck [expr { cos($k) }]
        set alt [expr { -$alt }]

        set a1 [expr { $a1 + pow($twothirds,$k-1.0) }]
        set a2 [expr { $a2 + pow($k,-0.5) }]
        set a3 [expr { $a3 + 1.0/($k*($k+1.0)) }]
        set a4 [expr { $a4 + 1.0/($k3 * $sk*$sk) }]
        set a5 [expr { $a5 + 1.0/($k3 * $ck*$ck) }]
        set a6 [expr { $a6 + 1.0/$k }]
        set a7 [expr { $a7 + 1.0/$k2 }]
        set a8 [expr { $a8 + $alt/$k }]
        set a9 [expr { $a9 + $alt/(2.0*$k-1.0) }]
    }
    puts [format "%.9f\t(2/3)^k" $a1]
    puts [format "%.9f\tk^-0.5" $a2]
    puts [format "%.9f\t1/k(k+1)" $a3]
    puts [format "%.9f\tFlint Hills" $a4]
    puts [format "%.9f\tCookson Hills" $a5]
    puts [format "%.9f\tHarmonic" $a6]
    puts [format "%.9f\tRiemann Zeta" $a7]
    puts [format "%.9f\tAlternating Harmonic" $a8]
    puts [format "%.9f\tGregory" $a9]
}

compute [lindex $argv 0]
