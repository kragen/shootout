#!/bin/bash
# $Id: sumcol.bash,v 1.1 2004-05-19 18:13:43 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/

sum=0;while read num ; do sum=$[ $sum + $num ]; done ; echo $sum

