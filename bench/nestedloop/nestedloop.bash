#!/bin/bash
# $Id: nestedloop.bash,v 1.1 2004-05-19 18:10:56 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/

let iter=1
[ ${#1} -gt 0 -a $1 -gt 0 ] && iter=$1

x=0
a=$iter
while [ $a -gt 0 ]; do a=$[$a - 1]
    b=$iter
    while [ $b -gt 0 ]; do b=$[$b - 1] 
	c=$iter
        while [ $c -gt 0 ]; do c=$[$c - 1]
	    d=$iter
            while [ $d -gt 0 ]; do d=$[$d - 1]
		e=$iter
                while [ $e -gt 0 ]; do e=$[$e - 1]
		    f=$iter
                    while [ $f -gt 0 ]; do f=$[$f - 1]
                        x=$[$x + 1]
                    done
                done
            done
        done
    done
done

echo $x
