#!/bin/bash
# ----------------------------------------------------------------------
# The Great Computer Language Shootout
# http://shootout.alioth.debian.org/
#
# Contributed by Anthony Borla
# ----------------------------------------------------------------------

readonly PADDING=2

function words() { echo -n "$#" ; }

IFS= ; LINES=0 ; WORDS=0 ; CHARS=0

while read NEXTLINE ; do
  let LINES+=1 ; let WORDS+=`IFS=' ' ; words $NEXTLINE`
  let CHARS=CHARS+${#NEXTLINE}+PADDING
done

echo "${LINES} ${WORDS} ${CHARS}"
