#/usr/bin/tclsh
# $Id: harmonic.tcl,v 1.2 2005-09-29 17:36:19 igouy-guest Exp $
# http://shootout.alioth.debian.org/ 
#
# Contributed by Robert Seeger
proc main {inputs} {
    set n [lindex $inputs 0]
    for {set i 1 ; set result 0.0} {$i <= $n} {incr i} {
        set result [expr {$result + (1.0 / $i)}]
    }

    format "%.9f" $result
}

puts [main $argv]
