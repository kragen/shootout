#!/bin/bash
# http://shootout.alioth.debian.org/

# this program is modified from:
#   http://cm.bell-labs.com/cm/cs/who/bwk/interps/pap.html
# Timing Trials, or, the Trials of Timing: Experiments with Scripting
# and User-Interface Languages by Brian W. Kernighan and
# Christopher J. Van Wyk.

# this version creates a $cnt vairable for the for loop
# Bash version (samething) by David Pyke JUL-20 

n=${1:-1}

declare -ai X
declare -ai Y
declare -i j
declare -i i
declare -i last

last=$(($n-1));
cnt=

i=0;
while [ $i -le $last  ] ; do
	j=$(($i+1));
	X[$i]=$j;
	cnt="$i $cnt"
	i=$j;
done

k=0;
while [ $k -le 999  ] ; do

	for i in $cnt; do
		Y[$i]=$((${Y[$i]} + ${X[$i]}));
	done;

	k=$(( $k + 1));
done

echo "${Y[0]} ${Y[$last]}"


