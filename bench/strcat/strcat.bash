#!/bin/bash
# $Id: strcat.bash,v 1.1 2004-05-19 18:13:34 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/

NUM=$1
str=""
while [ $NUM -gt 0 ] ; do
    str="${str}hello
"
    NUM=$[ $NUM - 1 ]
done
echo ${#str}
