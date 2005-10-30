#!/bin/bash
# ----------------------------------------------------------------------
# The Great Computer Language Shootout
# http://shootout.alioth.debian.org/
#
# Contributed by Anthony Borla
# ----------------------------------------------------------------------

if [ $# -ne 1 ] ; then exit 1 ; fi
if ! echo "$1" | grep -q '^[[:digit:]]*$' ; then exit 1 ; fi

N=$1 ; A=$N ; X=0

while [ $A -gt 0 ] ; do 
  B=$N ; let A-=1
  while [ $B -gt 0 ] ; do 
    C=$N ; let B-=1
    while [ $C -gt 0 ] ; do 
      D=$N ; let C-=1
      while [ $D -gt 0 ] ; do 
        E=$N ; let D-=1
        while [ $E -gt 0 ] ; do 
          F=$N ; let E-=1
          while [ $F -gt 0 ] ; do 
            let X+=1 ; let F-=1
          done
        done
      done
    done
  done
done

echo $X
