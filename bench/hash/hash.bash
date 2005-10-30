#!/bin/bash
# ----------------------------------------------------------------------
# The Great Computer Language Shootout
# http://shootout.alioth.debian.org/
#
# Contributed by Anthony Borla
# ----------------------------------------------------------------------

function d2x()
{
  printf '%x' ${1}
}

# ------------------------------- #

if [ $# -ne 1 ] ; then exit 1 ; fi
if ! echo "$1" | grep -q '^[[:digit:]]*$' ; then exit 1 ; fi

N=$1 ; C=0

for ((i=1 ; i <= ${N} ; i++)) ; do
  HASH=_`d2x ${i}` ; eval ${HASH}=${i}
done

for ((i=1 ; i <= ${N} ; i++)) ; do
  HASH=_${i} ; eval _HASH=\$$HASH
  if [ -n "${_HASH}" ] ; then let C+=1 ; fi
done

echo ${C}
