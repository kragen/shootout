#!/bin/bash
# $Id: sumcol.bash,v 1.2 2005-05-13 16:24:19 igouy-guest Exp $
# http://www.bagley.org/~doug/shootout/ 

sum=0;while read num ; do sum=$[ $sum + $num ]; done ; echo $sum

