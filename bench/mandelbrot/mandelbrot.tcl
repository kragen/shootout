#!/usr/bin/tclsh
# $Id: mandelbrot.tcl,v 1.1 2005-04-06 16:16:35 igouy-guest Exp $
# The Great Computer Language Shootout
# http://shootout.alioth.debian.org/
#
# Contributed by Hemang Lavana

proc main {argv} {
    set bit_num  0
    set byte_acc 0
    set iter     50
    set limit2   4.0
    set w [lindex $argv 0]
    set h $w

    puts stdout "P4\n$w $h"
    for {set y 0} {$y < $h} {incr y} {
        set Ci [expr {2.0 * $y / $h - 1}]
        for {set x 0} {$x < $w} {incr x} {
            set Zr 0.0
            set Zi 0.0
            set Cr [expr {2.0 * $x / $w - 1.5}]
            for {set i 0} {$i < $iter} {incr i} {
                set Tr [expr { $Zr * $Zr - $Zi * $Zi + $Cr }]
                set Ti [expr { 2.0 * $Zr * $Zi + $Ci }]
                set Zr $Tr
                set Zi $Ti
                set isOverLimit [expr {($Zr * $Zr + $Zi * $Zi) > $limit2}]
                if {$isOverLimit} break
            }
            incr bit_num
            if {$isOverLimit} {
                set byte_acc [expr {2 * $byte_acc}]
            } else {
                set byte_acc [expr {2 * $byte_acc + 1}]
            }
            if {$bit_num == "8"} {
                puts -nonewline stdout [binary format c $byte_acc]
                set bit_num  0
                set byte_acc 0
            } elseif {$x == ($w - 1)} {
                set byte_acc [expr { $byte_acc << (8 - $w % 8) }]
                puts -nonewline stdout [binary format c $byte_acc]
                set bit_num  0
                set byte_acc 0
            }
        }
    }
}

main $argv
