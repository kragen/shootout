#!/bin/bash
# $Id: strcat.bash,v 1.2 2005-05-13 16:24:19 igouy-guest Exp $
# http://www.bagley.org/~doug/shootout/ 

NUM=$1
str=""
while [ $NUM -gt 0 ] ; do
    str="${str}hello
"
    NUM=$[ $NUM - 1 ]
done
echo ${#str}
