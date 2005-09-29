#!/usr/bin/tclsh
# $Id: pidigits.tcl,v 1.2 2005-09-29 17:36:19 igouy-guest Exp $
# http://shootout.alioth.debian.org/ 
#
# Requires bignum package from tcllib module -- however this will be
# very slow because bignum package is implemented in pure-tcl. Once
# Mpexpr extension is installed on your system, this benchmark can
# be replaced with the mpexpr version that I have submitted separately.
#
# Contributed by Hemang Lavana

package require math::bignum

proc compose {aQRST bQRST} {
    foreach {aQ aR aS aT} $aQRST break
    foreach {bQ bR bS bT} $bQRST break

    # rQ = aQ * bQ
    set rQ [::math::bignum::mul $aQ $bQ]

    # rR = aQ * bR + aR * bT
    set rR [::math::bignum::add [::math::bignum::mul $aQ $bR] [::math::bignum::mul $aR $bT]]

    # rS = aS * bQ + aT * bS
    set rS [::math::bignum::add [::math::bignum::mul $aS $bQ] [::math::bignum::mul $aT $bS]]

    # rT = aS * bR + aT * bT
    set rT [::math::bignum::add [::math::bignum::mul $aS $bR] [::math::bignum::mul $aT $bT]]

    return [list $rQ $rR $rS $rT]
}

proc produce {QRST j} {
    global big pidigit
    set D [::math::bignum::fromstr [expr {-10*$j}]]
    set INV [list $big(10) $D $big(0) $big(1)]
    return [compose $INV $QRST]
}

proc extract {QRST j} {
    foreach {Q R S T} $QRST break
    # result = (Q*J + R) / (S*J + T)
    set J [::math::bignum::fromstr $j]
    set N [::math::bignum::add [::math::bignum::mul $Q $J] $R]
    set D [::math::bignum::add [::math::bignum::mul $S $J] $T]
    set result [::math::bignum::tostr [::math::bignum::div $N $D]]
    return $result
}

proc nextX {} {
    global big pidigit
    set k [incr pidigit(k)]
    set rQ [::math::bignum::fromstr $k]
    set rR [::math::bignum::fromstr [expr {4*$k+2}]]
    set rS $big(0)
    set rT [::math::bignum::fromstr [expr {2*$k+1}]]
    return [list $rQ $rR $rS $rT]
}

proc nextPidigit {} {
    global pidigit
    set digit [extract $pidigit(z) 3]
    while {$digit != [extract $pidigit(z) 4]} {
        set pidigit(z) [compose $pidigit(z) [nextX]]
        set digit [extract $pidigit(z) 3]
    }
    set pidigit(z) [produce $pidigit(z) $digit]
    return $digit
}

proc newPidigit {} {
    global big pidigit

    set big(0)  [::math::bignum::fromstr  0]
    set big(1)  [::math::bignum::fromstr  1]
    set big(10) [::math::bignum::fromstr 10]

    set pidigit(z) [list $big(1) $big(0) $big(0) $big(1)]
    set pidigit(k) 0

    return
}

proc generatePidigits {n} {
    set pi_digits [newPidigit]
    for {set i 0} {$i < $n} {incr i} {append pi_digits [nextPidigit]}
    return $pi_digits
}

proc main {n} {
    if {$n eq "" || $n < 27} {set n 27}
    set pi_digits [generatePidigits $n]

    set width 10
    set max [expr {$n-$width}]
    set len [expr {$width-1}]
    for {set i 0} {$i < $max} {} {
        puts "[string range $pi_digits $i [incr i $len]]\t:[incr i]"
    }
    if {$i < $n} {
        puts [format "%-${width}s\t:%s" [string range $pi_digits $i $n] $n]
    }
}
main [lindex $argv 0]
