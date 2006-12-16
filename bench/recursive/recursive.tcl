# ----------------------------------------------------------------------
# The Computer Language Shootout
# http://shootout.alioth.debian.org/
#
# Contributed by Michael Schlenker
# modified by Andrew McParland
# ----------------------------------------------------------------------

proc Ack {x y} {
    expr { $x == 0 ? $y+1 : ($y == 0 ? [Ack [expr {$x-1}] 1] :
       [Ack [expr {$x-1}] [Ack $x [expr {$y -1}]]])}
}
proc Fib {n} {
    expr {$n < 2 ? 1 : [Fib [expr {$n -2}]] + [Fib [expr {$n -1}]]}
}
proc FibFP {n} {
    expr {double($n) < 2.0 ? 1.0 : [Fib [expr {$n -2.0}]] + [Fib [expr {$n -1.0}]]}
}
proc Tak {x y z} {
    expr { $y < $x ? ([Tak [Tak [expr {$x-1}] $y $z] [Tak [expr {$y-1}] $z $x] \
       [Tak [expr {$z-1}] $x $y]]) : $z }
}
proc TakFP {x y z} {
    expr { double($y) < double($x) ? double([Tak [Tak [expr {$x-1.0}] $y $z] \
       [Tak [expr {$y-1}] $z $x] [Tak [expr {$z-1}] $x $y]]) : double($z) }
}

proc main {argv} {
    set n [lindex $argv 0]
    incr n -1
    set n1 [expr {$n+1}]
    set n28 [expr {28.0+$n}]
    set n3 [expr {$n*3}]
    set n2 [expr {$n*2}]
    puts [format "Ack(3,%d): %d" $n1 [Ack 3 $n1]]
    puts [format "Fib(%.1f): %.1f" $n28 [FibFP $n28]]
    puts [format "Tak(%d,%d,%d): %d" $n3 $n2 $n [Tak $n3 $n2 $n]]
    puts [format "Fib(3): %d" [Fib 3 ]]
    puts [format "Tak(3.0,2.0,1.0): %.1f" [TakFP 3.0 2.0 1.0]]
    return 0;
}

interp recursionlimit {} 100000
main $argv
