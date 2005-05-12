#!/bin/bash
# $Id: ackermann.bash,v 1.3 2005-05-12 15:08:19 igouy-guest Exp $
# http://www.bagley.org/~doug/shootout/
# from Steve Fink

function Ack () {
    if [ $1 -eq 0 ]; then
        Ack=$[ $2 + 1 ]
    elif [ $2 -eq 0 ]; then
        Ack $[ $1 - 1 ] 1
    else
        Ack $1 $[ $2 - 1 ]
        local SubAck=$Ack
        Ack $[ $1 - 1 ] $SubAck
    fi
}

n=${1:-1}
Ack 3 $n
echo "Ack(3,$n): $Ack"
