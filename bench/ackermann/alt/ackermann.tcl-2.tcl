#!/usr/bin/tclsh
# $Id: ackermann.tcl-2.tcl,v 1.1 2004-11-10 06:09:46 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/
# from Michael A. Cleverly

proc unknown {args} {
    if {![regexp {^Ack \((\d+),(\d+)\)$} [lindex $args 0] => m n]} {
        error "Invalid command name \"[lindex $args 0]\""
    }

    if {$m == 0} {
        set result [expr {$n + 1}]
    } elseif {$n == 0} {
        set result ["Ack ([expr {$m - 1}],1)"]
    } else {
        set result ["Ack ([expr {$m - 1}],["Ack ($m,[expr {$n - 1}])"])"]
    }

    proc "Ack ($m,$n)" {} "return $result"
    return $result
}

proc main {NUM} {
    if {![string is integer -strict $NUM] || $NUM < 1} {
        set NUM 1
    } elseif {$NUM > 8} {
        error "$NUM is out of range.  Should be from 1 to 8."
    }

    set result [expr {["Ack (3,0)"] + ["Ack (3,$NUM)"] - ["Ack (3,0)"]}]
    puts "Ack(3,$NUM): $result"
}

main [lindex $argv 0]
