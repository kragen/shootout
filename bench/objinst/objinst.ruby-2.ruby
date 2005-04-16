#!/usr/bin/tclsh
# $Id: objinst.ruby-2.ruby,v 1.1 2005-04-16 15:11:10 igouy-guest Exp $

# The Great Computer Language Shootout
# http://shootout.alioth.debian.org/
#
# Contributed by Yahalom emet
# Modified by Hemang Lavana

package require Itcl

::itcl::class Toggle {
    variable _state
    constructor {start_state} {set _state $start_state}
    public method value {} { return [expr {$_state ? true : false}]}
    public method activate {} { 
        set _state [expr {!$_state}] 
        return $this
    }
}

::itcl::class NthToggle {
    inherit Toggle
    variable _counter
    variable _count_max

    constructor {start_state max_counter} {Toggle::constructor $start_state} {
        set _counter 0
        set _count_max $max_counter
    }
    method activate {} {
        incr _counter 1
        if {$_counter >= $_count_max} {
            set _state [expr {!$_state}]
            set _counter 0
        }
        return $this
    }
}

proc main {n} {

    Toggle toggle TRUE
    for {set i 0} {$i<5} {incr i} {
        toggle activate
        puts [toggle value]
    }
    puts ""

    for {set i 0} {$i<$n} {incr i} {Toggle toggle$i FALSE}

    NthToggle ntoggle TRUE 3
    for {set i 0} {$i<8} {incr i} {
        ntoggle activate
        puts [ntoggle value]
    }

    for {set i 0} {$i<$n} {incr i} {NthToggle ntoggle$i TRUE 3}
}
main [lindex $argv 0]
