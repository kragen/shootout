#!/bin/bash
# ----------------------------------------------------------------------
# The Great Computer Language Shootout
# http://shootout.alioth.debian.org/
#
# Contributed by Anthony Borla
# ----------------------------------------------------------------------

declare -a LINES ; COUNT=1

while read LINES[$COUNT] ; do let COUNT+=1 ; done

let COUNT-=1 ; until [ "$COUNT" -eq "0" ] ; do
  echo ${LINES[$COUNT]} ; let COUNT-=1
done
