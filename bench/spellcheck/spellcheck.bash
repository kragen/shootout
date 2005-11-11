#!/bin/bash
# ----------------------------------------------------------------------
# The Great Computer Language Shootout
# http://shootout.alioth.debian.org/
#
# Contributed by Anthony Borla
# ----------------------------------------------------------------------

DICT="Usr.Dict.Words"

while read WORD ; do
  eval ${WORD}=1
done < $DICT

while read WORD ; do
  eval _WORD=\$$WORD ; if [ -z "${_WORD}" ] ; then echo ${WORD} ; fi
done
