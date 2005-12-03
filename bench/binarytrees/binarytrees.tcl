#!/usr/bin/tclsh
##
## The Computer Lannguage Shootout
## http://shootout.alioth.debian.org/
## Contributed by Heiner Marxen
##
## "binary-trees"	for Tcl
## Call:	tclsh binarytrees.tcl 16
##
## $Id: binarytrees.tcl,v 1.2 2005-12-03 17:02:14 sgeard-guest Exp $

## A tree node is implemented as a [list] with 3 elements:
##	[0] left  subtree
##	[1] right subtree
##	[2] item
## An empty tree is an empty list {}, an thus has [llength] 0.

proc ItemCheck {tree} {
    if {![llength [lindex $tree 0]]} {
	return [lindex $tree 2]
    } else {
	return [expr {             [lindex $tree 2]
		      + [ItemCheck [lindex $tree 0]]
		      - [ItemCheck [lindex $tree 1]]}]
    }
}

proc BottomUpTree {item depth} {
    if {$depth > 0} {
	set ndepth [expr {$depth - 1}]
	return [list [BottomUpTree [expr {2 * $item - 1}] $ndepth] \
		     [BottomUpTree [expr {2 * $item    }] $ndepth] \
		     $item
	       ]
    } else {
	return [list {} {} $item]
    }
}

proc tellTree {typ depth check} {
    puts "$typ tree of depth $depth\t check: $check"
}

proc main {argv} {
    set N [lindex $argv 0]

    set minDepth 4

    if {($minDepth + 2) > $N} {
	set maxDepth [expr {$minDepth + 2}]
    } else {
	set maxDepth $N
    }

    set stretchDepth [expr {$maxDepth + 1}]

    set stretchTree [BottomUpTree 0 $stretchDepth]
    tellTree "stretch" $stretchDepth [ItemCheck $stretchTree]
    set stretchTree {}

    set longLivedTree [BottomUpTree 0 $maxDepth]

    for {set dep $minDepth} {$dep <= $maxDepth} {incr dep 2} {
	set iterations [expr {1 << ($maxDepth - $dep + $minDepth)}]
	set check 0
	for {set i 1} {$i <= $iterations} {incr i} {
	    set tempTree [BottomUpTree $i $dep]
	    set check [expr {$check + [ItemCheck $tempTree]}]
	    set tempTree {}

	    set tempTree [BottomUpTree [expr {-$i}] $dep]
	    set check [expr {$check + [ItemCheck $tempTree]}]
	    set tempTree {}
	}

	puts "[expr {$iterations * 2}]\t trees of depth $dep\t check: $check"
    }

    tellTree "long lived" $maxDepth [ItemCheck $longLivedTree]

    return 0
}

main $argv
