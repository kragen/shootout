#!/usr/bin/tclsh
# $Id: methcall.tcl,v 1.1 2005-04-11 18:34:14 igouy-guest Exp $
# http://shootout.alioth.debian.org/
#
# Contributed by Hemang Lavana

package require XOTcl

::xotcl::Class Toggle
Toggle instproc init {start_state} {
    ::xotcl::my instvar state
    set state $start_state
}
Toggle instproc value {} {
    ::xotcl::my instvar state
    return $state
}
Toggle instproc activate {} {
    ::xotcl::my instvar state
    set state [expr {!$state}]
    return [::xotcl::self]
}

::xotcl::Class NthToggle -superclass Toggle
NthToggle instproc init {start_state max_counter} {
    ::xotcl::next $start_state
    ::xotcl::my instvar counter count_max
    set counter 0
    set count_max $max_counter
}
NthToggle instproc activate {} {
    ::xotcl::my instvar state counter count_max
    incr counter 1
    if {$counter >= $count_max} {
        set state [expr {!$state}]
        set counter 0
    }
    return [::xotcl::self]
}

proc print_boolean {value} {
    if {$value} {
        puts "true"
    } else {
        puts "false"
    }
}

proc main {argv} {
    set n  [lindex $argv 0]

    Toggle toggle TRUE
    for {set i 0} {$i<$n} {incr i} {
        set value [[toggle activate] value]
    }
    print_boolean $value

    NthToggle ntoggle TRUE 3
    for {set i 0} {$i<$n} {incr i} {
        set value [[ntoggle activate] value]
    }
    print_boolean $value
}
main $argv
