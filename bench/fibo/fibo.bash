#!/bin/bash
# $Id: fibo.bash,v 1.2 2005-03-19 00:32:53 igouy-guest Exp $
# http://www.bagley.org/~doug/shootout/

function fib {
    if [ $1 -lt 2 ] ; then
	echo $1
    else
	echo $[ `fib $[ $1 - 2 ]` + `fib $[ $1 - 1 ]` ]
    fi
}

N=${1:-1}
fib $N
