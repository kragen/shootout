## The Computer Language Benchmarks Game
## http://shootout.alioth.debian.org/
## contributed by Mark Smithfield, 
## tiny modification by Andrew McParland

proc bump { next_thread msg } {
	if { $next_thread == 0  } { expr {$msg} } else {
		$next_thread eval [list bump [expr {$msg+1}]]
	}
}
set N [lindex $argv 0]
interp recursionlimit {} 1024
for {set i 0} {$i < 500} {incr i} {
	interp create -safe thread-$i
	interp alias thread-$i bump {} bump thread-[expr {$i+1}]
}
interp alias thread-[expr {$i-1}] bump {} bump 0
set cc 0
for {set i 0} {$i < $N} {incr i} {incr cc [bump thread-0 0]}
puts $cc
