## The Computer Lannguage Shootout
## http://shootout.alioth.debian.org/
## Contributed by Donal Fellows

package require Thread

set N [lindex $argv 0]
set Nthreads 500

# Set up the worker threads to chain to each other
for {set i 0} {$i < $Nthreads} {incr i} {
    set thread [thread::create {
        proc doit x {thread::send -async $::next "doit [incr x]"}
        thread::wait
    }]
    if {$i} {thread::send $last "set next $thread"} {set first $thread}
    set last $thread
}
# Reconfigure the last worker to act as a collector
thread::send $last "set total [expr $N*$Nthreads]"
thread::send $last {
    set sum 0
    proc doit x {
        global sum total
        if {[incr sum [incr x]] >= $total} {
            puts $sum
            exit
        }
    }
}
# Inject the messages and wait for the collector to finish things off
for {set i 0} {$i < $N} {incr i} {thread::send -async $first "doit 0"}
thread::wait
