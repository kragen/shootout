#!/bin/bash
# $Id: hash2.bash,v 1.2 2005-05-13 16:24:17 igouy-guest Exp $
# http://www.bagley.org/~doug/shootout/ 
# from Steve Fink

n=${1:-1}

while [ $n -gt 0 ]; do
    # Initialize the array
    i=0
    while [ $i -lt 10000 ]; do
        eval H1_foo_$i=$i
        i=$[ $i + 1 ]
    done

    # Iterate through the hash values, attempting to keep to the spirit of
    # eg perl's keys %h
    for assign in $(  # Get around the subshell problem
        set | grep -a '^H1_' | cut -d= -f1 | cut -c4- | while read; do
            eval h2=\${H2_${REPLY}:-0}
            eval h1=\$H1_$REPLY
            echo H2_$REPLY=$[ $h2 + $h1 ]
        done
    ); do
        eval $assign
    done

    n=$[ $n - 1 ]
done

echo "$H1_foo_1 $H1_foo_9999 $H2_foo_1 $H2_foo_9999"
