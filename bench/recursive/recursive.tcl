# ----------------------------------------------------------------------
# The Great Computer Language Shootout
# http://shootout.alioth.debian.org/
#
# Code based on / inspired by existing, relevant Shootout submissions
#
# Contributed by Anthony Borla
# ----------------------------------------------------------------------

proc ack {n m} {
  if {$m} {
    if {$n} {
      return [ack [ack [incr n -1] $m] [incr m -1]]
    } else {
      return [ack 1 [incr m -1]]
    }
  }
  return [incr n]
}

# ---------------

proc fib {n} {
  if {$n < 2} {return 1}
  return [expr {[fib [incr n -2]] + [fib [incr n]]}]
}

proc fibflt {n} {
  if {$n < 2} {return 1}
  return [expr {[fibflt [expr {$n - 2.0}]] + [fibflt [expr {$n - 1.0}]]}]
}

# ---------------

proc tak {x y z} {
  if {$y >= $x} {return $z}
  return [tak [tak [expr {$x - 1}] $y $z] [tak [expr {$y - 1}] $z $x] [tak [expr {$z - 1}] $x $y]]
}

proc takflt {x y z} {
  if {$y >= $x} {return $z}
  return [takflt [takflt [expr {$x - 1.0}] $y $z] [takflt [expr {$y - 1.0}] $z $x] [takflt [expr {$z - 1.0}] $x $y]]
}

# ---------------------------------

interp recursionlimit {} 20000
set N [lindex $argv 0]
if {$N < 1} {set N 1}

puts [format "Ack(3,%d): %d" $N [ack 3 $N]]
puts [format "Fib(%.1f): %.1f" [expr {27.0 + $N}] [fibflt [expr {27.0 + $N}]] ]

set N [incr N -1]
puts   [format "Tak(%d,%d,%d): %d" [expr {$N * 3}] [expr {$N * 2}] $N  [tak [expr {$N * 3}] [expr {$N * 2}] $N]  ]

puts [format "Fib(3): %d" [fib 3]]
puts [format "Tak(3.0,2.0,1.0): %.1f" [takflt 3.0 2.0 1.0]]

