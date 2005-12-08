#!/usr/bin/tclsh
# The Computer Language Shootout
# http://shootout.alioth.debian.org/
# contributed by Donald Arseneau

proc main {} {
    set sum 0
    catch {
        while {1} { incr sum [gets stdin] }
    }
    puts $sum
}

main
