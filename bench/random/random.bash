#!/bin/bash
# ----------------------------------------------------------------------
# The Great Computer Language Shootout
# http://shootout.alioth.debian.org/
#
# Contributed by Anthony Borla
# ----------------------------------------------------------------------

readonly IA=3877 IC=29573 IM=139968

# ------------------------------- #

function gen_seed()
{
  local S=${1} N=${2}

  for ((i=0 ; i < ${N} ; i++)) ; do
    let S=(S*IA+IC)%IM
  done

  echo ${S}
}

function gen_random()
{
  local S=${1} M=${2} PC=$((${3}+1)) PO='%0.'${3}'f\n'

  local R=`echo -e "${S} ${M} \x2A ${PC} k ${IM} / p q" | dc`

  printf ${PO} ${R}
}

# ------------------------------- #

if [ $# -ne 1 ] ; then exit 1 ; fi
if ! echo "$1" | grep -q '^[[:digit:]]*$' ; then exit 1 ; fi

gen_random `gen_seed 42 ${1}` 100 9

