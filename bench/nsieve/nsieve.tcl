# The Great Computer Language Shootout
# http://shootout.alioth.debian.org/
#
# contributed by Robert Seeger and Simon Geard


package require Tcl 8.4

proc main {n} {
    foreach value [list $n [incr n -1] [incr n -1]] {
        set num [expr { int(pow(2, $value) * 10000) }]
        puts [format "Primes up to %8d %8d" $num [nsieve $num]]
    }
}

proc nsieve {n} {
    set data {}
    for {set i 0} {$i <= $n} {incr i} {
        lappend data 1
    }

    set count 0
    for {set i 2} {$i <= $n} {incr i} {
        if { [lindex $data $i] } {
            for {set j [expr {$i + $i}]} {$j <= $n} {incr j $i} {
                lset data $j 0
            }
            incr count
        }
    }
    
    return $count
}

main [lindex $argv 0]