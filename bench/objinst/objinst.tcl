#!/usr/bin/tcl
# The Great Computer Language Shootout
#    http://shootout.alioth.debian.org/
#    contributed by Yahalom emet

#    tcl 1500000

package require Itcl
itcl::class Toggle {
    protected variable _state;
    constructor {startState} { set _state $startState; }
    public method value {} { return $_state; }
    public method activate {} { set _state [expr {!$_state}]; }
}


itcl::class NthToggle  {
    inherit Toggle
    protected variable _countMax;
    protected variable _count;

    constructor {startState max} {Toggle::constructor $startState} {
	set _countMax  $max;
	set _count  0;
    }

    public method activate {} {
	incr _count;
	if {$_count >= $_countMax} {
	    set _state  [expr {!$_state}]
	    set _count  0;
	}
    }
}

set n  [lindex $argv 0]

Toggle toggle TRUE;
for {set i 0} {$i<5} {incr i} {
    toggle activate;
    if {[toggle value]} {
	puts "true"
    } else {
	puts "false";
    }
}
puts ""

for {set i 0} {$i<$n} {incr i} {
    Toggle toggle$i 0
}

NthToggle ntoggle TRUE 3;
for {set i 0} {$i<8} {incr i} {
    ntoggle activate;
    if {[ntoggle value]} {
	puts "true"
    } else {
	puts "false";
    }
}

for {set i 0} {$i<$n} {incr i} {
    NthToggle ntoggle$i TRUE 3
}
