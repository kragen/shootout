#!/bin/bash

# http://www.bagley.org/~doug/shootout/
# from David Pyke
# bash doesnt do floating point :( but we dont need it
# if we do fractional maths

#declare -r A=3877
#declare -r C=29573
#declare -r M=139968

#LAST=42

#function gen_random(){
#	LAST=$(( (($LAST * $A) + $C) % $M ))
#
#	RETVAL=$(( $1 * $LAST / $M ))
#	RETREM=$(( $1 * $LAST % $M )) 
#}

#N=$[ ${1:-1} -1 ]

#while [ $N -gt 0 ]; do
#	gen_random 100
#	N=$[ $N - 1 ]
#done
#	gen_random 100 
echo $RETVAL + $RETREM/$M

