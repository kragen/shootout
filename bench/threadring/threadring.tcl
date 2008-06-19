# The Computer Lannguage Benchmarks Game
# http://shootout.alioth.debian.org/
# contributed by Julian Noble

 set ring_size 503
 set N 10000000
 package require Thread
 set script {
    proc run {} {
    	set t -2
    	thread::mutex lock %m%
    	while {$t != -1} {
    		thread::cond wait %c% %m%
    		set t [tsv::incr TOK t -1]
    		thread::cond notify %cnext%
    	}
    	thread::mutex unlock %m%
    	puts stdout "%i%"
    	thread::send -async %main% {set ::done 1}
    	thread::cond destroy %c%
    	return
    }
    %do%
 }
 set t1 [set tnext [thread::create {thread::wait}]]
 set c1 [set c [thread::cond create]]
 set m [thread::mutex create]
 for {set i $ring_size} {$i >1} {incr i -1} {
    set cnext $c
    set c [thread::cond create]
    set tnext [thread::create [string map [list %main% [thread::id] %i% $i %m% $m %c% $c %cnext% $cnext %n% $tnext %do% run] $script]]
 }
 #close the ring
 set script [string map [list %main% [thread::id] %i% 1 %m% $m %c% $c1 %cnext% $c %n% $tnext %do% "thread::send -async [thread::id] {set ::start 1};run"] $script]
 thread::send -async $t1 $script
 vwait ::start
 after 5
 tsv::set TOK t $N
 thread::cond notify $c1
 vwait ::done 
