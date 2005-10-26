#!/bin/bash
# ----------------------------------------------------------------------
# The Great Computer Language Shootout
# http://shootout.alioth.debian.org/
#
# Contributed by Anthony Borla
# ----------------------------------------------------------------------

SUM=0

while read NEXT ; do
  let SUM+=NEXT
done

echo ${SUM}
