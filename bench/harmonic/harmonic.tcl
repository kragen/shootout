#/usr/bin/tclsh
# $Id: harmonic.tcl,v 1.3 2005-09-30 16:05:42 igouy-guest Exp $
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
